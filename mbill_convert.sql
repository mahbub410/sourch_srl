
--1.bill cycle
select Bill_cycle_code,bill_cycle_code as s1 from mbill_bill_cycle_master order by 1 desc

--2.zone
select descr Zone_name,zone_code as s1 from MBILL_ZONE_MASTER
where zone_code in (3,7,4) 

--3.circle
select descr Circle_name,circle_code as s1 from MBILL_circle_MASTER
where circle_code in (select circle_code from MBILL_ZONE_CIRCLE_LOC
where zone_code like nvl(:p63_zone,'%')
)and  circle_code in (select circle_code from MBILL_ZONE_CIRCLE_LOC C
                      where ((SELECT ROLE_ID FROM MBILL_USER_MST WHERE USER_NAME=:APP_USER)=1 OR((SELECT ROLE_ID FROM MBILL_USER_MST WHERE USER_NAME=:APP_USER)<>1 AND C.LOCATION_CODE IN(
                           SELECT DISTINCT LOCATION_CODE FROM MBILL_METER_READER_ALLOCATION
                           WHERE METER_READER_ID IN(
                                                 SELECT METER_READER_ID FROM MBILL_METER_READER_MST
                                                where USER_ID<>:APP_USER
                                                start with USER_ID=:APP_USER
                                                connect by prior  METER_READER_ID=P_METER_READER_ID)
                         AND NVL(EFF_BILL_CYCLE_CODE,:P63_BILL_CYCLE)<=:P63_BILL_CYCLE
                         AND NVL(EXP_BILL_CYCLE_CODE,:P63_BILL_CYCLE)>=:P63_BILL_CYCLE
                        UNION
                        SELECT LOCATION_CODE FROM MBILL_USER_LOC_MAP
                        WHERE USER_ID=(SELECT USER_ID FROM MBILL_USER_MST WHERE USER_NAME=:APP_USER))))
) order by 1


--4.location

select descr||'-'||location_code location_name,location_code as s1 from MBILL_LOCATION_MASTER C
where location_code in (select location_code from MBILL_ZONE_CIRCLE_LOC 
where zone_code like nvl(:p63_zone,'%')
and circle_code like nvl(:p63_circle,'%'))
and ((SELECT ROLE_ID FROM MBILL_USER_MST WHERE USER_NAME=:APP_USER)=1 OR((SELECT ROLE_ID FROM MBILL_USER_MST WHERE USER_NAME=:APP_USER)<>1 AND C.LOCATION_CODE IN(
                           SELECT DISTINCT LOCATION_CODE FROM MBILL_METER_READER_ALLOCATION
                           WHERE METER_READER_ID IN(
                                                 SELECT METER_READER_ID FROM MBILL_METER_READER_MST
                                                where USER_ID<>:APP_USER
                                                start with USER_ID=:APP_USER
                                                connect by prior  METER_READER_ID=P_METER_READER_ID)
                         AND NVL(EFF_BILL_CYCLE_CODE,:P63_BILL_CYCLE)<=:P63_BILL_CYCLE
                         AND NVL(EXP_BILL_CYCLE_CODE,:P63_BILL_CYCLE)>=:P63_BILL_CYCLE
                        UNION
                        SELECT LOCATION_CODE FROM MBILL_USER_LOC_MAP
                        WHERE USER_ID=(SELECT USER_ID FROM MBILL_USER_MST WHERE USER_NAME=:APP_USER))))
order by 1

----5.feeder

select descr||'-'||FEEDER_NO Feeder_name,FEEDER_NO as s1 from MBILL_FEEDER_SETUP C
where location_code like nvl(:p63_location,'%')
and ((SELECT ROLE_ID FROM MBILL_USER_MST WHERE USER_NAME=:APP_USER)=1 OR((SELECT ROLE_ID FROM MBILL_USER_MST WHERE USER_NAME=:APP_USER)<>1 AND C.LOCATION_CODE IN(
                           SELECT DISTINCT LOCATION_CODE FROM MBILL_METER_READER_ALLOCATION
                           WHERE METER_READER_ID IN(
                                                 SELECT METER_READER_ID FROM MBILL_METER_READER_MST
                                                where USER_ID<>:APP_USER
                                                start with USER_ID=:APP_USER
                                                connect by prior  METER_READER_ID=P_METER_READER_ID)
                         AND NVL(EFF_BILL_CYCLE_CODE,:P63_BILL_CYCLE)<=:P63_BILL_CYCLE
                         AND NVL(EXP_BILL_CYCLE_CODE,:P63_BILL_CYCLE)>=:P63_BILL_CYCLE
                        UNION
                        SELECT LOCATION_CODE FROM MBILL_USER_LOC_MAP
                        WHERE USER_ID=(SELECT USER_ID FROM MBILL_USER_MST WHERE USER_NAME=:APP_USER))))
order by 1

---6.bill group

select BILL_GRP_DESCR bill_gr,BILL_GROUP as s1 from MBILL_BILL_GROUP
order by 1

--7.status
STATIC2:PASS;P,BLOCK;B

--8. grid data

select :p63_BILL_CYCLE as Bill_cycle_code,zone_name,circle_name,location_name, :p63_location as Location_code,f.DESCR as feeder_name,a.area_code,
 round(sum(Billed_amount),2) Billed_amount ,round(sum(b.Tot_cons)/NULLIF(sum(No_of_Billed_cust),0),2) AVG_Cons, 
round(sum(Billed_amount)/ NULLIF(sum(b.Tot_cons),0),2) AVG_BILL_RATE,sum(No_of_Billed_cust) No_of_Billed_cust,sum(no_min_bill) no_min_bill,
sum(b.tot_cons) billed_unit,sum(New_con) New_con,sum(nvl(rnt.not_taken,0)) "Not Taken", sum(nvl(mr.tot_mr,0)) "Missing Reading", sum(no_of_live_cons) no_of_live_cons,
'<button type="button" style="color:blue;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:65:&SESSION.::65::P65_LOCATION_CODE,P65_AREA_CODE,P65_BILL_CYCLE_CODE,P65_STATUS:'
||:p63_LOCATION||','||"A".AREA_CODE||','||:p63_BILL_CYCLE||','||:p63_STATUS||'''">MRS</button>' MRS
from MBILL_AREA_ALLOCATION a,(
select bill_cycle_code, bi.location_code,bi.area_code,substr(bi.area_code,4) bill_grp  ,count(distinct bi.cust_id) No_of_Billed_cust,sum(decode(substr(bill_status,instr(bill_status,'M',1),1),'M',1,0)) no_min_bill,
 SUM((NVL(cons_kwh_sr,0) + NVL(cons_kwh_pk,0) + NVL(cons_kwh_ofpk,0)+NVL(CONS_KWH_MR1,0)+NVL(CONS_KWH_MR2,0)+NVL(CONS_KWH_MR3,0)+NVL(CONS_KWH_MR4,0)
           + NVL(old_kwh_sr_cons,0) + NVL(old_kwh_pk_cons,0)+ NVL(old_kwh_ofpk_cons,0) +NVL(OLD_KWH_MR1_CONS,0)+NVL(OLD_KWH_MR2_CONS,0)+NVL(OLD_KWH_MR3_CONS,0)+NVL(OLD_KWH_MR4_CONS,0)
           + NVL(XF_LOSS_SR_CONS,0) + NVL(XF_LOSS_OFPK_CONS,0) + NVL(XF_LOSS_PK_CONS,0)+NVL(XF_LOSS_MR1_CONS,0)+NVL(XF_LOSS_MR2_CONS,0)+NVL(XF_LOSS_MR3_CONS,0)+NVL(XF_LOSS_MR4_CONS,0)
           + NVL(PFC_SR_CONS,0) + NVL(PFC_OFPK_CONS,0) + NVL(PFC_PK_CONS,0)+NVL(PFC_MR1_CONS,0)+ NVL(  PFC_MR2_CONS,0)+NVL(  PFC_MR3_CONS,0)+NVL(  PFC_MR4_CONS,0))) tot_cons,
             SUM((NVL(ENG_CHRG_SR,0) + NVL(ENG_CHRG_OFPK,0)
           + NVL(ENG_CHRG_PK,0) + NVL(ENG_CHRG_MR1,0)+NVL(ENG_CHRG_MR2,0)+NVL(ENG_CHRG_MR3,0)+NVL(ENG_CHRG_MR4,0)
           +NVL(MINIMUM_CHRG,0) + NVL(SERVICE_CHRG,0)
           + NVL(DEMAND_CHRG,0) + NVL(PFC_CHARGE,0)
           + NVL(XF_LOSS_CHRG,0)  + NVL(XF_RENT,0)+NVL(ENG_CHRG_MR1,0)
           )) Billed_amount, sum(decode(bi.bill_cycle_code,C.START_BILL_CYCLE,1,0)) New_con  from mbill_bill_image bi ,  mbill_customers c
where invoice_num is not null
and  bi.bill_cycle_code=:p63_BILL_CYCLE
and c.cust_id=bi.cust_id
group by bi.bill_cycle_code, bi.location_code, bi.area_code,substr(bi.area_code,4)   
) b, V_Z_C_C_L c, MBILL_FEEDER_SETUP f,(select A.LOCATION_CODE,a.area_code,R.BILL_CYCLE_CODE,count(c.CUST_ID) Not_Taken from mbill.mbill_data_log r, mbill.mbill_area_code a, mbill.mbill_customers c
where R.CUST_ID=C.CUST_ID
and A.AREA_CODE=C.AREA_CODE
and A.LOCATION_CODE=C.LOCATION_CODE
and R.APPS_DATA_UPLOAD_DATE is null
group by A.LOCATION_CODE,a.area_code,R.BILL_CYCLE_CODE) rnt,
(select d.LOCATION_CODE,d.area_code,c.bill_cycle_code,count(c.cust_id)  tot_mr from mbill_data_log c, mbill_customers d, MBILL_CUSTOMER_METER cm
where C.CUST_ID=D.CUST_ID
and d.CUST_ID=CM.CUST_ID
and bill_cycle_code=:P63_bill_cycle
and APPS_DATA_UPLOAD_DATE is null
and c.cust_id in(select cust_id from mbill_data_log
where bill_cycle_code=TO_CHAR(ADD_MONTHS(TO_DATE(:P63_bill_cycle,'rrrrmm'),-1),'rrrrmm')
and APPS_DATA_UPLOAD_DATE is not null
)
group by d.LOCATION_CODE,d.area_code,c.bill_cycle_code ) mr, (select location_code,area_code,count(1) no_of_live_cons from mbill_customers where location_code=:p63_location and customer_status_code<>'D' and start_bill_cycle<=:p63_bill_cycle
group by location_code,area_code) d
where a.area_code=b.area_code(+)
and a.location_code=b.location_code(+)
and B.location_code(+)=:p63_location 
and a.FEEDER_NO=:p63_feeder
and ((SELECT ROLE_TYPE FROM MBILL_USER_MST U,MBILL_ROLE_MST R WHERE USER_NAME=:APP_USER AND U.ROLE_ID=R.ROLE_ID)<>3 OR 
 ((SELECT ROLE_TYPE FROM MBILL_USER_MST U,MBILL_ROLE_MST R WHERE USER_NAME=:APP_USER AND U.ROLE_ID=R.ROLE_ID)=3 AND  
   (a.LOCATION_CODE,a.AREA_CODE) IN(SELECT LOCATION_CODE,AREA_CODE FROM MBILL_METER_READER_ALLOCATION
                                    WHERE METER_READER_ID IN(
                                                             SELECT METER_READER_ID FROM MBILL_METER_READER_MST
                                                            where USER_ID<>:APP_USER
                                                            start with USER_ID=:APP_USER
                                                            connect by prior  METER_READER_ID=P_METER_READER_ID)
                                     AND NVL(EFF_BILL_CYCLE_CODE,:p63_BILL_CYCLE )<=:p63_BILL_CYCLE 
                                     AND NVL(EXP_BILL_CYCLE_CODE,:p63_BILL_CYCLE )>=:p63_BILL_CYCLE)))
and substr(a.area_code,4,2) LIKE NVL(:p63_billgr,'%')
and c.location_code=a.location_code
and f.LOCATION_CODE=a.LOCATION_CODE
AND f.FEEDER_NO=a.FEEDER_NO
AND f.STATUS='A'
and d.location_code=a.location_code
and d.area_code=a.area_code
and b.location_code=rnt.location_code(+)
and b.area_code=rnt.area_code(+)
and b.bill_cycle_code=mr.bill_cycle_code(+)
and b.location_code=mr.location_code(+)
and b.area_code=mr.area_code(+)
and b.bill_cycle_code=rnt.bill_cycle_code(+)
group by  :p63_BILL_CYCLE,zone_name,circle_name,location_name,:p63_location ,f.DESCR,a.area_code
order by  a.area_code


---9.mrs entry reading chk

/*
select APEX_ITEM.CHECKBOX(1,d.cust_id) select1,
d.cust_id cust_id, METER_READING_ID,
    '<img src="f?p='||:APP_ID||':10:'||:APP_SESSION||':'||METER_READING_ID||'" height="200" width="300"  />' detail_img,  
'<button type="button" style="color:blue;font-weight:bold;" onClick="openForm1('||nvl(d.OPN_KWH_SR_RDNG,0)||','||nvl(d.CLS_KWH_SR_RDNG,0)||','||nvl(d.CONS_KWH_SR,0)||','
||to_char(lpad(nvl(d.METER_COND_KWH,0),2,0))||','||d.CUST_ID||','||d.BILL_CYCLE_CODE||');">Update Reading</button>' aaa,
--R.IMG_KWH_SR,
R.LOCATION_CODE,
case when D.cust_id in (select cust_id from MBILL_COMMENTS where bill_cycle_code=:P65_BILL_CYCLE_CODE  )  
 then '<button type="button" style="color:red;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:43:&SESSION.::43::P43_CUST_id,P43_BILL_CYCLE_CODE:'
||D.cust_id||','||:P65_BILL_CYCLE_CODE||'''">View Reply</button>'
     else   NULL  end as VIEW_REPLY,
R.DESCR,
--R.CUSTOMER_NUM CUSTOMER_NUM,
case when D.cust_id in (select cust_id from MBILL_COMMENTS where bill_cycle_code=:P65_BILL_CYCLE_CODE)  
 then '<P1>'||R.CUSTOMER_NUM||CHECK_DIGIT||'</P1>'
     else    '<P65>'||R.CUSTOMER_NUM||R.CHECK_DIGIT||'</P65>' end as CUSTOMER_NUM ,
R.METER_NUM,
R.CUSTOMER_NAME,
R.ADDRESS,
R.AREA_CODE,
d.BILL_CYCLE_CODE,
R.WALK_SEQ WALK_ORDER,
R.METER_READER_NAME,
r.OPN_KWH_SR_RDNG,
(select PREV_METER_COND_KWH from mbill_meter_reading_card_dtl
where cust_id=d.cust_id
and bill_cycle_code=to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-1),'RRRRMM')) prev_meter_condtion,
(select '('||ROUND(D.LATITUDE,9)||','||ROUND(D.LONGITUDE,9)||')' FROM MBILL_customer_meter
where cust_id=d.CUST_ID
AND METER_STATUS=2 and rownum=1) PRV_GPS,
case when D.cust_id in (select cust_id from MBILL_COMMENTS where bill_cycle_code=:P65_BILL_CYCLE_CODE) 
OR D.cust_id in (select cust_id from MBILL_COMMENTS_X where bill_cycle_code=:P65_BILL_CYCLE_CODE) 
 then '<P1>'||R.CLS_KWH_SR_RDNG||'</P1>'
     else    '<P65>'||R.CLS_KWH_SR_RDNG||'</P65>' end as CLS_KWH_SR_RDNG,
--R.CLS_KWH_SR_RDNG,
R.CONS_KWH_SR,
D.METER_COND_KWH,
R.METER_DIGIT_KWH,
decode (r.REASON_CODE,6,'<p1>'||(select name from V_MBILL_RDG_PROB_REASON xx where  xx.CODE=r.REASON_CODE)||'</p1>',(select name from V_MBILL_RDG_PROB_REASON xx where  xx.CODE=r.REASON_CODE)) REASON,
--CM.METER_NUM,
LTRIM(TO_CHAR(D.IMG_KWH_SR_DATE,'DD-MON-RR')) IMAGE_DATE,
TO_CHAR(D.IMG_KWH_SR_DATE,'HH:MM:SS PM') IMAGE_TIME,
'('||ROUND(D.LATITUDE,7)||','||ROUND(D.LONGITUDE,7)||')' CRR_GPS,
case when round(DPD_POS_distances(cm.LATITUDE,cm.LONGITUDE,D.LATITUDE,D.LONGITUDE),4)=0 then
 '<p65>'||round(DPD_POS_distances(cm.LATITUDE,cm.LONGITUDE,D.LATITUDE,D.LONGITUDE),4) ||' (meter)'||'</p65>' 
 else
 '<p1>'||round(DPD_POS_distances(cm.LATITUDE,cm.LONGITUDE,D.LATITUDE,D.LONGITUDE),4) ||' (meter)'||'</p1>'
 end as
 DISTANCE,
case 
when d.rgd_status = 'P' then
    '<span style="  background: -moz-radial-gradient(center, ellipse cover, green 100%, #2989d8 49%, #207cca 70%, #7db9e8 100%);  color:#ffffff;" >Passed</span>'
when (d.rgd_status is null AND D.CLS_KWH_SR_RDNG IS NOT NULL)
then
--'<a href="f?p=&APP_ID.:65:'||:app_session||'::65:NO:P65_CUST,P65_ND_RGD_STATUS:'||r.cust_id||','||'P'||'" "
--class="demoAddtoCart">  
 '<button type="button" style="  background: -moz-radial-gradient(center, ellipse cover, white 100%, #2989d8 49%, red 70%, #7db9e8 100%;color:red);  --color:#ffffff;" >Pass</button></a>' end as "PASS",
 --'<button type="button" style="color:blue;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:2:&--SESSION.::2::P65_CUST,P65_ND_RGD_STATUS:'||r.cust_id||','||'B'||'''">Block</button>' BLOCK,
case when d.rgd_status='B'
then  '<span style="  background: -moz-radial-gradient(center, ellipse cover, green 100%, #2989d8 49%, #207cca 70%, #7db9e8 100%);  color:#ffffff;" >Blocked</span>'
else
'<button type="button" style="color:blue;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:123:&SESSION.::123::P123_CUST_NUM,P123_BILL_CYCLE,P123_CUST_ID:'
||"R"."CUSTOMER_NUM"||','||:P65_BILL_CYCLE_CODE||','||d.cust_id||'''">BLOCK</button>' end as BLOCK,
'<button type="button" style="color: #890b7e;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:128:&SESSION.::128::P128_CUST_NUM,P128_BILL_CYCLE,P128_RGD_STATUS,P128_CUST_ID:'
||"R"."CUSTOMER_NUM"||','||:P65_BILL_CYCLE_CODE||','||"D"."RGD_STATUS"||','||d.cust_id||'''">XENBLOCK</button>'  XENBLOCK,
'<button type="button" style="color:blue;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:26:&SESSION.::26::P26_CUST_NUMBER,P26_BILL_CYCLE:'
||"R"."CUSTOMER_NUM"||','||:P65_BILL_CYCLE_CODE||'''">bill</button>' CUST_BILL,
'<button type="button" style="color:blue;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:32:&SESSION.::32::P32_CUST_NUMBER,P32_BILL_CYCLE:'
||"R"."CUSTOMER_NUM"||','||:P65_BILL_CYCLE_CODE||'''">Locate</button>' CUST_MAP,
'<button type="button" style="color:blue;font-weight:bold;" onclick="myfunction('||R.cust_id||','||R.bill_cycle_code||','||R.CUSTOMER_NUM||','||R.METER_NUM||')">Comments</button>' COMM,
'<p3>'||'Last Three Month Cons: '||UNIT_1||','||UNIT_2||','||UNIT_3||'</p3>' last3_mon
 from MBILL_METER_READING_CARD_DTL d,MBILL_CUSTOMER_READING r ,MBILL_customer_meter cm,
 (select CUST_ID,SUM(DECODE(bill_cycle_code,to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-1),'RRRRMM'),unit,0)) UNIT_1,
               SUM(DECODE(bill_cycle_code,to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-2),'RRRRMM'),unit,0)) UNIT_2,
               SUM(DECODE(bill_cycle_code,to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-3),'RRRRMM'),unit,0)) UNIT_3
 from V_CUST_BC_UNIT
where bill_cycle_code>=to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-3),'RRRRMM')
GROUP BY CUST_ID) unt
 where d.cust_id=r.cust_id
 AND NVL(D.RGD_STATUS,'X')=NVL(:P65_STATUS,'X')
 and unt.cust_id(+)=r.cust_id
 and d.bill_cycle_code=r.bill_cycle_code
 and d.CUST_ID=cm.CUST_ID
AND CM.EQUIP_ID=D.METER_ID
AND LOCATION_CODE=:P65_LOCATION_CODE
AND AREA_CODE=:P65_AREA_CODE
and cm.CUSTOMER_NUM like nvl(:P65_CUSTOMER_NUMBER,'%')
and d.meter_status in ('1','2')
 and D.METER_ID=CM.EQUIP_ID
AND D.BILL_CYCLE_CODE=:P65_BILL_CYCLE_CODE
and (r.IMG_KWH_SR  is not null or r.IMAGE_KWH is not null)
ORDER BY R.WALK_SEQ
*/

select APEX_ITEM.CHECKBOX(1,d.cust_id) select1,
d.cust_id cust_id, METER_READING_ID,
    '<img src="f?p='||:APP_ID||':10:'||:APP_SESSION||':'||METER_READING_ID||d.CUST_ID||'" height="200" width="300"  />' detail_img,  
'<button type="button" style="color:blue;font-weight:bold;" onClick="openForm1('||nvl(d.OPN_KWH_SR_RDNG,0)||','||nvl(d.CLS_KWH_SR_RDNG,0)||','||nvl(d.CONS_KWH_SR,0)||','
||to_char(lpad(nvl(d.METER_COND_KWH,0),2,0))||','||d.CUST_ID||','||d.BILL_CYCLE_CODE||');">Update Reading</button>' aaa,
--R.IMG_KWH_SR,
R.LOCATION_CODE,
case when D.cust_id in (select cust_id from MBILL_COMMENTS where bill_cycle_code=:P65_BILL_CYCLE_CODE  )  
 then '<button type="button" style="color:red;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:43:&SESSION.::43::P43_CUST_id,P43_BILL_CYCLE_CODE:'
||D.cust_id||','||:P65_BILL_CYCLE_CODE||'''">View Reply</button>'
     else   NULL  end as VIEW_REPLY,
R.DESCR,
--R.CUSTOMER_NUM CUSTOMER_NUM,
case when D.cust_id in (select cust_id from MBILL_COMMENTS where bill_cycle_code=:P65_BILL_CYCLE_CODE)  
 then '<P1>'||R.CUSTOMER_NUM||CHECK_DIGIT||'</P1>'
     else    '<P65>'||R.CUSTOMER_NUM||R.CHECK_DIGIT||'</P65>' end as CUSTOMER_NUM ,
R.METER_NUM,
R.CUSTOMER_NAME,
R.ADDRESS,
R.AREA_CODE,
d.BILL_CYCLE_CODE,
R.WALK_SEQ WALK_ORDER,
R.METER_READER_NAME,
DECODE(r.tod_code,'01',to_char(r.OPN_KWH_SR_RDNG),'02','PK:'||to_char(nvl(r.OPN_KWH_PK_RDNG,'0'))||',OFPK:'||to_char(nvl(r.OPN_KWH_OFPK_RDNG,'0'))) OPN_KWH_SR_RDNG,
(select PREV_METER_COND_KWH from mbill_meter_reading_card_dtl
where cust_id=d.cust_id
and bill_cycle_code=to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-1),'RRRRMM')) prev_meter_condtion,
/*(select '('||ROUND(D.LATITUDE,9)||','||ROUND(D.LONGITUDE,9)||')' FROM MBILL_customer_meter
where cust_id=d.CUST_ID
AND METER_STATUS=2 and rownum=1) PRV_GPS,*/
 '('||ROUND(cdprev.LATITUDE,7)||','||ROUND(cdprev.LONGITUDE,7)||')'  PRV_GPS,
case when D.cust_id in (select cust_id from MBILL_COMMENTS where bill_cycle_code=:P65_BILL_CYCLE_CODE) 
OR D.cust_id in (select cust_id from MBILL_COMMENTS_X where bill_cycle_code=:P65_BILL_CYCLE_CODE) 
 then '<P1>'||DECODE(r.tod_code,'01',to_char(r.CLS_KWH_SR_RDNG),'02','PK:'||to_char(nvl(r.CLS_KWH_PK_RDNG,'0'))||',OFPK:'||to_char(nvl(r.CLS_KWH_OFPK_RDNG,'0')))||'</P1>'
     else    '<P65>'||DECODE(r.tod_code,'01',to_char(r.CLS_KWH_SR_RDNG),'02','PK:'||to_char(nvl(r.CLS_KWH_PK_RDNG,'0'))||',OFPK:'||to_char(nvl(r.CLS_KWH_OFPK_RDNG,'0')))||'</P65>' end as CLS_KWH_SR_RDNG,
--R.CLS_KWH_SR_RDNG,
DECODE(r.tod_code,'01',to_char(r.CONS_KWH_SR),'02','PK:'||to_char(nvl(r.CONS_KWH_PK,'0'))||',OFPK:'||to_char(nvl(r.CONS_KWH_OFPK,'0'))) CONS_KWH_SR,
D.METER_COND_KWH,
R.METER_DIGIT_KWH,
decode (r.REASON_CODE,6,'<p1>'||(select name from V_MBILL_RDG_PROB_REASON xx where  xx.CODE=r.REASON_CODE)||'</p1>',(select name from V_MBILL_RDG_PROB_REASON xx where  xx.CODE=r.REASON_CODE)) REASON,
--CM.METER_NUM,
LTRIM(TO_CHAR(D.IMG_KWH_SR_DATE,'DD-MON-RR')) IMAGE_DATE,
TO_CHAR(D.IMG_KWH_SR_DATE,'HH:MM:SS PM') IMAGE_TIME,
'('||ROUND(D.LATITUDE,7)||','||ROUND(D.LONGITUDE,7)||')' CRR_GPS,
case when round(CALC_DISTANCE(cdprev.LATITUDE,cdprev.LONGITUDE,D.LATITUDE,D.LONGITUDE),4)=0 then
 '<p65>'||round(CALC_DISTANCE(cdprev.LATITUDE,cdprev.LONGITUDE,D.LATITUDE,D.LONGITUDE),4) ||' (meter)'||'</p65>' 
 else
 '<p1>'||round(CALC_DISTANCE(cdprev.LATITUDE,cdprev.LONGITUDE,D.LATITUDE,D.LONGITUDE),4) ||' (meter)'||'</p1>'
 end as
 DISTANCE,
case 
when d.rgd_status = 'P' then
    '<span style="  background: -moz-radial-gradient(center, ellipse cover, green 100%, #2989d8 49%, #207cca 70%, #7db9e8 100%);  color:#ffffff;" >Passed</span>'
when (d.rgd_status is null AND D.CLS_KWH_SR_RDNG IS NOT NULL)
then
--'<a href="f?p=&APP_ID.:65:'||:app_session||'::65:NO:P65_CUST,P65_ND_RGD_STATUS:'||r.cust_id||','||'P'||'" "
--class="demoAddtoCart">  
 '<button type="button" style="  background: -moz-radial-gradient(center, ellipse cover, white 100%, #2989d8 49%, red 70%, #7db9e8 100%;color:red);  --color:#ffffff;" >Pass</button></a>' end as "PASS",
 --'<button type="button" style="color:blue;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:2:&--SESSION.::2::P65_CUST,P65_ND_RGD_STATUS:'||r.cust_id||','||'B'||'''">Block</button>' BLOCK,
case when d.rgd_status='B'
then  '<span style="  background: -moz-radial-gradient(center, ellipse cover, green 100%, #2989d8 49%, #207cca 70%, #7db9e8 100%);  color:#ffffff;" >Blocked</span>'
else
'<button type="button" style="color:blue;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:123:&SESSION.::123::P123_CUST_NUM,P123_BILL_CYCLE,P123_CUST_ID:'
||"R"."CUSTOMER_NUM"||','||:P65_BILL_CYCLE_CODE||','||d.cust_id||'''">BLOCK</button>' end as BLOCK,
'<button type="button" style="color: #890b7e;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:128:&SESSION.::128::P128_CUST_NUM,P128_BILL_CYCLE,P128_RGD_STATUS,P128_CUST_ID:'
||"R"."CUSTOMER_NUM"||','||:P65_BILL_CYCLE_CODE||','||"D"."RGD_STATUS"||','||d.cust_id||'''">XENBLOCK</button>'  XENBLOCK,
'<button type="button" style="color:blue;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:26:&SESSION.::26::P26_CUST_NUMBER,P26_BILL_CYCLE:'
||"R"."CUSTOMER_NUM"||','||:P65_BILL_CYCLE_CODE||'''">bill</button>' CUST_BILL,
'<button type="button" style="color:blue;font-weight:bold;" onclick="location.href=''f?p=&APP_ID.:32:&SESSION.::32::P32_CUST_NUMBER,P32_BILL_CYCLE:'
||"R"."CUSTOMER_NUM"||','||:P65_BILL_CYCLE_CODE||'''">Locate</button>' CUST_MAP,
'<button type="button" style="color:blue;font-weight:bold;" onclick="myfunction('||R.cust_id||','||R.bill_cycle_code||','||R.CUSTOMER_NUM||','||R.METER_NUM||')">Comments</button>' COMM,r.mobile Mobile,
'<p3>'||'Meter Status:'|| decode(d.meter_status,2,'Connected','Temp Disconeccted') ||' ; Last Three Month Cons: '||UNIT_1||','||UNIT_2||','||UNIT_3||'</p3>' last3_mon
 from MBILL_METER_READING_CARD_DTL d,MBILL_CUSTOMER_READING r ,MBILL_customer_meter cm,(select cust_id,bill_cycle_code,LATITUDE,LONGITUDE from MBILL_METER_READING_CARD_DTL where  bill_cycle_code>=to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-1),'RRRRMM')) cdprev, 
 (select CUST_ID,SUM(DECODE(bill_cycle_code,to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-1),'RRRRMM'),unit,0)) UNIT_1,
               SUM(DECODE(bill_cycle_code,to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-2),'RRRRMM'),unit,0)) UNIT_2,
               SUM(DECODE(bill_cycle_code,to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-3),'RRRRMM'),unit,0)) UNIT_3
 from V_CUST_BC_UNIT
where bill_cycle_code>=to_char(add_months(to_date(:P65_BILL_CYCLE_CODE,'RRRRMM'),-3),'RRRRMM')
GROUP BY CUST_ID) unt
 where d.cust_id=r.cust_id
 AND NVL(D.RGD_STATUS,'X')=NVL(:P65_STATUS,'X')
 and unt.cust_id(+)=r.cust_id
 and d.bill_cycle_code=r.bill_cycle_code
  and cdprev.cust_id(+)=r.cust_id
 and cdprev.bill_cycle_code(+)=r.bill_cycle_code
 and d.CUST_ID=cm.CUST_ID
AND CM.EQUIP_ID=D.METER_ID
AND LOCATION_CODE=:P65_LOCATION_CODE
AND AREA_CODE=:P65_AREA_CODE
and cm.CUSTOMER_NUM like nvl(:P65_CUSTOMER_NUMBER,'%')
and d.meter_status in ('1','2')
 and D.METER_ID=CM.EQUIP_ID
AND D.BILL_CYCLE_CODE=:P65_BILL_CYCLE_CODE
and (r.IMG_KWH_SR  is not null or r.IMAGE_KWH is not null)
ORDER BY R.WALK_SEQ