CREATE OR REPLACE PROCEDURE UBILL.DPD_MRS_DATA_TRANS (
   v_rec_BILL_CYCLE_CODE    VARCHAR2,
   v_rec_DIV_CODE           VARCHAR2)
IS
   v_rec_RUN_ID     NUMBER;
   v_rec_ERR_NO     NUMBER;
   v_rec_ERR_ERRM   VARCHAR2 (500);
   v_max_demand     NUMBER;
   v_count          NUMBER;
   V_CUST_ID        NUMBER;
   V_PF             NUMBER (20, 4) := .95;
   V_READING_DATE   DATE;
   v_pfc            NUMBER := 0;
   v_meter_num      VARCHAR2 (20);

   CURSOR v_all_reading
   IS
      SELECT h.ENTRY_ID AS ENTRY_ID,
             H.CUSTOMER_NUM,
             D.CUST_ENT_ID,
             h.BILL_CYCLE_CODE,
             d.METER_NUM_KVARH,
             ADD_MONTHS (TO_DATE (h.bill_cycle_code, 'RRRRMM'), 1)
                READING_DATE,
             d.METER_NUM,
             NVL (OPN_KWH_RDNG, 0) OPN_KWH_RDNG,
             NVL (CLS_KWH_SR_RDNG, 0) CLS_KWH_SR_RDNG,
             NVL (CONS_KWH_SR, 0) CONS_KWH_SR,
             ADJUST_UNIT,
             METER_COND,
             CF,
             OMF,
             LINE_LOSS,
             NVL (TOTAL_ENERGY_KWH, 0) TOTAL_ENERGY_KWH,
             NVL (OPN_KVARH_RDNG, 0) OPN_KVARH_RDNG,
             NVL (CLS_KVARH_RDNG, 0) CLS_KVARH_RDNG,
             NVL (CONS_KVARH_SR, 0) CONS_KVARH_SR,
             METER_COND_KVARH,
             NVL (TOTAL_KVARH, 0) TOTAL_KVARH,
             AVG_PF,
             PFC,
             OMF_KVARH,
             ENERGY_FOR_PFC,
             CORRECTED_TOTAL_ENERGY_KWH,
             TIME_CYCLE_CODE,
             TOD_CODE,
             READING_TYPE_CODE,
             Bus_loss,
             b.VOLTAGE_CATEGORY_CODE,
             NVL (d.UNIT_TYPE, 'EXP') UNIT_TYPE,
             NVL (l.MAX_PF, 0.9) MAX_PF,
             d.PFC_ADJ_UNIT,
             d.KVARH_ADJ
        FROM BC_UTILITY_BILL_ENTRY_DTL d,
             BC_UTILITY_BILL_ENTRY_HDR h,
             BC_METER_GRID_CK_COMB_BILL_DTL b,
             BC_METER_LOCATION l
       WHERE     h.ENTRY_ID = D.ENTRY_ID
             AND d.EQUIP_ID = b.EQUIP_ID
             AND l.METER_LOCATION_CODE = b.METER_LOCATION
             AND H.GRID_ID IN (SELECT grid_id
                                 FROM BC_METER_GRID_CK_COMB_BILL_MST
                                WHERE div_code = v_rec_DIV_CODE)
             AND NVL (d.UNIT_TYPE, 'EXP') = 'EXP'
            -- and D.EQUIP_ID=77157
             AND h.bill_cycle_code = v_rec_BILL_CYCLE_CODE;
BEGIN
   SELECT BC_RUN_ID_SEQ.NEXTVAL INTO v_rec_RUN_ID FROM DUAL;

   SELECT COUNT (1)
     INTO v_count
     FROM BC_UTILITY_BILL_ENTRY_DTL d, BC_UTILITY_BILL_ENTRY_HDR h
    WHERE     h.ENTRY_ID = D.ENTRY_ID
          AND H.GRID_ID IN (SELECT grid_id
                              FROM BC_METER_GRID_CK_COMB_BILL_MST
                             WHERE div_code = v_rec_DIV_CODE)
          -- AND D.REC_STATUS='L'
          AND h.bill_cycle_code = v_rec_BILL_CYCLE_CODE;

   IF v_count = 0
   THEN
      v_rec_ERR_ERRM := 'Data trans error:- No Record For Update.';

      INSERT INTO BC_ERR_LOG (RUN_ID,
                              ERROR_NO,
                              ERROR_TXT,
                              DATA_TYPE,
                              RUN_BY,
                              RUN_DATE,
                              STATUS)
           VALUES (v_rec_RUN_ID,
                   78666,
                   v_rec_ERR_ERRM,
                   'MRS',
                   USER,
                   SYSDATE,
                   'N');

      COMMIT;
   ELSE
      FOR c1 IN v_all_reading
      LOOP
         SELECT ROUND (EMP.FPD_PF_CALCULATION (
                          c1.CONS_KVARH_SR * C1.CF + c1.KVARH_ADJ,
                          c1.OMF_KVARH,
                          c1.CONS_KWH_SR * c1.CF,
                          c1.OMF,
                          NULL),
                       4)
           INTO V_PF
           FROM SYS.DUAL;

         ---------READING FOR ENERGY METER (EXP)-------------
         v_meter_num := c1.METER_NUM;


         --V_PFC:=ROUND(ABS(c1.MAX_PF/case when LEAST(V_PF,c1.MAX_PF)-1=0 then 1 else LEAST(V_PF,c1.MAX_PF)-1 end),4);

         V_PFC := ROUND (ABS (c1.MAX_PF / LEAST (V_PF, c1.MAX_PF) - 1), 4);



         UPDATE ebc.bc_meter_reading_card_dtl
            SET POWER_FACTOR = V_PF,
                NET_POWER_FACTOR = V_PF,
                BATCH_PROCESS_FLAG = 'C',
                reading_date = c1.reading_date,
                OPN_READING = c1.OPN_KWH_RDNG,
                CLS_READING = c1.CLS_KWH_SR_RDNG,
                ADVANCE = c1.CONS_KWH_SR,
                LOSS_CONSUMPTION = c1.ADJUST_UNIT,
                DEFECTIVE_CODE = C1.METER_COND,
                BILLED_VALUE = ROUND (c1.CONS_KWH_SR * C1.CF * c1.OMF),
                NET_VALUE = ROUND (c1.CONS_KWH_SR * C1.CF * c1.OMF),
                cf = C1.CF,
                PFC = V_PFC,
                PFC_ADJ_UNIT = c1.PFC_ADJ_UNIT,
                OVERALL_MF = c1.OMF,
                line_loss =
                   DECODE (NVL (c1.line_loss, 0), 0, line_loss, c1.line_loss),
                bus_loss =
                   DECODE (NVL (c1.Bus_loss, 0), 0, Bus_loss, c1.Bus_loss),
                VOLTAGE_CATEGORY_CODE = c1.VOLTAGE_CATEGORY_CODE
          WHERE     METER_ID IN (SELECT EQUIP_ID
                                   FROM ebc.bc_customer_meter
                                  WHERE meter_num = c1.METER_NUM)
                AND bill_cycle_code = c1.bill_cycle_code
                AND meter_type_code = '04'
                AND TIME_CYCLE_CODE = C1.TIME_CYCLE_CODE
                AND TOD_CODE = C1.TOD_CODE
                AND READING_TYPE_CODE = C1.READING_TYPE_CODE;

         ---------READING FOR KVARH METER (EXP)-------------

         UPDATE bc_meter_reading_card_dtl
            SET                              --CLS_READING=c1.CLS_KWH_SR_RDNG,
               BATCH_PROCESS_FLAG = 'C',
                reading_date = c1.reading_date,
                OPN_READING = c1.OPN_KVARH_RDNG,
                CLS_READING = c1.CLS_KVARH_RDNG,
                ADVANCE = c1.CONS_KVARH_SR,
                LOSS_CONSUMPTION = c1.KVARH_ADJ,
                DEFECTIVE_CODE = C1.METER_COND_KVARH,
                BILLED_VALUE = ROUND (c1.CONS_KVARH_SR * c1.OMF_KVARH),
                NET_VALUE = ROUND (c1.CONS_KVARH_SR * c1.OMF_KVARH),
                cf = C1.CF,
                OVERALL_MF = c1.OMF,
                VOLTAGE_CATEGORY_CODE = c1.VOLTAGE_CATEGORY_CODE
          WHERE     METER_ID IN (SELECT EQUIP_ID
                                   FROM ebc.bc_customer_meter
                                  WHERE meter_num = c1.METER_NUM_KVARH)
                AND bill_cycle_code = c1.bill_cycle_code
                AND meter_type_code = '12'
                AND TIME_CYCLE_CODE = C1.TIME_CYCLE_CODE
                AND TOD_CODE = C1.TOD_CODE
                AND READING_TYPE_CODE = 5;             --C1.READING_TYPE_CODE;



         UPDATE BC_UTILITY_BILL_ENTRY_DTL
            SET rec_status = 'F'
          WHERE CUST_ENT_ID = C1.CUST_ENT_ID;
      END LOOP;



      FOR C3
         IN (SELECT CUST_ENT_ID,
                    d.METER_NUM,
                    d.METER_NUM_KVARH,
                    NVL (d.CONS_KWH_SR, 0) CONS_KWH_SR,
                    NVL (d.CF, 1) AS CF,
                    NVL (d.OMF, 1) OMF,
                    NVL (d.CONS_KVARH_SR, 0) CONS_KVARH_SR,
                    NVL (d.OMF_KVARH, 1) OMF_KVARH,
                    NVL (d.ADJUST_UNIT, 0) ADJUST_UNIT,
                    d.KVARH_ADJ
               FROM ubill.BC_UTILITY_BILL_ENTRY_DTL d,
                    ubill.BC_UTILITY_BILL_ENTRY_HDR h,  BC_METER_GRID_CK_COMB_BILL_DTL c
              WHERE     h.ENTRY_ID = D.ENTRY_ID
                    and D.EQUIP_ID=C.EQUIP_ID
                    AND H.GRID_ID IN (SELECT grid_id
                                        FROM BC_METER_GRID_CK_COMB_BILL_MST
                                       WHERE div_code = v_rec_DIV_CODE)
                    AND h.bill_cycle_code = v_rec_BILL_CYCLE_CODE
                    --and D.EQUIP_ID=77157
                    AND METER_FLOW_TYPE LIKE '%IMP%')
      LOOP
         -------------LOSS FOR KWH METER------------

         UPDATE bc_meter_reading_card_dtl
            SET LOSS_CONSUMPTION =
                   -ROUND (
                       NVL (LOSS_CONSUMPTION, 0)
                       + (C3.CONS_KWH_SR * C3.CF * C3.OMF))
          WHERE     METER_ID IN (SELECT EQUIP_ID
                                   FROM ebc.bc_customer_meter
                                  WHERE meter_num = c3.METER_NUM)
                AND bill_cycle_code = v_rec_BILL_CYCLE_CODE ------------------------------------------
                AND meter_type_code = '04';

         ---------------LOSS FOR KVARH METER----------

         UPDATE bc_meter_reading_card_dtl
            SET LOSS_CONSUMPTION =
                   -ROUND (
                         NVL (LOSS_CONSUMPTION, 0)
                       + (C3.CONS_KVARH_SR * C3.OMF)
                       - NVL (c3.KVARH_ADJ, 0))
          WHERE     METER_ID IN (SELECT EQUIP_ID
                                   FROM ebc.bc_customer_meter
                                  WHERE meter_num = c3.METER_NUM)
                AND bill_cycle_code = v_rec_BILL_CYCLE_CODE ------------------------------------------
                AND meter_type_code = '12';

         IF NVL (C3.ADJUST_UNIT, 0) <> 0
         THEN
            -------------LOSS FOR KWH METER------------

            UPDATE bc_meter_reading_card_dtl
               SET LOSS_CONSUMPTION =
                      ROUND (NVL (LOSS_CONSUMPTION, 0)- C3.ADJUST_UNIT)
             WHERE     METER_ID IN (SELECT EQUIP_ID
                                      FROM bc_customer_meter
                                     WHERE meter_num = c3.METER_NUM)
                   AND bill_cycle_code = v_rec_BILL_CYCLE_CODE ------------------------------------------
                   AND meter_type_code = '04';

            ---------------LOSS FOR KVARH METER----------

            UPDATE bc_meter_reading_card_dtl
               SET LOSS_CONSUMPTION =
                      ROUND (
                         NVL (LOSS_CONSUMPTION, 0) -NVL (c3.KVARH_ADJ, 0))
             WHERE     METER_ID IN (SELECT EQUIP_ID
                                      FROM bc_customer_meter
                                     WHERE meter_num = c3.METER_NUM)
                   AND bill_cycle_code = v_rec_BILL_CYCLE_CODE ------------------------------------------
                   AND meter_type_code = '12';
         END IF;

         UPDATE BC_UTILITY_BILL_ENTRY_DTL
            SET rec_status = 'F'
          WHERE CUST_ENT_ID = C3.CUST_ENT_ID;
      END LOOP;

      UPDATE BC_UTILITY_BILL_ENTRY_HDR
         SET rec_status = 'F'
       WHERE grid_id IN (SELECT grid_Id
                           FROM BC_METER_GRID_CK_COMB_BILL_MST
                          WHERE div_code = v_rec_DIV_CODE)
             AND bill_cycle_code = v_rec_BILL_CYCLE_CODE;

      UPDATE bc_customer_event_log
         SET MRS_ENTRY_DATE = SYSDATE,
             OVERALL_PROC_DATE = SYSDATE,
             OVERALL_FINAL_DATE = SYSDATE
       WHERE /*cust_id not in(select b.cust_id from BC_UTILITY_BILL_ENTRY_DTL a,bc_customer_meter@DBL_UBILL b,BC_UTILITY_BILL_ENTRY_HDR c
                        where --- a.REC_STATUS<>'F'
                         c.BILL_CYCLE_CODE=v_rec_BILL_CYCLE_CODE
                        and a.EQUIP_ID=b.equip_id
                        and a.ENTRY_ID=c.ENTRY_ID
                        and c.grid_id in (select grid_Id from BC_METER_GRID_CK_COMB_BILL_MST where div_code=v_rec_DIV_CODE))*/
                        
            cust_id IN
                (SELECT b.cust_id
                   FROM BC_UTILITY_BILL_ENTRY_DTL a,
                        ebc.bc_customer_meter b,
                        BC_UTILITY_BILL_ENTRY_HDR c
                  WHERE     c.BILL_CYCLE_CODE = v_rec_BILL_CYCLE_CODE
                        AND a.EQUIP_ID = b.equip_id
                        AND a.ENTRY_ID = c.ENTRY_ID
                        AND c.grid_id IN (SELECT grid_Id
                                            FROM BC_METER_GRID_CK_COMB_BILL_MST
                                           WHERE div_code = v_rec_DIV_CODE))
             AND bill_cycle_code = v_rec_BILL_CYCLE_CODE;



      UPDATE BC_INVOICE_HDR
         SET REC_STATUS = 'M'
       WHERE /*cust_id not in(select b.cust_id from BC_UTILITY_BILL_ENTRY_DTL a,bc_customer_meter@DBL_UBILL b,BC_UTILITY_BILL_ENTRY_HDR c
                       where a.REC_STATUS<>'F'
                       and c.BILL_CYCLE_CODE=v_rec_BILL_CYCLE_CODE
                       and a.EQUIP_ID=b.equip_id
                       and a.ENTRY_ID=c.ENTRY_ID
                       and c.grid_id in (select grid_Id from BC_METER_GRID_CK_COMB_BILL_MST where div_code=v_rec_DIV_CODE))*/
            cust_id IN
                (SELECT b.cust_id
                   FROM BC_UTILITY_BILL_ENTRY_DTL a,
                        ebc.bc_customer_meter b,
                        BC_UTILITY_BILL_ENTRY_HDR c
                  WHERE     c.BILL_CYCLE_CODE = v_rec_BILL_CYCLE_CODE
                        AND a.EQUIP_ID = b.equip_id
                        AND a.ENTRY_ID = c.ENTRY_ID
                        AND c.grid_id IN (SELECT grid_Id
                                            FROM BC_METER_GRID_CK_COMB_BILL_MST
                                           WHERE div_code = v_rec_DIV_CODE))
             AND bill_cycle_code = v_rec_BILL_CYCLE_CODE
             AND REC_STATUS <> 'D';

      COMMIT;
   END IF;

   UBILL.DPG_LLFACT_LINE_BUSS_LOSS_CALC.DPD_LLFACT_LINE_BUSS_LOSS_CALC (
      v_rec_BILL_CYCLE_CODE,
      v_rec_DIV_CODE);

   UPDATE bc_meter_reading_card_dtl
      SET pfc_unit =
             pfc
             * DECODE (SIGN (NVL (net_value, 0) + NVL (LOSS_CONSUMPTION, 0)),
                       -1, 0,
                       NVL (net_value, 0) + NVL (LOSS_CONSUMPTION, 0))
    WHERE /*cust_id not in(select b.cust_id from BC_UTILITY_BILL_ENTRY_DTL a,bc_customer_meter@DBL_UBILL b,BC_UTILITY_BILL_ENTRY_HDR c
                                where a.REC_STATUS<>'F'
                                and c.BILL_CYCLE_CODE=v_rec_BILL_CYCLE_CODE
                                and a.EQUIP_ID=b.equip_id
                                and a.ENTRY_ID=c.ENTRY_ID
                                and c.grid_id in (select grid_Id from BC_METER_GRID_CK_COMB_BILL_MST where div_code=v_rec_DIV_CODE))*/
         cust_id IN
             (SELECT b.cust_id
                FROM BC_UTILITY_BILL_ENTRY_DTL a,
                     ebc.bc_customer_meter b,
                     BC_UTILITY_BILL_ENTRY_HDR c
               WHERE     c.BILL_CYCLE_CODE = v_rec_BILL_CYCLE_CODE
                     AND a.EQUIP_ID = b.equip_id
                     AND a.ENTRY_ID = c.ENTRY_ID
                     AND c.grid_id IN (SELECT grid_Id
                                         FROM BC_METER_GRID_CK_COMB_BILL_MST
                                        WHERE div_code = v_rec_DIV_CODE))
          AND reading_type_code = 2
          AND bill_cycle_code = v_rec_BILL_CYCLE_CODE--and (nvl(net_value,0)+NVL(LOSS_CONSUMPTION,0))>0
   ;
EXCEPTION
   WHEN OTHERS
   THEN
      ROLLBACK;
      v_rec_ERR_NO := SQLCODE;
      v_rec_ERR_ERRM := v_meter_num || '-' || SUBSTR (SQLERRM, 1, 500);

      INSERT INTO BC_ERR_LOG (RUN_ID,
                              ERROR_NO,
                              ERROR_TXT,
                              DATA_TYPE,
                              RUN_BY,
                              RUN_DATE,
                              STATUS)
           VALUES (v_rec_RUN_ID,
                   v_rec_ERR_NO,
                   v_rec_ERR_ERRM,
                   'MRS',
                   USER,
                   SYSDATE,
                   'N');

      COMMIT;
END;
/