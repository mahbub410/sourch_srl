

select * from epay_zone_master
order by zone_code desc

select * from  EPAY_LOC_ONLINE_OPT_MAP
where location_code in (
select location_code from EPAY_ZONE_COMP_CNTR_LOC WHERE ZONE_CODE='6'
)
and ONLINE_OPT='ROBI'




UPDATE EPAY_LOC_ONLINE_OPT_MAP
SET STATUS='I'
where location_code in (
select location_code from EPAY_ZONE_COMP_CNTR_LOC WHERE ZONE_CODE='5'
)
and ONLINE_OPT='ROBI'



select * from payment_mst@epay_robi
where to_char(pay_date,'rrrrmm')='201912'
and location_code in (
select location_code from EPAY_ZONE_COMP_CNTR_LOC where zone_code='6')
and status<>'T'



select * from utility_Bill_pdb@epay_robi
where bill_month='202001'
and location_code in (
select location_code from EPAY_ZONE_COMP_CNTR_LOC where zone_code='6')

commit;
