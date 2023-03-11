select :p_center_name Center_Name,'20801' BILL_MONTH,(
select count(distinct CUST_ID) tot_cust_num_bank from bc_receipt_hdr
where RECEIPT_DATE between '01-jan-2018' and '31-jan-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code not in('96','97'))+(
select count(distinct CUST_ID) tot_cust_num_epay from bc_receipt_hdr
where RECEIPT_DATE between '01-jan-2018' and '31-JAN-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code in('96','97')) total_customer,(
select count(distinct CUST_ID) tot_cust_num_bank from bc_receipt_hdr
where RECEIPT_DATE between '01-jan-2018' and '31-JAN-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code not in('96','97')) tot_cust_num_bank,
(
select count(distinct CUST_ID) tot_cust_num_epay from bc_receipt_hdr
where RECEIPT_DATE between '01-jan-2018' and '31-JAN-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code in('96','97')) tot_cust_num_epay
from dual
UNION
select :p_center_name Center_Name,'20802' BILL_MONTH,(
select count(distinct CUST_ID) tot_cust_num_bank from bc_receipt_hdr
where RECEIPT_DATE between '01-FEB-2018' and '28-FEB-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code not in('96','97'))+(
select count(distinct CUST_ID) tot_cust_num_epay from bc_receipt_hdr
where RECEIPT_DATE between '01-FEB-2018' and '28-FEB-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code in('96','97')) total_customer,(
select count(distinct CUST_ID) tot_cust_num_bank from bc_receipt_hdr
where RECEIPT_DATE between '01-FEB-2018' and '28-FEB-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code not in('96','97')) tot_cust_num_bank,
(
select count(distinct CUST_ID) tot_cust_num_epay from bc_receipt_hdr
where RECEIPT_DATE between '01-FEB-2018' and '28-FEB-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code in('96','97')) tot_cust_num_epay
from dual
UNION
select :p_center_name Center_Name,'20803' BILL_MONTH,(
select count(distinct CUST_ID) tot_cust_num_bank from bc_receipt_hdr
where RECEIPT_DATE between '01-MAR-2018' and '31-MAR-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code not in('96','97'))+(
select count(distinct CUST_ID) tot_cust_num_epay from bc_receipt_hdr
where RECEIPT_DATE between '01-MAR-2018' and '31-MAR-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code in('96','97')) total_customer,(
select count(distinct CUST_ID) tot_cust_num_bank from bc_receipt_hdr
where RECEIPT_DATE between '01-MAR-2018' and '31-MAR-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code not in('96','97')) tot_cust_num_bank,
(
select count(distinct CUST_ID) tot_cust_num_epay from bc_receipt_hdr
where RECEIPT_DATE between '01-MAR-2018' and '31-MAR-2018'
and RECEIPT_TYPE_CODE='REC'
and bank_code in('96','97')) tot_cust_num_epay
from dual