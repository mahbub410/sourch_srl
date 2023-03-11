
SELECT DATA_TRANS_LOG1 ROBI,COUNT(*) NOT_UPLOAD, DATA_TRANS_LOG2 GP,COUNT(*) NOT_UPLOAD,
 DATA_TRANS_LOG3 SRL,COUNT(*) NOT_UPLOAD, DATA_TRANS_LOG4 EPAYMENT,COUNT(*) NOT_UPLOAD FROM EPAY_UTILITY_BILL
WHERE BILL_MONTH='201807'
AND DATA_TRANS_LOG1='N'
AND DATA_TRANS_LOG2='N'
AND DATA_TRANS_LOG3='N'
AND DATA_TRANS_LOG4='N'
GROUP BY DATA_TRANS_LOG1, DATA_TRANS_LOG2, DATA_TRANS_LOG3, DATA_TRANS_LOG4