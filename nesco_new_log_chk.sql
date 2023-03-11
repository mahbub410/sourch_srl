select trunc(RUN_DATE),REC_TYPE,sum(nvl(REC_COUNT,0)) from DESCOPST_RUN_LOG
where to_char(trunc(RUN_DATE),'rrrrmm')='202102'
and DATA_TYPE='BILLINFO'
GROUP BY trunc(RUN_DATE),REC_TYPE
order by 1 desc