

select ERROR_TXT,LOCATION_CODE from VW_1EPAY_BANK_PYMT_VALED_ERR
where error_txt like '%12001101060920%'
and location_code='W2'
group by ERROR_TXT,LOCATION_CODE

Btch No:12001101060920, Location wise duplicate customer payment	W2

SELECT * FROM EPAY_UTILITY_BILL@EPAYMENT
WHERE LOCATION_CODE='E1'
AND BILL_NUMBER='2336713486'

select bill_number,count(*) from epay_payment_dtl_int
where batch_no='30000801250619'
group by bill_number
having count(bill_number)>1
order by bill_number desc



select * from epay_payment_dtl_int
where batch_no='04000601190619'
and  bill_number='706835551'


select * from epay_payment_dtl_int
where batch_no='28000201110619'
and bill_number in (
select bill_number from epay_payment_dtl_int
where batch_no='06000201110619'
)

Bill No:2335896672,Btch No:27000101090919:This bill no does not exist on BPDB

select * from epay_payment_dtl_int
where batch_no='12001202271119'
and bill_number='2316126713'

Bill No:3733068685,Btch No:28000301211019:This bill no does not exist on BPDB's data
------------------------This bill no does not exist on BPDB's data---------------------------------

select * from epay_payment_dtl_int
where batch_no='12001202271119'



INSERT INTO EPAY_UTILITY_BILL
SELECT COMPANY_CODE,ACCOUNT_NUMBER,BILL_NUMBER,
GENERATED_DATE,BILL_STATUS,BILL_DUE_DATE,
BILLAMT_AFTERDUEDATE,BILLENDDATE_FORPAYMENT,
CREATED_ON,CREATED_BY,MODIFIED_ON,MODIFIED_BY,
NOTIFICATION_SENT_STATUS,CURRENT_PRINCIPLE,
CURRENT_GOVT_DUTY,ARREAR_PRINCIPLE,
ARREAR_GOVT_DUTY,LATE_PAYMENT_SURCHARGE,
TOTAL_BILL_AMOUNT,LOCATION_CODE,BILL_MONTH,
TARIFF,CUSTOMER_TYPE,CURRENT_SURCHARGE,
ARREAR_SURCHARGE,ADJUSTED_PRINCIPLE,ADJUSTED_GOVT_DUTY,
ADVANCE_AMOUNT,ADJ_ADV_GOVT_DUTY,'N' DATA_TRANS_LOG,'T' DATA_TRANS_LOG1,'N' DATA_TRANS_LOG2,'T' DATA_TRANS_LOG3,'T' DATA_TRANS_LOG4,'N' DATA_TRANS_LOG5 
FROM EPAY_UTILITY_BILL@EPAYMENT
WHERE  LOCATION_CODE='C2'
AND BILL_NUMBER='3733068685' 

COMMIT;



-------------Batch wise duplicate scroll error--------------

select * from epay_payment_dtl_int
where batch_no='04000601190619'
and scroll_no='386'

select scroll_no,count(*) from epay_payment_dtl_int
where batch_no='04000601190619'
group by scroll_no
having count(scroll_no)>1

SELECT MIN_A - 1 + LEVEL FROM ( 
SELECT MIN(SCROLL_NO) MIN_A , MAX(SCROLL_NO) MAX_A
FROM EPAY_PAYMENT_DTL_int
WHERE BATCH_NO=:b
                            )
CONNECT BY LEVEL <= MAX_A - MIN_A + 1
      MINUS
SELECT SCROLL_NO  FROM EPAY_PAYMENT_DTL_int
WHERE BATCH_NO=:b