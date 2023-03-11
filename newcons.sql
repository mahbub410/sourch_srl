
SERV_CITY,MAIL_CITY,BILL_CITY

SELECT * FROM  NEWCONS. BC_CONSUMER_INTERFACE
where location_code='S7'

and MAIL_ADDR_DESCR3 LIKE '%Cox Bazar%'

House Ghona 250 KVA


select FEEDER_TRANS_CODE from 

update NEWCONS.BC_CONSUMER_INTERFACE
set  FEEDER_TRANS_CODE='Molovir chor 250 kva'
where location_code='S7'
and FEEDER_TRANS_CODE like '%Moulovir chor%'


select FEEDER_TRANS_CODE from  NEWCONS.BC_CONSUMER_INTERFACE
where location_code='S7'
and FEEDER_TRANS_CODE like '%Moulovir chor%'


Molovir chor 250 kva


select FEEDER_TRANS_CODE,length(FEEDER_TRANS_CODE) from NEWCONS.BC_CONSUMER_INTERFACE
where location_code='S7'
order by 2 desc