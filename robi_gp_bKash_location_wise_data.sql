
select 'GP' Company, to_char(m.PAY_DATE,'rrrrmm') PAY_month,l.LOCATION_NAME||' - ('||m.LOCATION_CODE||')' location,
sum(d.PDB_AMOUNT) principle,sum(d.GOVT_DUTY) vat,sum(d.PDB_AMOUNT+d.GOVT_DUTY) total_amt,count(*) tot_cons
 from epay_payment_mst m,epay_payment_dtl d,epay_location_master l
where m.BATCH_NO = d.BATCH_NO
and m.LOCATION_CODE=l.LOCATION_CODE
and to_char(m.PAY_DATE,'rrrrmm')='202009'
and pay_bank_code='96'
group by to_char(m.PAY_DATE,'rrrrmm'),l.LOCATION_NAME,m.LOCATION_CODE
order by m.LOCATION_CODE