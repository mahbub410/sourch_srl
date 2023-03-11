

select B.BANK_NAME, DECODE(SUBSTR(REF_BATCH_NO,1,1),'E','Online Software','M','Api','Desktop Software') SOFTWARE_STATUS
from epay_payment_mst PM,EPAY_BANKS B
where PM.PAY_BANK_CODE=B.BANK_CODE
AND to_char(pay_date,'rrrrmm')='202106'
and pay_bank_code not in ('96','97','94','14')
GROUP BY B.BANK_NAME,DECODE(SUBSTR(REF_BATCH_NO,1,1),'E','Online Software','M','Api','Desktop Software')
ORDER BY 2


select SUBSTR(REF_BATCH_NO,1,1) from epay_payment_mst
where to_char(pay_date,'rrrrmm')='202106'
and pay_bank_code not in ('96','97','94')