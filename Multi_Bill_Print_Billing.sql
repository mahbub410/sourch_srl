
UPDATE BC_BILL_IMAGE A
SET (A.METER_ID,A.OPN_KWH_OFPK_RDNG,A.CLS_KWH_OFPK_RDNG,A.OPN_KWH_PK_RDNG,A.CLS_KWH_PK_RDNG,
A.OPN_KVARH_SR_RDNG,A.CLS_KVARH_SR_RDNG,A.CONS_KVARH_SR,A.METER_NUM_KWH,A.METER_NUM_KVARH)=(SELECT A.METER_ID,A.OPN_KWH_OFPK_RDNG,A.CLS_KWH_OFPK_RDNG,A.OPN_KWH_PK_RDNG,A.CLS_KWH_PK_RDNG,
                                                        B.OPN_KVARH_SR_RDNG,B.CLS_KVARH_SR_RDNG,B.CONS_KVARH_SR,A.METER_NUM_KWH,B.METER_NUM_KVARH FROM( 
                                                        SELECT  CUST_ID,METER_ID,OPN_KWH_OFPK_RDNG,CLS_KWH_OFPK_RDNG,OPN_KWH_PK_RDNG,CLS_KWH_PK_RDNG,
                                                        OPN_KVARH_SR_RDNG,CLS_KVARH_SR_RDNG,CONS_KVARH_SR,METER_NUM_KWH,METER_NUM_KVARH
                                                        FROM EMP.BC_BILL_IMAGE_202005
                                                        WHERE BILL_CYCLE_CODE = '202008'
                                                         AND cust_id = CID(:cust_id)
                                                         AND METER_ID IS NOT NULL
                                                         AND OPN_KWH_OFPK_RDNG IS NOT NULL
                                                         AND CLS_KWH_OFPK_RDNG IS NOT NULL)A,(
                                                         SELECT  CUST_ID,METER_ID,OPN_KWH_OFPK_RDNG,CLS_KWH_OFPK_RDNG,OPN_KWH_PK_RDNG,CLS_KWH_PK_RDNG,
                                                        OPN_KVARH_SR_RDNG,CLS_KVARH_SR_RDNG,CONS_KVARH_SR,METER_NUM_KWH,METER_NUM_KVARH
                                                        FROM EMP.BC_BILL_IMAGE_202005
                                                        WHERE BILL_CYCLE_CODE = '202008'
                                                         AND cust_id = CID(:cust_id)
                                                         AND OPN_KVARH_SR_RDNG IS NOT NULL
                                                         AND CLS_KVARH_SR_RDNG IS NOT NULL
                                                         AND CONS_KVARH_SR IS NOT NULL
                                                          AND METER_NUM_KVARH IS NOT NULL)B
                                                          WHERE A.CUST_ID=B.CUST_ID)
 WHERE A.BILL_CYCLE_CODE='202008'
 AND cust_id = CID(:cust_id)
  AND AREA_CODE='20115'                                                          