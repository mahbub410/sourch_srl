SELECT m.pay_date,m.batch_no,m.location_code,d.BILL_NUMBER,d.PDB_AMOUNT,d.GOVT_DUTY,d.TRANSACTION_ID FROM epay_PAYMENT_MST M,epay_PAYMENT_DTL D
WHERE M.BATCH_NO=D.BATCH_NO
and pay_date between '01-NOV-2014' and '30-NOV-2014'
and location_code in (select location_code from epay_location_master where center_name in('MYMENSING','TANGAIL','KISHOREGANJ','JAMALPUR'))
AND BILL_NUMBER IN(
283286800,
283286816,
284231071,
284260814
)

SELECT COUNT(*) FROM PAYMENT_MST@EPAY_ROBI M,PAYMENT_DTL@EPAY_ROBI D
WHERE M.BATCH_NO=D.BATCH_NO
and pay_date between '01-NOV-2014' and '30-NOV-2014'
and location_code in (select location_code from epay_location_master where center_name in('MYMENSING','TANGAIL','KISHOREGANJ','JAMALPUR'))

45785

SELECT COUNT(*) FROM epay_PAYMENT_MST M,epay_PAYMENT_DTL D
WHERE M.BATCH_NO=D.BATCH_NO
and pay_date between '01-NOV-2014' and '30-NOV-2014'
and location_code in (select location_code from epay_location_master where center_name in('MYMENSING','TANGAIL','KISHOREGANJ','JAMALPUR'))

SELECT 45785-45757 FROM DUAL