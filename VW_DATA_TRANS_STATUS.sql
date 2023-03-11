
/* Formatted on 1/7/2016 2:41:05 PM (QP5 v5.149.1003.31008) */
CREATE OR REPLACE FORCE VIEW EPAY.VW_DATA_TRANS_STATUS
(
   BILL_MONTH,
   DATA_TRANS_LOG,
   NO_OF_CONS
)
AS
     SELECT BILL_CYCLE_CODE AS bill_month,
            DECODE (DATA_TRANS_LOG,
                    'T', 'Data uplode',
                    'N', 'Data not uplode')
               AS DATA_TRANS_LOG,
            COUNT (1) AS no_of_cons
       FROM BC_BILL_IMAGE@BILLING_KISHOR
      WHERE BILL_CYCLE_CODE IN
               (SELECT TO_CHAR (ADD_MONTHS (SYSDATE, -1), 'rrrrmm') FROM DUAL)
            AND location_code IN (SELECT location_code
                                    FROM EPAY_LOCATION_MASTER
                                   WHERE status = 'A')
   GROUP BY BILL_CYCLE_CODE, DATA_TRANS_LOG
   ORDER BY bill_cycle_code DESC;


CREATE PUBLIC SYNONYM VW_DATA_TRANS_STATUS FOR EPAY.VW_DATA_TRANS_STATUS;
