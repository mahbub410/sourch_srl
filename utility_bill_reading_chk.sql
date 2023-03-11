
67.892


select * from BC_UTILITY_BILL_ENTRY_DTL
where METER_NUM = '50499791'
and ENTRY_ID in (
select ENTRY_ID from BC_UTILITY_BILL_ENTRY_HDR
where bill_cycle_code='201912'
--where bill_cycle_code between '201911' and '201912'
)
order by 1 desc

METER_NUM = '216430330NE'