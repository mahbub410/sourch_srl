
select * from TEMP_CUST_CERTIFICATE_DTL
where BILL_CYCLE_CODE='201911'

where CERT_ID =410219841--in (410534393,410533607)


select * from TEMP_CUST_CERTIFICATE_HDR
where PROCESSING_BILL_CYCLE='201911'
and location_code='L1'
and bill_grp='15'
and CUSTOMER_NUM in ('67139370','67139559','67139563')



select CUSTOMER_NUM,count(*) from TEMP_CUST_CERTIFICATE_hdr
where PROCESSING_BILL_CYCLE='201911'
--and location_code='L1'
--and bill_grp='15'
group by CUSTOMER_NUM

having count(CUSTOMER_NUM)>1


select * from TEMP_CUST_CERTIFICATE_HDR
where PROCESSING_BILL_CYCLE='201911'
and location_code='L1'
--and EXP_DATE is  null
and customer_num='67352671'

select ''''||CUSTOMER_NUM||''''||',',count(*) from TEMP_CUST_CERTIFICATE_HDR
where PROCESSING_BILL_CYCLE='201911'
and location_code='L1'
--and bill_grp='15'
and EXP_DATE is not null
group by CUSTOMER_NUM
having count(CUSTOMER_NUM)>1



-------------duplicate delete----------

select * from TEMP_CUST_CERTIFICATE_HDR
where CUSTOMER_NUM in (
select CUSTOMER_NUM from TEMP_CUST_CERTIFICATE_HDR
where PROCESSING_BILL_CYCLE='201911'
and location_code='L1'
--and bill_grp='15'
group by CUSTOMER_NUM
having count(CUSTOMER_NUM)>1
)and PROCESSING_BILL_CYCLE='201911'
and EXP_DATE is not null