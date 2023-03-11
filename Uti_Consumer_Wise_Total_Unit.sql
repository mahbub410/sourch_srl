select * from bc_customers

select * from bc_location_master
order by descr

select * from bc_meter_reading_card_dtl
where bill_cycle_code='202006'

select c.CUSTOMER_NAME,c.CUSTOMER_NUM,sum(nvl(BILLED_VALUE,0)) bill_unit,sum(nvl(LOSS_CONSUMPTION,0)) adjust_unit,sum(nvl(BUS_LOSS,0)+nvl(BUS_LOSS_ADJ,0)) buss_loss,
sum(nvl(LINE_LOSS,0)+nvl(LINE_LOSS_ADJ,0))line_loss,sum(nvl(BILLED_VALUE,0)+nvl(LOSS_CONSUMPTION,0)+nvl(BUS_LOSS,0)+nvl(BUS_LOSS_ADJ,0)+nvl(LINE_LOSS,0)+nvl(LINE_LOSS_ADJ,0)) total_export 
from bc_meter_reading_card_dtl cd,bc_customers c
where cd.CUST_ID=c.CUST_ID
and cd.bill_cycle_code='202009'
and c.LOCATION_CODE='GM'
and c.CUST_ID = cid(9113143)
group by c.CUSTOMER_NAME,c.CUSTOMER_NUM
order by 1



select dc.DIV_CODE_DESC, sum(nvl(BILLED_VALUE,0)) bill_unit,sum(nvl(LOSS_CONSUMPTION,0)) adjust_unit,sum(nvl(BUS_LOSS,0)+nvl(BUS_LOSS_ADJ,0)) buss_loss,
sum(nvl(LINE_LOSS,0)+nvl(LINE_LOSS_ADJ,0))line_loss,sum(nvl(BILLED_VALUE,0)+nvl(LOSS_CONSUMPTION,0)+nvl(BUS_LOSS,0)+nvl(BUS_LOSS_ADJ,0)+nvl(LINE_LOSS,0)+nvl(LINE_LOSS_ADJ,0)) total_export 
from bc_meter_reading_card_dtl cd,ubill.BC_METER_GRID_CK_COMB_BILL_DTL mg,
ubill.BC_METER_GRID_CK_COMB_BILL_MST cm,ubill.BC_DIV_CODE_MST dc
where cd.cust_id=mg.CUST_ID
and cd.METER_ID=mg.EQUIP_ID
and mg.GRID_ID = cm.GRID_ID
and cm.DIV_CODE = dc.DIV_CODE
and cd.bill_cycle_code='202009'
--and c.LOCATION_CODE='GM'
and cd.CUST_ID = cid(9113143)
group by dc.DIV_CODE_DESC