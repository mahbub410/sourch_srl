
select * from bc_bill_image
where bill_cycle_code='201804'
and customer_Num in ('6705709','6705722','6705742')

410326961
410326981
410326943

select * from BC_CUSTOMER_meter
WHERE CUST_ID=CID('6705709')


SELECT * FROM BC_CATEGORY_MASTER
where CATEGORY_ID='20017'



SELECT * FROM BC_TARIFF_RATE_MASTER
where tariff_id='100'
and  EFF_END_BILL_CYCLE is null

select * from bc_invoice_dtl
where invoice_num in (select invoice_num from bc_invoice_hdr
where cust_id=cid('6705709')
and bill_cycle_code='201804')


select * from bc_meter_reading_card_dtl
where cust_id=cid('6705722')
and bill_cycle_code='201804'
