select
'delete from epay_utility_bill
where bill_month='''||b_month||'''
and location_code='''||loc||''''||';' ||CHR(10)||CHR(10)||'COMMIT;'||CHR(10) "QUERY"
from (select distinct bill_month b_month,location_code loc from epay_utility_bill
where bill_month<'201810'
order by bill_month asc,location_code asc)