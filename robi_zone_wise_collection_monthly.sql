
select ZONE_NAME,PAYMENT_MONTH,BANK_NAME,PDB_AMOUNT,VAT,TOTAL_AMOUNT,NO_OF_CONS 
from VW_ZONE_WISE_COLL_PDB
where PAYMENT_MONTH='201909'
and bank_code='97'