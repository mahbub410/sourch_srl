SELECT to_char(pay_date,'rrrrmm') payment_month,'ROBI Phone' operator_name,L.location_code,LOCATION_NAME,SUM(PDB_AMOUNT) bpdb_amount,SUM(GOVT_DUTY) vat,SUM(PDB_AMOUNT)+SUM(GOVT_DUTY) total_amount,COUNT(1) NO_OF_TRNS 
FROM VW_EPAY_PAYMENT_MST_DTL D,EPAY_LOCATION_MASTER L
where pay_bank_code='97'
AND D.LOCATION_CODE =L.LOCATION_CODE
and to_char(pay_date,'rrrrmm')='201705'
and L.location_code in (select location_code from epay_location_master where center_name='NAOGAON')
GROUP BY L.LOCATION_CODE,LOCATION_NAME, to_char(pay_date,'rrrrmm')
order by 2
