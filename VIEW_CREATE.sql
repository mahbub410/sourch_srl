CREATE OR REPLACE FORCE VIEW EPAY.VW_PYMT_DATA_NOT_IMPORT
(
   BATCH_NO,
   LOCATION_CODE,
   PAYMENT_MONTH,
   PAY_DATE,
   AMT,
   VAT,
   TOT_AMT,
   TOT_TRNS,
   FLAG_DESC
)
AS
     SELECT MST.BATCH_NO,
            MST.LOCATION_CODE,
            MST.PAYMENT_MONTH,
            MST.PAY_DATE,
            DTL.AMT,
            DTL.VAT,
            DTL.TOT_AMT,
            DTL.TOT_TRNS,
            MST.FLAG_DESC
       FROM (SELECT M.BATCH_NO,
                    M.LOCATION_CODE,
                    TO_CHAR (M.PAY_DATE, 'RRRRMM') PAYMENT_MONTH,
                    M.PAY_DATE,
                    INITCAP (
                       DECODE (M.STATUS,
                               'N', 'NOT RECONCILED IN PDB',
                               'P', 'NOT IMPORT IN CENTER',
                               M.STATUS))
                       FLAG_DESC
               FROM EPAY_PAYMENT_MST@EPAY_DCC M
              WHERE M.STATUS <> 'T'
                    AND M.LOCATION_CODE IN
                           (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER)) MST,
            (  SELECT D.BATCH_NO,
                      SUM (D.PDB_AMOUNT) AS AMT,
                      SUM (D.GOVT_DUTY) AS VAT,
                      SUM (D.PDB_AMOUNT + D.GOVT_DUTY) AS TOT_AMT,
                      COUNT (1) AS TOT_TRNS
                 FROM EPAY_PAYMENT_DTL@EPAY_DCC D
             GROUP BY D.BATCH_NO) DTL
      WHERE MST.BATCH_NO = DTL.BATCH_NO
   ORDER BY MST.PAY_DATE ASC;


CREATE OR REPLACE FORCE VIEW EPAY.VW_PYMT_DATA_POSTED
(
   BATCH_NO,
   POSTED_BATCH_NUM,
   LOCATION_CODE,
   BANK_DESC,
   PYMT_MONTH,
   PAY_DATE,
   AMT,
   VAT,
   TOT_AMT,
   TOT_TRNS,
   FLAG_DESC
)
AS
     SELECT MST.BATCH_NO,
            MST.POSTED_BATCH_NUM,
            MST.LOCATION_CODE,
            MST.BANK_DESC,
            MST.PYMT_MONTH,
            MST.PAY_DATE,
            DTL.AMT,
            DTL.VAT,
            DTL.TOT_AMT,
            DTL.TOT_TRNS,
            MST.FLAG_DESC
       FROM (SELECT M.BATCH_NO,
                    R.BATCH_NUM_PDB AS POSTED_BATCH_NUM,
                    M.LOCATION_CODE,
                    R.BANK_CODE || '-'
                    || INITCAP (
                          DECODE (R.BANK_CODE,
                                  '97', 'ROBI PHONE',
                                  '96', 'GP PHONE',
                                  R.BANK_CODE))
                       AS BANK_DESC,
                    TO_CHAR (M.PAY_DATE, 'RRRRMM') PYMT_MONTH,
                    M.PAY_DATE,
                    INITCAP (
                       DECODE (M.STATUS,
                               'T', 'POSTED IN CENTER',
                               'P', 'NOT IMPORT IN CENTER',
                               M.STATUS))
                       FLAG_DESC
               FROM EPAY_PAYMENT_MST@EPAY_DCC M,
                    EPAY_RECEIPT_BATCH_HDR_PDB@EPAY_DCC R
              WHERE M.BATCH_NO = R.BATCH_NUM_EPAY AND M.STATUS = 'T'
                    AND M.LOCATION_CODE IN
                           (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER)) MST,
            (  SELECT D.BATCH_NO,
                      SUM (D.PDB_AMOUNT) AS AMT,
                      SUM (D.GOVT_DUTY) AS VAT,
                      SUM (D.PDB_AMOUNT + D.GOVT_DUTY) AS TOT_AMT,
                      COUNT (1) AS TOT_TRNS
                 FROM EPAY_PAYMENT_DTL@EPAY_DCC D
             GROUP BY D.BATCH_NO) DTL
      WHERE MST.BATCH_NO = DTL.BATCH_NO
   ORDER BY MST.PAY_DATE DESC;

CREATE OR REPLACE FORCE VIEW EPAY.VW_PYMT_DATA_UNPOSTED
(
   BATCH_NO,
   LOCATION_CODE,
   PAYMENT_MONTH,
   PAY_DATE,
   AMT,
   VAT,
   TOT_AMT,
   TOT_TRNS,
   FLAG_DESC
)
AS
     SELECT MST.BATCH_NO,
            MST.LOCATION_CODE,
            MST.PAYMENT_MONTH,
            MST.PAY_DATE,
            DTL.AMT,
            DTL.VAT,
            DTL.TOT_AMT,
            DTL.TOT_TRNS,
            MST.FLAG_DESC
       FROM (SELECT M.BATCH_NO,
                    M.LOCATION_CODE,
                    TO_CHAR (M.PAY_DATE, 'RRRRMM') PAYMENT_MONTH,
                    M.PAY_DATE,
                    INITCAP (
                       DECODE (M.STATUS,
                               'P', 'UNPOSTED IN CENTER',
                               'P', 'NOT IMPORT IN CENTER',
                               M.STATUS))
                       FLAG_DESC
               FROM EPAY_PAYMENT_MST@EPAY_DCC M
              WHERE M.STATUS = 'P'
                    AND M.LOCATION_CODE IN
                           (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER)) MST,
            (  SELECT D.BATCH_NO,
                      SUM (D.PDB_AMOUNT) AS AMT,
                      SUM (D.GOVT_DUTY) AS VAT,
                      SUM (D.PDB_AMOUNT + D.GOVT_DUTY) AS TOT_AMT,
                      COUNT (1) AS TOT_TRNS
                 FROM EPAY_PAYMENT_DTL@EPAY_DCC D
             GROUP BY D.BATCH_NO) DTL
      WHERE MST.BATCH_NO = DTL.BATCH_NO
   ORDER BY MST.PAY_DATE ASC;


CREATE PUBLIC SYNONYM VW_PYMT_DATA_NOT_IMPORT FOR EPAY.VW_PYMT_DATA_NOT_IMPORT;


CREATE PUBLIC SYNONYM VW_PYMT_DATA_POSTED FOR EPAY.VW_PYMT_DATA_POSTED;


CREATE PUBLIC SYNONYM VW_PYMT_DATA_UNPOSTED FOR EPAY.VW_PYMT_DATA_UNPOSTED;
