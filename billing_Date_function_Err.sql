--Date Function Error: ORA-01405: fetched column value is NULL

select 
c.CUST_ID,c.LOCATION_CODE,c.area_code,eff_BC EFF_BILL_CYCLE_CODE,b.CYCLE_PERIOD_END_DATE+1 EFF_DATE,
null EXP_BILL_CYCLE_CODE,null EXP_DATE,'C' REC_STATUS,c.create_date,c.create_by,null,null,null
 from (select a.location_code,a.area_code,a.create_date,a.create_by,a.cust_id,emp.DPG_BC_GENERAL.dfn_bc_find_bill_cycle(a.location_code,
                             a.area_code ,
                             PREV_READING_DATE )  EFF_BC
                               from 
                              bc_meter_reading_card_dtl c,bc_customers a
                              where a.cust_id=c.cust_id
                              --AND BILL_CYCLE_CODE='201601'  
                              and a.cust_id in (
select cust_id  from bc_customers where location_code='V9' AND AREA_CODE='H9902')
and bill_cycle_code='201804') c,bc_bill_cycle_code b
 where c.location_code=b.location_code
 and c.area_code=b.area_code
 and c.EFF_BC=to_char(add_months(to_date(b.bill_cycle_code,'RRRRMM'),1),'RRRRMM')
 and c.cust_id in (select cust_id from bc_customers where location_code='V9'AND AREA_CODE='H9902')


select 
c.CUST_ID,c.LOCATION_CODE,c.area_code,eff_BC EFF_BILL_CYCLE_CODE,b.CYCLE_PERIOD_END_DATE+1 EFF_DATE,
null EXP_BILL_CYCLE_CODE,null EXP_DATE,'C' REC_STATUS,c.create_date,c.create_by,null,null,null
 from (select a.location_code,a.area_code,a.create_date,a.create_by,a.cust_id,emp.DPG_BC_GENERAL.dfn_bc_find_bill_cycle(a.location_code,
                             a.area_code ,
                             PREV_READING_DATE )  EFF_BC
                               from 
                              bc_meter_reading_card_dtl c,bc_customers a
                              where a.cust_id=c.cust_id
                              AND (A.CUST_ID,BILL_CYCLE_CODE) IN (SELECT CUST_ID,MIN(BILL_CYCLE_CODE) BILL_CYCLE_CODE FROM BC_METER_READING_CARD_DTL GROUP BY CUST_ID)  
                              and a.cust_id in (
select cust_id  from bc_customers where location_code='V9' AND AREA_CODE='H9902')
--and bill_cycle_code='201601'
) c,bc_bill_cycle_code b
 where c.location_code=b.location_code
 and c.area_code=b.area_code
 and c.EFF_BC=to_char(add_months(to_date(b.bill_cycle_code,'RRRRMM'),1),'RRRRMM')
 and c.cust_id in (select cust_id from bc_customers where location_code='V9'AND AREA_CODE='H9902')
 


UPDATE bc_loc_area_change X
SET (EFF_BILL_CYCLE_CODE,EFF_DATE) =(select 
eff_BC EFF_BILL_CYCLE_CODE,b.CYCLE_PERIOD_END_DATE+1 EFF_DATE
 from (select a.location_code,a.area_code,a.create_date,a.create_by,a.cust_id,emp.DPG_BC_GENERAL.dfn_bc_find_bill_cycle(a.location_code,
                             a.area_code ,
                             PREV_READING_DATE )  EFF_BC
                               from 
                              bc_meter_reading_card_dtl c,bc_customers a
                              where a.cust_id=c.cust_id
                              AND (A.CUST_ID,BILL_CYCLE_CODE) IN (SELECT CUST_ID,MIN(BILL_CYCLE_CODE) BILL_CYCLE_CODE FROM BC_METER_READING_CARD_DTL GROUP BY CUST_ID)  
                              and a.cust_id in (
select cust_id  from bc_customers where location_code='V9' AND AREA_CODE='H9902')
--and bill_cycle_code='201601'
) c,bc_bill_cycle_code b
 where c.location_code=b.location_code
 and c.area_code=b.area_code
 and c.EFF_BC=to_char(add_months(to_date(b.bill_cycle_code,'RRRRMM'),1),'RRRRMM')
 and c.cust_id in (select cust_id from bc_customers where location_code='V9'AND AREA_CODE='H9902')
 AND C.CUST_ID=X.CUST_ID)
WHERE CUST_ID IN(select cust_id  from bc_customers where location_code='V9' AND AREA_CODE='H9902')
