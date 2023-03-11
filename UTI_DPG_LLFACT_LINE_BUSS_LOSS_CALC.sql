CREATE OR REPLACE PACKAGE BODY UBILL.DPG_LLFACT_LINE_BUSS_LOSS_CALC IS

PROCEDURE DPD_LLFACT_LINE_BUSS_LOSS_CALC(pvc_billcycle      IN VARCHAR2, pvc_div_code varchar2) IS

v_Tot_Child_Meter_Cons NUMBER; 
v_Tot_Child_Meter_Cons_Length NUMBER;
v_Line_Length NUMBER;
v_LLFACTOR NUMBER;
v_Tot_Parent_Meter_Cons NUMBER;
v_Tot_CK_Meter_Cons NUMBER;
v_Tot_BILL_Meter_Cons NUMBER; 
v_Total_Loss_Cons NUMBER;
v_Total_bus_Loss_Cons  number;
v_Total_line_Loss_Cons  number;

BEGIN
       
update BC_METER_READING_CARD_DTL
  SET LOSS_CONSUMPTION=0,line_loss_adj=0,bus_loss_adj=0
where bill_cycle_code=pvc_billcycle
and meter_id not  in (
select equip_id from BC_UTILITY_BILL_ENTRY_DTL
where ENTRY_ID in (select entry_id from BC_UTILITY_BILL_ENTRY_hdr where bill_cycle_code=pvc_billcycle
and grid_id in (select grid_id from BC_METER_GRID_CK_COMB_BILL_MST
where DIV_CODE=pvc_DIV_CODE))
and nvl(adjust_unit,0)<>0
)
and  meter_id   in (
select equip_id from BC_UTILITY_BILL_ENTRY_DTL
where ENTRY_ID in (select entry_id from BC_UTILITY_BILL_ENTRY_hdr where bill_cycle_code=pvc_billcycle
and grid_id in (select grid_id from BC_METER_GRID_CK_COMB_BILL_MST
where DIV_CODE=pvc_DIV_CODE
)));


/*
 
        FOR CUR_LOC IN(SELECT METER_LOCATION_CODE,METER_LOCATION_ID,TIME_CYCLE_CODE FROM BC_METER_LOCATION ,BC_TIME_CYCLE_CODE@DBL_UBILL
                       WHERE METER_LOCATION_CODE IN(SELECT METER_LOCATION FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                    WHERE EQUIP_ID IN(SELECT MEter_id FROM BC_METER_READING_CARD_DTL@DBL_UBILL
                                                                      WHERE BILL_CYCLE_CODE=pvc_billcycle
                                                                      AND READING_TYPE_CODE='2')
                                                     AND METER_TYPE='COMB'                 
                                                    )
                       AND TIME_CYCLE_CODE IN (1,2,3))
                                                      
        LOOP
        
                    v_Tot_Parent_Meter_Cons:=0;
                    
                    FOR CUR_MST_LLFACT IN(SELECT METER_ID,CUST_ID,CAT_ID,BILL_CYCLE_CODE,TIME_CYCLE_CODE,
                                          TOD_CODE,OPN_READING,CLS_READING,ADVANCE,OVERALL_MF,CF
                                          FROM BC_METER_READING_CARD_DTL@DBL_UBILL
                                          WHERE BILL_CYCLE_CODE=pvc_billcycle
                                          AND READING_TYPE_CODE='2'
                                          AND TIME_CYCLE_CODE=CUR_LOC.TIME_CYCLE_CODE
                                          AND METER_ID IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                          WHERE METER_TYPE='COMB')
                                          AND METER_ID IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                          WHERE METER_LOCATION=CUR_LOC.METER_LOCATION_CODE )
                                          )
                    LOOP

                        v_Tot_Parent_Meter_Cons:=v_Tot_Parent_Meter_Cons+NVL(CUR_MST_LLFACT.ADVANCE,0)*NVL(CUR_MST_LLFACT.OVERALL_MF,0)*NVL(CUR_MST_LLFACT.CF,1);
                        
                    END LOOP;
                    
                    
                        v_Tot_Child_Meter_Cons:=0;
                        v_Tot_Child_Meter_Cons_Length:=0;
                        
                    FOR CUR_DTL_LLFACT IN(SELECT METER_ID,CUST_ID,CAT_ID,BILL_CYCLE_CODE,TIME_CYCLE_CODE,
                                              TOD_CODE,OPN_READING,CLS_READING,ADVANCE,OVERALL_MF,CF
                                              FROM BC_METER_READING_CARD_DTL@DBL_UBILL
                                              WHERE BILL_CYCLE_CODE=pvc_billcycle
                                              AND READING_TYPE_CODE='2'
                                              AND TIME_CYCLE_CODE=CUR_LOC.TIME_CYCLE_CODE
                                              AND METER_ID IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                              WHERE METER_TYPE='BILL')
                                              AND METER_ID NOT IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                                    WHERE METER_LOCATION IN(
                                                                    SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION 
                                                                    WHERE METER_PARENT_LOCATION_ID IN(        
                                                                    SELECT METER_LOCATION_ID FROM BC_METER_LOCATION
                                                                    WHERE METER_LOCATION_CODE IN(
                                                                    SELECT METER_LOCATION FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                                    WHERE METER_LOCATION IN(
                                                                    SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION
                                                                    WHERE METER_LOCATION_ID IN(SELECT METER_PARENT_LOCATION_ID FROM BC_METER_LOCATION))
                                                                    AND METER_TYPE='BILL')))) 
                                              AND METER_ID IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL 
                                                              WHERE METER_LOCATION IN(SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION
                                                                                      WHERE METER_PARENT_LOCATION_ID=CUR_LOC.METER_LOCATION_ID))
                                          )
                        LOOP
                        
                        
                          BEGIN
                          
                          
                              SELECT NVL(METER_LINE_LENGTH,0) INTO v_Line_Length 
                              FROM BC_METER_GRID_CK_COMB_BILL_DTL
                              WHERE EQUIP_ID=CUR_DTL_LLFACT.METER_ID
                              AND CUST_ID=CUR_DTL_LLFACT.CUST_ID;
                          
                          EXCEPTION
                          
                             WHEN OTHERS THEN 
                             
                                v_Line_Length:=0;
                                
                          END;
                          
                          
                           v_Tot_Child_Meter_Cons:=v_Tot_Child_Meter_Cons+NVL(CUR_DTL_LLFACT.ADVANCE,0)*NVL(CUR_DTL_LLFACT.OVERALL_MF,0)*NVL(CUR_DTL_LLFACT.CF,1);
                           v_Tot_Child_Meter_Cons_Length:=v_Tot_Child_Meter_Cons_Length+NVL(CUR_DTL_LLFACT.ADVANCE,0)*NVL(CUR_DTL_LLFACT.OVERALL_MF,0)*NVL(CUR_DTL_LLFACT.CF,1)*v_Line_Length;
                        
                        END LOOP;
                        
                        
                        
                        IF NVL(v_Tot_Child_Meter_Cons_Length,0)>0 THEN
                        
                          v_LLFACTOR:=(v_Tot_Parent_Meter_Cons-NVL(v_Tot_Child_Meter_Cons,0))/v_Tot_Child_Meter_Cons_Length;
                          
                        ELSE
                          
                          v_LLFACTOR:=0;
                          
                        END IF;
                        
                        
                        
                        
                        
                        
                        FOR CUR_DTL_LLFACT_UP IN(SELECT METER_ID,CUST_ID,CAT_ID,BILL_CYCLE_CODE,TIME_CYCLE_CODE,
                                              TOD_CODE,OPN_READING,CLS_READING,ADVANCE,OVERALL_MF,CF
                                              FROM BC_METER_READING_CARD_DTL@DBL_UBILL
                                              WHERE BILL_CYCLE_CODE=pvc_billcycle
                                              AND READING_TYPE_CODE='2'
                                              AND TIME_CYCLE_CODE=CUR_LOC.TIME_CYCLE_CODE
                                              AND METER_ID IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                              WHERE METER_TYPE='BILL')
                                              AND METER_ID NOT IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                                    WHERE METER_LOCATION IN(
                                                                    SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION 
                                                                    WHERE METER_PARENT_LOCATION_ID IN(        
                                                                    SELECT METER_LOCATION_ID FROM BC_METER_LOCATION
                                                                    WHERE METER_LOCATION_CODE IN(
                                                                    SELECT METER_LOCATION FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                                    WHERE METER_LOCATION IN(
                                                                    SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION
                                                                    WHERE METER_LOCATION_ID IN(SELECT METER_PARENT_LOCATION_ID FROM BC_METER_LOCATION))
                                                                    AND METER_TYPE='BILL')))) 
                                              AND METER_ID IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL 
                                                              WHERE METER_LOCATION IN(SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION
                                                                                      WHERE METER_PARENT_LOCATION_ID=CUR_LOC.METER_LOCATION_ID))
                                          )
                       LOOP
                           
                            
                           BEGIN
                          
                          
                              SELECT NVL(METER_LINE_LENGTH,0) INTO v_Line_Length 
                              FROM BC_METER_GRID_CK_COMB_BILL_DTL
                              WHERE EQUIP_ID=CUR_DTL_LLFACT_UP.METER_ID
                              AND CUST_ID=CUR_DTL_LLFACT_UP.CUST_ID;
                          
                           EXCEPTION
                          
                             WHEN OTHERS THEN 
                             
                                v_Line_Length:=0;
                                
                           END;
                           
                           
                           
                           
                           UPDATE BC_METER_READING_CARD_DTL
                            SET LL_FACTOR=ROUND(v_LLFACTOR,5),LINE_LOSS=ROUND(NVL(CUR_DTL_LLFACT_UP.ADVANCE,0)*NVL(CUR_DTL_LLFACT_UP.OVERALL_MF,0)*NVL(CUR_DTL_LLFACT_UP.CF,1)*v_LLFACTOR*v_Line_Length)
                            WHERE BILL_CYCLE_CODE=pvc_billcycle
                            AND READING_TYPE_CODE='2'
                            AND TIME_CYCLE_CODE=CUR_LOC.TIME_CYCLE_CODE
                            AND TIME_CYCLE_CODE=CUR_DTL_LLFACT_UP.TIME_CYCLE_CODE
                            AND METER_ID=CUR_DTL_LLFACT_UP.METER_ID
                            AND CUST_ID=CUR_DTL_LLFACT_UP.CUST_ID;
                            
                            null;
                            
                            
                                   
                           
                       END LOOP;
                           
                           
                           
               

        
                    
        END LOOP;
        
        
COMMIT;


 FOR CUR_GRID IN(SELECT GRID_ID,TIME_CYCLE_CODE FROM BC_METER_GRID_CK_COMB_BILL_MST,BC_TIME_CYCLE_CODE@DBL_UBILL
                WHERE GRID_ID IN(SELECT GRID_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                  WHERE EQUIP_ID IN(SELECT METER_id FROM BC_METER_READING_CARD_DTL@DBL_UBILL
                                                  WHERE BILL_CYCLE_CODE=pvc_billcycle
                                                  AND READING_TYPE_CODE='2')
               AND TIME_CYCLE_CODE IN (1,2,3))
               
               )
               
               
 LOOP
 
 
  v_Tot_CK_Meter_Cons:=0;
  
  FOR CUR_CK_CONS IN(SELECT METER_ID,CUST_ID,CAT_ID,BILL_CYCLE_CODE,TIME_CYCLE_CODE,
                                          TOD_CODE,OPN_READING,CLS_READING,ADVANCE,OVERALL_MF,CF
                                          FROM BC_METER_READING_CARD_DTL@DBL_UBILL
                                          WHERE BILL_CYCLE_CODE=pvc_billcycle
                                          AND READING_TYPE_CODE='2'
                                          AND TIME_CYCLE_CODE=CUR_GRID.TIME_CYCLE_CODE
                                          AND METER_ID IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                          WHERE METER_TYPE='CK'
                                                          AND GRID_ID=CUR_GRID.GRID_ID)
                                          
                                          )
    LOOP

        v_Tot_CK_Meter_Cons:=v_Tot_CK_Meter_Cons+NVL(CUR_CK_CONS.ADVANCE,0)*NVL(CUR_CK_CONS.OVERALL_MF,0)*NVL(CUR_CK_CONS.CF,1);
                            
    END LOOP;
    
    v_Tot_Bill_Meter_Cons:=0;
    
    FOR CUR_BILL_CONS IN(SELECT METER_ID,CUST_ID,CAT_ID,BILL_CYCLE_CODE,TIME_CYCLE_CODE,
                                          TOD_CODE,OPN_READING,CLS_READING,ADVANCE,OVERALL_MF,CF
                                          FROM BC_METER_READING_CARD_DTL@DBL_UBILL
                                          WHERE BILL_CYCLE_CODE=pvc_billcycle
                                          AND READING_TYPE_CODE='2'
                                          AND TIME_CYCLE_CODE=CUR_GRID.TIME_CYCLE_CODE
                                          AND METER_ID IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                          WHERE METER_TYPE='BILL'
                                                          AND GRID_ID=CUR_GRID.GRID_ID)
                                          AND METER_ID NOT IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                                    WHERE METER_LOCATION IN(
                                                                    SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION 
                                                                    WHERE METER_PARENT_LOCATION_ID IN(        
                                                                    SELECT METER_LOCATION_ID FROM BC_METER_LOCATION
                                                                    WHERE METER_LOCATION_CODE IN(
                                                                    SELECT METER_LOCATION FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                                    WHERE METER_LOCATION IN(
                                                                    SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION
                                                                    WHERE METER_LOCATION_ID IN(SELECT METER_PARENT_LOCATION_ID FROM BC_METER_LOCATION))
                                                                    AND METER_TYPE='BILL')))) 
                                          
                                          )
    LOOP

        v_Tot_Bill_Meter_Cons:=v_Tot_Bill_Meter_Cons+NVL(CUR_BILL_CONS.ADVANCE,0)*NVL(CUR_BILL_CONS.OVERALL_MF,0)*NVL(CUR_BILL_CONS.CF,1);
                            
    END LOOP;
    
    
    
    FOR CUR_BUS_LOSS_UPDATE IN(SELECT METER_ID,CUST_ID,CAT_ID,BILL_CYCLE_CODE,TIME_CYCLE_CODE,
                                          TOD_CODE,OPN_READING,CLS_READING,ADVANCE,OVERALL_MF,CF
                                          FROM BC_METER_READING_CARD_DTL@DBL_UBILL
                                          WHERE BILL_CYCLE_CODE=pvc_billcycle
                                          AND READING_TYPE_CODE='2'
                                          AND TIME_CYCLE_CODE=CUR_GRID.TIME_CYCLE_CODE
                                          AND METER_ID IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                          WHERE METER_TYPE='BILL'
                                                          AND GRID_ID=CUR_GRID.GRID_ID)
                                          AND METER_ID NOT IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                                    WHERE METER_LOCATION IN(
                                                                    SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION 
                                                                    WHERE METER_PARENT_LOCATION_ID IN(        
                                                                    SELECT METER_LOCATION_ID FROM BC_METER_LOCATION
                                                                    WHERE METER_LOCATION_CODE IN(
                                                                    SELECT METER_LOCATION FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                                    WHERE METER_LOCATION IN(
                                                                    SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION
                                                                    WHERE METER_LOCATION_ID IN(SELECT METER_PARENT_LOCATION_ID FROM BC_METER_LOCATION))
                                                                    AND METER_TYPE='BILL')))) 
                                          
                                          )
    LOOP

         IF NVL(v_Tot_Bill_Meter_Cons,0)>0 AND NVL(v_Tot_CK_Meter_Cons,0)>0 THEN
         
           UPDATE BC_METER_READING_CARD_DTL
            SET BUS_LOSS=((NVL(CUR_BUS_LOSS_UPDATE.ADVANCE,0)*NVL(CUR_BUS_LOSS_UPDATE.OVERALL_MF,0)*NVL(CUR_BUS_LOSS_UPDATE.CF,1)+NVL(LINE_LOSS,0))*(v_Tot_CK_Meter_Cons-v_Tot_Bill_Meter_Cons))/v_Tot_Bill_Meter_Cons
            WHERE BILL_CYCLE_CODE=pvc_billcycle
            AND READING_TYPE_CODE='2'
            AND TIME_CYCLE_CODE=CUR_GRID.TIME_CYCLE_CODE
            AND TIME_CYCLE_CODE=CUR_BUS_LOSS_UPDATE.TIME_CYCLE_CODE
            AND METER_ID=CUR_BUS_LOSS_UPDATE.METER_ID
            AND CUST_ID=CUR_BUS_LOSS_UPDATE.CUST_ID;
            
            null;
            
        END IF;
        
        
                            
    END LOOP;
 
 
 
 END LOOP;
 
 */
 COMMIT;
 
 
 FOR CUR_GRID IN(SELECT GRID_ID,TIME_CYCLE_CODE FROM BC_METER_GRID_CK_COMB_BILL_MST,ebc.BC_TIME_CYCLE_CODE
                WHERE GRID_ID IN(SELECT GRID_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                  WHERE EQUIP_ID IN(SELECT METER_id FROM ebc.BC_METER_READING_CARD_DTL
                                                  WHERE BILL_CYCLE_CODE=pvc_billcycle
                                                  AND READING_TYPE_CODE='2')
               AND TIME_CYCLE_CODE IN (1,2,3)
               and div_code=pvc_div_code
               )
               
               )
               
               
 LOOP
 
 
  
  
   
  
  FOR CUR_LOSS_CONS IN(SELECT METER_ID,CUST_ID,CAT_ID,BILL_CYCLE_CODE,TIME_CYCLE_CODE,
                                          TOD_CODE,OPN_READING,CLS_READING,ADVANCE,OVERALL_MF,CF
                                          FROM ebc.BC_METER_READING_CARD_DTL
                                          WHERE BILL_CYCLE_CODE=pvc_billcycle
                                          AND READING_TYPE_CODE='2'
                                          AND TIME_CYCLE_CODE=CUR_GRID.TIME_CYCLE_CODE
                                          AND METER_ID IN(SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
                                                          WHERE METER_TYPE='BILL'
                                                          AND GRID_ID=CUR_GRID.GRID_ID
                                                                                                                 AND METER_LOCATION IN (
                                                                                             SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION 
                                                         WHERE METER_LOCATION_ID IN (
                                                         SELECT METER_PARENT_LOCATION_ID FROM BC_METER_LOCATION  )
                                                                                                                  ) ))
                                          
                                          
                                          
    LOOP
        
        v_Total_Loss_Cons:=0;
        
        BEGIN
        
        --NVL(SUM(NVL(NET_VALUE,0)+NVL(BUS_LOSS,0)+NVL(LINE_LOSS,0)+NVL(LOSS_CONSUMPTION,0)),0) 
        
            SELECT NVL(SUM(NVL(NET_VALUE,0)+nvl(LOSS_CONSUMPTION,0)),0) ,SUM(NVL(bus_loss,0)) ,SUM(NVL(line_loss,0)) 
            INTO v_Total_Loss_Cons,v_Total_bus_Loss_Cons,v_Total_line_Loss_Cons
            FROM ebc.BC_METER_READING_CARD_DTL
            WHERE METER_ID IN(
            SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_DTL
            WHERE METER_LOCATION IN(
            SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION 
            WHERE METER_PARENT_LOCATION_ID IN(        
            SELECT METER_LOCATION_ID FROM BC_METER_LOCATION
            WHERE METER_LOCATION_CODE IN(
            SELECT METER_LOCATION FROM BC_METER_GRID_CK_COMB_BILL_DTL
            WHERE METER_LOCATION IN(
            SELECT METER_LOCATION_CODE FROM BC_METER_LOCATION
            WHERE METER_LOCATION_ID IN(SELECT METER_PARENT_LOCATION_ID FROM BC_METER_LOCATION))
            AND EQUIP_ID=CUR_LOSS_CONS.METER_ID
            AND METER_TYPE='BILL'))))
            AND BILL_CYCLE_CODE=pvc_billcycle
            AND READING_TYPE_CODE='2'
            AND TIME_CYCLE_CODE=CUR_GRID.TIME_CYCLE_CODE
            AND PURPOSE_OF_RDNG='B';
       EXCEPTION
             WHEN OTHERS THEN
                v_Total_Loss_Cons:=0;
                v_Total_bus_Loss_Cons:=0;
                v_Total_line_Loss_Cons:=0;
       END;
       
       
       UPDATE ebc.BC_METER_READING_CARD_DTL
       SET LOSS_CONSUMPTION=-v_Total_Loss_Cons,line_loss_adj=-v_Total_line_Loss_Cons,bus_loss_adj=-v_Total_bus_Loss_Cons
       WHERE BILL_CYCLE_CODE=pvc_billcycle
       AND READING_TYPE_CODE='2'
       AND TIME_CYCLE_CODE=CUR_GRID.TIME_CYCLE_CODE
       AND PURPOSE_OF_RDNG='B'
       AND METER_ID=CUR_LOSS_CONS.METER_ID;
         
                            
    END LOOP;
    
    
    
END LOOP;
 
 UPDATE ebc.BC_METER_READING_CARD_DTL
    SET LOSS_CONSUMPTION=-BILLED_VALUE,NET_VALUE=0
    WHERE METER_ID IN (SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_dtl
    WHERE METER_FLOW_TYPE='IMP' 
    and grid_id in (select grid_id from BC_METER_GRID_CK_COMB_BILL_MST where div_code=pvc_div_code )
    )   AND BILL_CYCLE_CODE=pvc_billcycle
    AND READING_TYPE_CODE=2;
    
    update ebc.BC_METER_READING_CARD_DTL a
  SET LOSS_CONSUMPTION= nvl (LOSS_CONSUMPTION,0)- (select adjust_unit
                                           from BC_UTILITY_BILL_ENTRY_DTL b
                                        where bill_cycle_code=pvc_billcycle
                                        and a.meter_id=b.equip_id   and a.TIME_CYCLE_CODE=b.TIME_CYCLE_CODE
                                        and  ENTRY_ID in (select entry_id from BC_UTILITY_BILL_ENTRY_hdr where bill_cycle_code=pvc_billcycle)
                                        and nvl(adjust_unit,0)<>0)
                                        where bill_cycle_code=pvc_billcycle
and meter_id   in (
select equip_id from BC_UTILITY_BILL_ENTRY_DTL
where ENTRY_ID in (select entry_id from BC_UTILITY_BILL_ENTRY_hdr where bill_cycle_code=pvc_billcycle
and grid_id in (select grid_id from BC_METER_GRID_CK_COMB_BILL_MST where div_code=pvc_div_code))
and nvl(adjust_unit,0)<>0
)
and METER_ID IN (SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_dtl
    WHERE METER_FLOW_TYPE='IMP') ;
 
 
 update ebc.BC_METER_READING_CARD_DTL a
  SET LOSS_CONSUMPTION= (select adjust_unit
                                           from BC_UTILITY_BILL_ENTRY_DTL b
                                        where bill_cycle_code=pvc_billcycle
                                        and a.meter_id=b.equip_id   and a.TIME_CYCLE_CODE=b.TIME_CYCLE_CODE
                                        and  ENTRY_ID in (select entry_id from BC_UTILITY_BILL_ENTRY_hdr where bill_cycle_code=pvc_billcycle)
                                        and nvl(adjust_unit,0)<>0)
                                        where bill_cycle_code=pvc_billcycle
and meter_id   in (
select equip_id from BC_UTILITY_BILL_ENTRY_DTL
where ENTRY_ID in (select entry_id from BC_UTILITY_BILL_ENTRY_hdr where bill_cycle_code=pvc_billcycle
and grid_id in (select grid_id from BC_METER_GRID_CK_COMB_BILL_MST where div_code=pvc_div_code))
and nvl(adjust_unit,0)<>0
)
and METER_ID IN (SELECT EQUIP_ID FROM BC_METER_GRID_CK_COMB_BILL_dtl
    WHERE METER_FLOW_TYPE<>'IMP') ;

COMMIT;


END DPD_LLFACT_LINE_BUSS_LOSS_CALC;

END DPG_LLFACT_LINE_BUSS_LOSS_CALC;
/
