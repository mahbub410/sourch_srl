

select year_code,  round(sum(E.NET_IMPORT_KWH)/1000000,2) Import_MKWH, 
round(sum(BILLED_UNIT)/1000000,2) Sale_MKWH, decode(sum(E.NET_IMPORT_KWH),0,0,round(100*(sum(E.NET_IMPORT_KWH)-sum(BILLED_UNIT))/sum(E.NET_IMPORT_KWH),2)) Dist_sys_loss,
round(sum(BILLED_amt)/1000000,2)  net_bill_MTK,round(sum(coll_amt)/1000000,2)  net_Coll_MTK , round(100*(sum(COLL_AMT))/sum(Billed_amt),2) CB_RATIO
,decode(sum(E.NET_IMPORT_KWH),0,0, round(100*sum(COLL_AMT)/((sum(Billed_amt) / sum(Billed_unit))*sum(NET_IMPORT_KWH)),2)) CI_RATIO
from  (select bill_cycle_code,location_code,sum(nvl(BILLED_UNIT,0)) BILLED_UNIT ,sum(nvl(BILLED_amt,0)) BILLED_amt,
sum(nvl(coll_amt,0)) coll_amt
from ic_cat_wise_mod 
group by bill_cycle_code,location_code)a, ic_location_master b, ic_circle_mst c, ic_zone_mst d, ic_loc_mod e,ic_period_mst f
where a.bill_cycle_code<=:p_bill_cycle_code
AND B.ZONE_CODE LIKE NVL(:P_Zone_Code,'%')
AND B.CIRCLE_CODE LIKE NVL(:P_Circle_Code,'%')
AND b.LOCATION_CODE LIKE NVL(:P_Location_Code,'%')
and a.location_code=b.location_code
and f.period_code=a.bill_cycle_code
and b.circle_code=c.circle_code
and b.zone_code=d.zone_code
and d.ZONE_CODE = c.ZONE_CODE
and d.zone_type in ('D','P','G')
and e.location_code=a.location_code
and a.bill_cycle_code=e.bill_cycle_code
and f.year_code>='2007-2008'
group by year_code;

----

    OPEN cur_data FOR
    select  a.bill_cycle_code, a.bill_cycle_code||'('||period_desc||')' month_desc,  round(sum(E.NET_IMPORT_KWH)/1000000,2) Import_MKWH, 
    round(sum(BILLED_UNIT)/1000000,2) Sale_MKWH, round(100*(sum(E.NET_IMPORT_KWH)-sum(BILLED_UNIT))/sum(E.NET_IMPORT_KWH),2) Dist_sys_loss,
    round(sum(BILLED_amt)/1000000,2) net_bill_MTK,round(sum(coll_amt)/1000000,2) net_Coll_MTK , round(100*(sum(COLL_AMT))/sum(Billed_amt),2) CB_RATIO
    , round(100*sum(COLL_AMT)/((sum(Billed_amt) / sum(Billed_unit))*sum(NET_IMPORT_KWH)),2) CI_RATIO
    from  (select bill_cycle_code,location_code,sum(nvl(BILLED_UNIT,0)) BILLED_UNIT ,sum(nvl(BILLED_amt,0)) BILLED_amt,
    sum(nvl(coll_amt,0)) coll_amt
    from ic_cat_wise_mod 
    group by bill_cycle_code,location_code)a, ic_location_master b, ic_circle_mst c, ic_zone_mst d, ic_loc_mod e,ic_period_mst f
    where  a.location_code=b.location_code
    and f.period_code=a.bill_cycle_code
    and b.circle_code=c.circle_code
    and b.zone_code=d.zone_code
    and d.zone_type in ('D','P','G')
    and e.location_code=a.location_code
    and a.bill_cycle_code=e.bill_cycle_code
    --and f.period_code<=:P_Bill_Cycle_Code
    and a.bill_cycle_codE<=p_bill_cycle_code
    and a.bill_cycle_code>to_char(add_months(to_date(p_bill_cycle_code,'RRRRMM'),-12),'RRRRMM')
    --and f.year_code=V_P_YEAR_CODE
    AND B.ZONE_CODE =P_Zone_Code
    AND B.CIRCLE_CODE LIKE NVL(P_Circle_Code,'%')
    AND b.LOCATION_CODE LIKE NVL(P_Location_Code,'%')
     group by a.bill_cycle_code,period_desc
     order by 1 asc;