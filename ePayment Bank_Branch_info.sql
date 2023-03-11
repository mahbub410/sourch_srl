
select br.BANK_CODE,b.BANK_NAME,br.BRANCH_CODE,br.BRANCH_NAME,br.BILLING_BANK_CODE,br.BILLING_BRANCH_CODE,br.LOCATION_CODE,l.LOCATION_NAME
from epay_banks b,epay_bank_branches br,epay_location_master l
where b.BANK_CODE = br.BANK_CODE
and br.LOCATION_CODE = l.LOCATION_CODE
and br.bank_code='19'