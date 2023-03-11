
-----------bill data chk--------

SELECT A.COMPANY_CODE,A.SRL,B.PAC,SUM(A.SRL-B.PAC) DIFF FROM (
select COMPANY_CODE,count(*) SRL from epay_utility_bill@EPAYSRL_24
where bill_month='202107'
and COMPANY_CODE in ('NESCO','BPDB')
GROUP BY COMPANY_CODE
ORDER BY 1)A,(select COMPANY_CODE,count(*) PAC from epay_utility_bill@PACECLOUD
where bill_month='202107'
and COMPANY_CODE in ('NESCO','BPDB')
GROUP BY COMPANY_CODE
ORDER BY 1)B
WHERE A.COMPANY_CODE = B.COMPANY_CODE
GROUP BY A.COMPANY_CODE,A.SRL,B.PAC
order by 1

-------untransfer data

select COMPANY_CODE,count(decode(DATA_TRANS_LOG,'N','Untransfer')) Tot_Cons from epay_utility_bill@EPAYSRL_24
where bill_month='202102'
and COMPANY_CODE in ('NESCO','BPDB')
GROUP BY COMPANY_CODE

--------------------
1934313	1689731	244582

select a.SRL,b.PAC,sum(a.SRL-b.PAC) diff from (
select '1' dm,count(*) srl from epay_utility_Bill@EPAYSRL_24
where bill_month='202009'
and company_code in ('BPDB','DESCOPOST','NESCO')
)a,(
select '1' dm,count(*) pac from epay_utility_Bill@PACECLOUD
where bill_month='202009'
and company_code in ('BPDB','DESCOPOST','NESCO')
)b
where a.DM = b.DM
group by a.SRL,b.PAC


1562113


select count(*) from epay_utility_Bill@EPAYSRL_24
where bill_month='202009'
and company_code in ('BPDB','DESCOPOST','NESCO')


select count(*) from epay_utility_Bill@PACECLOUD
where bill_month='202009'
and company_code in ('BPDB','DESCOPOST','NESCO')


select count(*) from epay_customer_master_data@EPAYSRL_24
where company_code in ('BPDB','NESCO')

--srl--pace
select 6260959-6202678 from dual

select count(*) from epay_customer_master_data@PACECLOUD
where company_code in ('BPDB','NESCO')

select company_code,count(*) from epay_utility_Bill
where bill_month='202009'
group by company_code