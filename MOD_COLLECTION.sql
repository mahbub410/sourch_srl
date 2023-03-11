select b.BILL_CYCLE_CODE,b.LOCATION_CODE,b.FEEDER_NO,b.USAGE_CATEGORY_CODE,b.BUS_TYPE_CODE,b.CUSTOMER_STATUS_CODE,b.area_code,
a.receipt_prn,b.TOTAL_PRN_COLLECTION,(a.receipt_prn-b.TOTAL_PRN_COLLECTION) dif
from
(
select BILL_CYCLE_CODE,LOCATION_CODE,FEEDER_NO,tariff,BUS_TYPE_CODE,CUST_STATUS,area_code,sum(nvl(RCPT_PRN_1,0)+nvl(RCPT_PRN_2,0)+nvl(RCPT_PRN_3,0)) receipt_prn from bc_bill_image
where bill_cycle_code='201912'
and location_code='M5'
group by BILL_CYCLE_CODE,LOCATION_CODE,FEEDER_NO,tariff,BUS_TYPE_CODE,CUST_STATUS,area_code
) a,
(select BILL_CYCLE_CODE,LOCATION_CODE,FEEDER_NO,USAGE_CATEGORY_CODE,BUS_TYPE_CODE,CUSTOMER_STATUS_CODE,area_code,TOTAL_PRN_COLLECTION from BC_MONTH_MOD_REPORT
where location_code='M5'
and bill_cycle_code='201912' ) b
where a.BILL_CYCLE_CODE=b.BILL_CYCLE_CODE
and a.LOCATION_CODE=b.LOCATION_CODe
and a.FEEDER_NO=b.FEEDER_NO
and a.tariff=b.USAGE_CATEGORY_CODE
and a.BUS_TYPE_CODE=b.BUS_TYPE_CODE
and a.CUST_STATUS=b.CUSTOMER_STATUS_CODE
and a.area_code=b.area_code