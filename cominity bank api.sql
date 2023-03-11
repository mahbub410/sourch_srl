

select ACCOUNT_NUMBER,TOTAL_BILL_AMOUNT from EPAY_UTILITY_BILL@MAG
where COMPANY_CODE='DPDC'
AND LOCATION_CODE='V9'
AND BILL_MONTH='202202'
AND ACCOUNT_NUMBER IN ('58176272',
'58181423',
'58181673',
'58181442',
'58181457',
'58181461',
'58181476',
'58181480',
'58181495',
'58181508'
)

UPDATE EPAY_UTILITY_BILL@MAG
SET BILL_MONTH='202202'
where COMPANY_CODE='DPDC'
AND LOCATION_CODE='V9'
AND BILL_MONTH='201801'
AND ACCOUNT_NUMBER IN (
'58176272',
'58181423',
'58181673',
'58181442',
'58181457',
'58181461',
'58181476',
'58181480',
'58181495',
'58181508'
)

 bill_month='202201'