


SELECT PAID_DATE,LOCATION_CODE,COUNT(1) FROM BPDB_CTG_MNUL_POSTING_1
GROUP BY PAID_DATE,LOCATION_CODE


SELECT * FROM BPDB_CTG_MNUL_POSTING_1

SELECT * FROM BPDB_CTG_MNUL_POSTING_1
WHERE LOCATION_CODE='E5'

SELECT * FROM EPAY_PAYMENT_MST

SELECT * FROM EPAY_PAYMENT_DTL

SELECT LOCATION_CODE,PAY_DATE,TOTAL_PDB_AMOUNT,REVENUE_STAMP_AMOUNT,NET_PDB_AMOUNT,TOTAL_GOVT_DUTY,STATUS,CREATED_ON,CREATED_BY,
            MODIFIED_ON,PAY_BANK_CODE,PAY_BRANCH_CODE,USER_NAME FROM BPDB_CTG_MNUL_POSTING_1
            WHERE LOCATION_CODE='E5'
           AND PAID_DATE ='06-OCT-2016'
            
            
          alter table EPAY_PAYMENT_DTL_X add (location_code varchar2(10))
            
            SELECT SUM(NVL(BILL_AMOUNT,0)) as TOTAL_PDB_AMOUNT, SUM(CASE WHEN NVL(COMPANY_AMOUNT,0)+NVL(VAT,0))>=500 THEN 10 ELSE 0 END) AS REVENUE_STAMP_AMOUNT,SUM(NVL(COMPANY_AMOUNT,0)) as NET_PDB_AMOUNT,
            SUM(NVL(VAT,0)) AS TOTAL_GOVT_DUTY FROM BPDB_CTG_MNUL_POSTING_1
            WHERE LOCATION_CODE='E5'
            AND PAID_DATE ='06-OCT-2016'

SELECT BATCH_NO,REF_BATCH_NO,LOCATION_CODE,PAY_DATE,TOTAL_PDB_AMOUNT,REVENUE_STAMP_AMOUNT,NET_PDB_AMOUNT,TOTAL_GOVT_DUTY,
STATUS,CREATED_ON,CREATED_BY,MODIFIED_ON,MODIFIED_BY,PAY_BANK_CODE,PAY_BRANCH_CODE,USER_NAME 
 FROM EPAY_PAYMENT_MST

select 
BATCH_NO,REF_BATCH_NO,BILL_NUMBER,BATCH_CODE,SCROLL_NO,TRANSACTION_ID,PDB_AMOUNT,GOVT_DUTY,STATUS,CREATED_ON,
CREATED_BY,MODIFIED_NO,MODIFIED_BY,MOBILE_NO,E_MAIL_ADDR--,PAY_DATE,LOCATION_CODE 
from EPAY_PAYMENT_DTL--_X


alter table EPAY_PAYMENT_DTL_X add(REV_AMT number)

INSERT INTO EPAY_PAYMENT_DTL_X
(BATCH_NO,REF_BATCH_NO,BILL_NUMBER,BATCH_CODE,SCROLL_NO,TRANSACTION_ID,PDB_AMOUNT,GOVT_DUTY,STATUS,CREATED_ON,
CREATED_BY,MODIFIED_NO,MODIFIED_BY,MOBILE_NO,E_MAIL_ADDR,PAY_DATE,LOCATION_CODE,REV_AMT )
SELECT 1,1,TO_CHAR(ORIGINAL_BILL_NUMBER_BPDB),'NA',ROWNUM,TO_CHAR(TRANSACTION_ID),
TO_NUMBER(COMPANY_AMOUNT),TO_NUMBER(VAT),'N',SYSDATE,'GP',SYSDATE,'GP',NULL,NULL,
TO_DATE(PAID_DATE,'dd-mon-yyyy'),TO_CHAR(LOCATION_CODE),CASE  WHEN NVL(TO_NUMBER(COMPANY_AMOUNT),0)+NVL(TO_NUMBER(VAT),0)>=500 THEN 5  ELSE 0  END REV_AMT
 FROM BPDB_CTG_MNUL_POSTING_1



select BATCH_NO,REF_BATCH_NO,LOCATION_CODE,PAY_DATE,PDB_AMOUNT,REV_AMT,null NET_PDB_AMOUNT,GOVT_DUTY,'P',CREATED_ON,
CREATED_BY,MODIFIED_NO,MODIFIED_BY,null PAY_BANK_CODE,null PAY_BRANCH_CODE,'FARUQ' from EPAY_PAYMENT_DTL_X

insert into EPAY_PAYMENT_MST_X
SELECT BATCH_NO,REF_BATCH_NO,LOCATION_CODE,PAY_DATE,SUM(PDB_AMOUNT),SUM(REV_AMT),SUM(PDB_AMOUNT)-SUM(REV_AMT) NET_PDB_AMOUNT,SUM(GOVT_DUTY),'P',
CREATED_ON,CREATED_BY,MODIFIED_NO,MODIFIED_BY,
'96' PAY_BANK_CODE,(SELECT DISTINCT PAY_BRANCH_CODE FROM EPAY_PAYMENT_MST M
WHERE PAY_BANK_CODE='96'
AND TO_CHAR(PAY_DATE,'rrrrmm')='201702'
AND M.LOCATION_CODE=Y.LOCATION_CODE ) AS PAY_BRANCH_CODE,'FARUQ'  FROM EPAY_PAYMENT_DTL_X Y
GROUP BY LOCATION_CODE,PAY_DATE,BATCH_NO,REF_BATCH_NO,CREATED_ON,CREATED_BY,MODIFIED_NO,MODIFIED_BY

select distinct PAY_BRANCH_CODE from epay_payment_mst
where pay_bank_code='96'
and to_char(pay_Date,'rrrrmm')='201702'
and location_code='H3'


SELECT PAY_DATE,LOCATION_CODE,count(*) FROM EPAY_PAYMENT_dtl_X
WHERE BATCH_NO<>1
group by PAY_DATE,LOCATION_CODE
order by 1

 SELECT EPAY_SEQ_PAY_BATCH_NO.NEXTVAL  FROM DUAL;



update  EPAY_PAYMENT_MST_X
set batch_no=:x ,ref_batch_no=:x
where to_date(pay_date,'dd-Mon-rrrr')='07-Oct-2016'
and location_code='U4'

update EPAY_PAYMENT_dtl_X
set batch_no=:x ,ref_batch_no=:x
where to_date(pay_date,'dd-Mon-rrrr')='07-Oct-2016'
and location_code='U4'

COMMIT;


select * from epay_utility_bill
where bill_number='198634118'

    SELECT  SUM(NVL(BILL_AMOUNT,0)+NVL(VAT,0)) AS TOTAL_PDB_AMOUNT,SUM(NVL(COMPANY_AMOUNT,0)),SUM(NVL(VAT,0)) FROM BPDB_CTG_MNUL_POSTING_1
            WHERE LOCATION_CODE='E5'
            AND PAID_DATE ='06-OCT-2016'
            GROUP BY BILL_AMOUNT,COMPANY_AMOUNT,VAT
            
            SUM(NVL(BILL_AMOUNT,0)+NVL(VAT,0)) AS TOTAL_PDB_AMOUNT,SUM(NVL(COMPANY_AMOUNT,0)),SUM(NVL(VAT,0))
            
            
            
            
            create or replace procedure btch_gen_test is

    bno number;

begin

    for c1 in (SELECT PAY_DATE,LOCATION_CODE,count(*) FROM EPAY_PAYMENT_MST_X
    WHERE BATCH_NO='1'
    group by PAY_DATE,LOCATION_CODE
    order by 1)
    loop

     SELECT EPAY_SEQ_PAY_BATCH_NO.NEXTVAL into bno  FROM DUAL;

        update  EPAY_PAYMENT_MST_X
        set batch_no=bno ,ref_batch_no=bno
        where pay_date=c1.pay_date
        and location_code=c1.location_code;

        update EPAY_PAYMENT_dtl_X
        set batch_no=bno ,ref_batch_no=bno
        where pay_date=c1.pay_date
        and location_code=c1.location_code;

    end loop;

COMMIT;

end ;


execute btch_gen_test;


 SELECT MST_BTCH,MST_TO_A,MST_NET,MST_VT,DTL_BATCH,DTL_PDB_AMT,DTL_VT,DTL_TOTAL FROM(
  SELECT M.BATCH_NO MST_BTCH,M.TOTAL_PDB_AMOUNT MST_TO_A,M.NET_PDB_AMOUNT MST_NET,M.TOTAL_GOVT_DUTY MST_VT 
 FROM EPAY_PAYMENT_MST_X M
 ORDER BY M.BATCH_NO ASC)A,(
  SELECT D.BATCH_NO DTL_BATCH,SUM(D.PDB_AMOUNT) DTL_PDB_AMT,SUM(D.GOVT_DUTY) DTL_VT,SUM(D.PDB_AMOUNT+D.GOVT_DUTY) DTL_TOTAL 
  FROM EPAY_PAYMENT_DTL_X D
  GROUP BY D.BATCH_NO
  ORDER BY D.BATCH_NO ASC)B
  WHERE A.MST_BTCH=B.DTL_BATCH
  and ( MST_TO_A <> DTL_PDB_AMT OR  MST_VT <> DTL_VT)
  
   insert into EPAY_PAYMENT_MST
  select * FROM EPAY_PAYMENT_MST_X
  
insert into   EPAY_PAYMENT_dtl
select        BATCH_NO,
                                REF_BATCH_NO,
                                BILL_NUMBER,
                                BATCH_CODE,
                                SCROLL_NO,
                                TRANSACTION_ID,
                                PDB_AMOUNT,
                                GOVT_DUTY,
                                STATUS,
                                CREATED_ON,
                                CREATED_BY,
                                MODIFIED_NO,
                                MODIFIED_BY,
                                MOBILE_NO,
                                E_MAIL_ADDR from EPAY_PAYMENT_DTL_X