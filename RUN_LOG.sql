

SELECT * FROM VW_RUN_LOG
WHERE DATA_TYPE='BILLINFO'
AND ONLINE_OPT='SRL'
AND LOCATION_CODE IN (SELECT LOCATION_CODE FROM EPAY_LOCATION_MASTER WHERE CENTER_NAME ='CHITTAGONG')

MYMENSING,
TANGAIL,
KISHOREGANJ,
JAMALPUR,
COMILLA,
MOULAVIBAZAR,
SYLHET,
CHITTAGONG