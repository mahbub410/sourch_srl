
select ITEM_CODE, TRAN_DATE, nvl(OPN_AMT,0) OPN_AMT,sum(nvl(DR_AMT,0)) qn,sum(nvl(CR_AME,0)) usi,
nvl(OPN_AMT,0)+sum(nvl(DR_AMT,0)) tot,
(nvl(OPN_AMT,0)+sum(nvl(DR_AMT,0)))-sum(nvl(CR_AME,0)) cl_qn from TB1
group by ITEM_CODE, TRAN_DATE,OPN_AMT
order by 1,2