
----without privat consumer Ministry Wise Cons. List----

select b.MINISTRY,b.DEPARTMENT,a.* from (
SELECT    l.location_code,
   l.DESCR location_name,
    substr(a.AREA_CODE,4) bill_group,
        substr(a.AREA_CODE,1,3) book,
        trim(b.METER_NUM_KWH) meter_num,
    a.CUSTOMER_NUM||CHECK_DIGIT CUSTOMER_NUM,
    a.CUSTOMER_NAME,
    d.ADDR_DESCR1||'-'||ADDR_DESCR2||'-'||ADDR_DESCR3 address,
    '' ministry_code,'' department_code,
    a.CUST_ID
FROM  ebc.BC_BILL_IMAGE b, bc_location_master l,
(select cust_id,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=:bill_cycle_code and invoice_num is not null group by cust_id) bi,
     BC_CUSTOMERS a, 
    BC_CUSTOMER_ADDR d
WHERE b.cust_id = a.cust_id 
AND b.cust_id = d.cust_id
and b.bill_cycle_code=bi.bill_cycle_code
and b.cust_id=bi.cust_id
and l.location_code=b.location_code
and b.invoice_num is not null
and b.CUST_STATUS<>'05'
--AND b.LOCATION_CODE = :p_location_code 
AND d.addr_type = 'B'
AND d.addr_exp_date IS NULL 
and a.customer_status_code='C')a,(
select cc.CUST_ID,   f.code_descr Ministry,  ctm.code_descr Department from     
BC_CUSTOMER_CATEGORY cc,  BC_CATEGORY_MASTER cm ,BC_CUSTOMER_TYPE_CODE e,BC_MINISTRY_CODE f,BC_CUSTOMER_TYPE_MST ctm
where  cc.CAT_ID = cm.CATEGORY_ID
AND cc.EXP_DATE IS NULL 
AND cm.CUSTOMER_TYPE_CODE = e.CUSTOMER_TYPE_CODE
AND e.ministry_code = f.ministry_code
AND NVL(e.customer_type_code_dummy,'71') = ctm.customer_type_code 
AND e.ministry_code IS NOT NULL -- ('98') ctg not in 98
and f.MINISTRY_CODE = ctm.MINISTRY_CODE
and e.CUSTOMER_TYPE_CODE<>'05'
and e.MINISTRY_CODE = ctm.MINISTRY_CODE)b
where a.CUST_ID = b.CUST_ID
order by 5,6



------------



select b.MINISTRY,b.DEPARTMENT,a.* from (
SELECT a.CUST_ID,
   l.location_code,
   l.DESCR location_name,
    substr(a.AREA_CODE,4) bill_group,
        substr(a.AREA_CODE,1,3) book,
    a.CUSTOMER_NUM||CHECK_DIGIT CUSTOMER_NUM,
    a.CUSTOMER_NAME,
    d.ADDR_DESCR1||'-'||ADDR_DESCR2||'-'||ADDR_DESCR3 address
FROM  ebc.BC_BILL_IMAGE b, bc_location_master l,
(select cust_id,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=202201 and invoice_num is not null group by cust_id) bi,
     BC_CUSTOMERS a, 
    BC_CUSTOMER_ADDR d
WHERE b.cust_id = a.cust_id 
AND b.cust_id = d.cust_id
and b.bill_cycle_code=bi.bill_cycle_code
and b.cust_id=bi.cust_id
and l.location_code=b.location_code
and b.invoice_num is not null
--AND b.LOCATION_CODE = :p_location_code 
AND d.addr_type = 'B'
AND d.addr_exp_date IS NULL 
and a.customer_status_code='C')a,(
select cc.CUST_ID,   f.code_descr Ministry,  ctm.code_descr Department from     
BC_CUSTOMER_CATEGORY cc,  BC_CATEGORY_MASTER cm ,BC_CUSTOMER_TYPE_CODE e,BC_MINISTRY_CODE f,BC_CUSTOMER_TYPE_MST ctm
where  cc.CAT_ID = cm.CATEGORY_ID
AND cc.EXP_DATE IS NULL 
AND cm.CUSTOMER_TYPE_CODE = e.CUSTOMER_TYPE_CODE
AND e.ministry_code = f.ministry_code
AND NVL(e.customer_type_code_dummy,'71') = ctm.customer_type_code 
AND e.ministry_code IS NOT NULL -- ('98') ctg not in 98
and f.MINISTRY_CODE = ctm.MINISTRY_CODE
and e.MINISTRY_CODE = ctm.MINISTRY_CODE)b
where a.CUST_ID = b.CUST_ID

-----------------with arrear-----without ctg---

select b.MINISTRY,b.DEPARTMENT,a.* from (
SELECT a.CUST_ID,
   l.location_code,
   l.DESCR location_name,
       substr(a.AREA_CODE,1,3) book,
    substr(a.AREA_CODE,4) bill_group,
    a.CUSTOMER_NUM||CHECK_DIGIT CUSTOMER_NUM,
    a.CUSTOMER_NAME,
    d.ADDR_DESCR1||'-'||ADDR_DESCR2||'-'||ADDR_DESCR3 address,
      sum(NVL(b.arr_adv_adj_prn,0) + NVL(b.adjusted_prn,0)) Energy_arr, 
    sum(NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0))  Current_prin,
   sum(NVL(b.arr_adv_adj_vat,0) + NVL(b.adjusted_vat,0)) Vat_arr, 
   sum(NVL(b.current_vat,0))  Current_vat,
   sum(NVL(b.arr_adv_adj_lps,0) + NVL(b.adjusted_lps,0)) Surcharge_arr,
   sum(nvl(Current_lps,0)) Current_lps
FROM  ebc.BC_BILL_IMAGE b, bc_location_master l,
(select cust_id,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=202201 and invoice_num is not null group by cust_id) bi,
     BC_CUSTOMERS a, 
    BC_CUSTOMER_ADDR d
WHERE b.cust_id = a.cust_id 
AND b.cust_id = d.cust_id
and b.bill_cycle_code=bi.bill_cycle_code
and b.cust_id=bi.cust_id
and l.location_code=b.location_code
and b.invoice_num is not null
--AND b.LOCATION_CODE = :p_location_code 
AND d.addr_type = 'B'
AND d.addr_exp_date IS NULL 
and a.customer_status_code='C'
group by a.CUST_ID,
   l.location_code,
   l.DESCR ,
       substr(a.AREA_CODE,1,3) ,
    substr(a.AREA_CODE,4) ,
    a.CUSTOMER_NUM||CHECK_DIGIT ,
    a.CUSTOMER_NAME,
    d.ADDR_DESCR1||'-'||ADDR_DESCR2||'-'||ADDR_DESCR3 )a,(
select cc.CUST_ID,   f.code_descr Ministry,  ctm.code_descr Department from     
BC_CUSTOMER_CATEGORY cc,  BC_CATEGORY_MASTER cm ,BC_CUSTOMER_TYPE_CODE e,BC_MINISTRY_CODE f,BC_CUSTOMER_TYPE_MST ctm
where  cc.CAT_ID = cm.CATEGORY_ID
AND cc.EXP_DATE IS NULL 
AND cm.CUSTOMER_TYPE_CODE = e.CUSTOMER_TYPE_CODE
AND e.ministry_code = f.ministry_code
AND NVL(e.customer_type_code_dummy,'71') = ctm.customer_type_code 
AND e.ministry_code IS NOT NULL -- ('98') ctg not in 98
and f.MINISTRY_CODE = ctm.MINISTRY_CODE
and e.MINISTRY_CODE = ctm.MINISTRY_CODE)b
where a.CUST_ID = b.CUST_ID


----------ctg-------

select b.MINISTRY_CODE,b.MINISTRY,b.DEPARTMENT,a.* from (
SELECT a.CUST_ID,
   l.location_code,
   l.DESCR location_name,
       substr(a.AREA_CODE,1,3) book,
    substr(a.AREA_CODE,4) bill_group,
    a.CUSTOMER_NUM||CHECK_DIGIT CUSTOMER_NUM,
    a.CUSTOMER_NAME,
    d.ADDR_DESCR1||'-'||ADDR_DESCR2||'-'||ADDR_DESCR3 address,
      sum(NVL(b.arr_adv_adj_prn,0) + NVL(b.adjusted_prn,0)) Energy_arr, 
    sum(NVL(ENG_CHRG_SR,0)+ NVL(ENG_CHRG_OFPK,0)+NVL(ENG_CHRG_PK,0)+NVL(MINIMUM_CHRG,0) +NVL(SERVICE_CHRG,0)+NVL(DEMAND_CHRG,0)+
       NVL(XF_RENT,0)+NVL(XF_LOSS_CHRG,0)+NVL(PFC_CHARGE,0))  Current_prin,
   sum(NVL(b.arr_adv_adj_vat,0) + NVL(b.adjusted_vat,0)) Vat_arr, 
   sum(NVL(b.current_vat,0))  Current_vat,
   sum(NVL(b.arr_adv_adj_lps,0) + NVL(b.adjusted_lps,0)) Surcharge_arr,
   sum(nvl(Current_lps,0)) Current_lps
FROM  ebc.BC_BILL_IMAGE b, bc_location_master l,
(select cust_id,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=202201 and invoice_num is not null group by cust_id) bi,
     BC_CUSTOMERS a, 
    BC_CUSTOMER_ADDR d
WHERE b.cust_id = a.cust_id 
AND b.cust_id = d.cust_id
and b.bill_cycle_code=bi.bill_cycle_code
and b.cust_id=bi.cust_id
and l.location_code=b.location_code
and b.invoice_num is not null
--AND b.LOCATION_CODE = :p_location_code 
AND d.addr_type = 'B'
AND d.addr_exp_date IS NULL 
and a.customer_status_code='C'
group by a.CUST_ID,
   l.location_code,
   l.DESCR ,
       substr(a.AREA_CODE,1,3) ,
    substr(a.AREA_CODE,4) ,
    a.CUSTOMER_NUM||CHECK_DIGIT ,
    a.CUSTOMER_NAME,
    d.ADDR_DESCR1||'-'||ADDR_DESCR2||'-'||ADDR_DESCR3 )a,(
select cc.CUST_ID, f.MINISTRY_CODE,  f.code_descr Ministry,  ctm.code_descr Department from     
BC_CUSTOMER_CATEGORY cc,  BC_CATEGORY_MASTER cm ,BC_CUSTOMER_TYPE_CODE e,BC_MINISTRY_CODE f,BC_CUSTOMER_TYPE_MST ctm
where  cc.CAT_ID = cm.CATEGORY_ID
AND cc.EXP_DATE IS NULL 
AND cm.CUSTOMER_TYPE_CODE = e.CUSTOMER_TYPE_CODE
AND e.ministry_code = f.ministry_code
AND NVL(e.customer_type_code_dummy,'71') = ctm.customer_type_code 
AND e.ministry_code IS NOT NULL -- ('98') ctg not in 98
--and f.MINISTRY_CODE = ctm.MINISTRY_CODE
--and e.MINISTRY_CODE = ctm.MINISTRY_CODE
)b
where a.CUST_ID = b.CUST_ID
and b.MINISTRY_CODE='56'


-----sir corr----

select  a.ministry_code,a.Ministry, SUB_DEPT_DESC Department, SUB_DEPT_CODE cust_status, a.LOCATION_CODE,  a.loc_desc,bill_gr,book_no,cons_extg_num,customer_num,a.Customer_name,a.Address,sum(NVL(a.Current_prin ,0)+nvl(a.Current_vat,0)+NVL(a.Energy_arr,0)+nvl(a.Vat_arr,0)) Receiveable,sum(NVL(a.Surcharge_arr,0)+NVL(a.Current_lps,0)) surcharge_arr,
sum(NVL(a.Current_prin,0))+sum(NVL(a.Energy_arr,0))+sum(NVL(a.Surcharge_arr,0)+NVL(a.Current_lps,0)+nvl(a.Current_vat,0)+nvl(a.Vat_arr,0)) total_Receiveable,a.curr_coll
from (
SELECT l.descr loc_desc,
   b.LOCATION_CODE,
   f.ministry_code,
   f.code_descr Ministry,
   V.REFERENCE_CODE DEPT_CODE,V.REFERENCE_DESC DEPT_DESC,
   V.CUSTOMER_TYPE_CODE SUB_DEPT_CODE,V.CODE_DESCR SUB_DEPT_DESC,
   SUBSTR(b.area_code,1,3) book_no,
   SUBSTR(b.area_code,4,2) bill_gr,
   b.tariff,
   b.customer_num||c.check_digit customer_num,
   b.cons_extg_num,
   SUBSTR(c.customer_name,1,34) Customer_name,
   SUBSTR(d.addr_descr1,0,22) Address,
   b.INVOICE_NUM,
   NVL(b.ENG_CHRG_SR,0)+ NVL(b.ENG_CHRG_OFPK,0)+NVL(b.ENG_CHRG_PK,0)+NVL(b.MINIMUM_CHRG,0) +NVL(b.SERVICE_CHRG,0)+NVL(b.DEMAND_CHRG,0)+
       NVL(b.XF_RENT,0)+NVL(b.XF_LOSS_CHRG,0)+NVL(b.PFC_CHARGE,0)  +  NVL(b.arr_adv_adj_prn,0) + NVL(b.adjusted_prn,0) Energy_arr, 
   --NVL(b.current_vat,0) + 
    NVL(b.ENG_CHRG_SR,0)+ NVL(b.ENG_CHRG_OFPK,0)+NVL(b.ENG_CHRG_PK,0)+NVL(b.MINIMUM_CHRG,0) +NVL(b.SERVICE_CHRG,0)+NVL(b.DEMAND_CHRG,0)+
       NVL(b.XF_RENT,0)+NVL(b.XF_LOSS_CHRG,0)+NVL(b.PFC_CHARGE,0)  Current_prin,
   NVL(b.arr_adv_adj_vat,0) + NVL(b.adjusted_vat,0) Vat_arr, 
   NVL(b.current_vat,0)  Current_vat,
   NVL(b.arr_adv_adj_lps,0) + NVL(b.adjusted_lps,0) Surcharge_arr,
    nvl(b.Current_lps,0) Current_lps,
     nvl(b.RCPT_PRN_1,0)+nvl(b.RCPT_PRN_2,0)+nvl(b.RCPT_PRN_3,0) curr_coll,
     nvl(x.RCPT_PRN_1,0)+nvl(x.RCPT_PRN_2,0)+nvl(x.RCPT_PRN_3,0) prev_coll
FROM bc_location_master l, BC_BILL_IMAGE b, BC_BILL_IMAGE x ,
     BC_CUSTOMERS c,
    BC_CUSTOMER_ADDR d,
    BC_CUSTOMER_TYPE_CODE e,
    BC_MINISTRY_CODE f,
    --BC_CUSTOMER_TYPE_MST ctm,
    BC_CUSTOMER_OWNER_TYPE o,
    BC_CUSTOMER_CATEGORY cc,
    BC_CATEGORY_MASTER cm,
    EMP.VW_MIN_CUST_TYPE V,(select cust_id,max(bill_cycle_code) bill_cycle_code from bc_bill_image
where bill_cycle_code<=:p_bill_cycle_code and invoice_num is not null group by cust_id) bi
WHERE-- b.bill_cycle_code = :p_bill_cycle_code
 b.cust_id = c.cust_id
AND b.cust_id = d.cust_id
AND b.cust_id = cc.cust_id
and  c.location_code=l.location_code
and v.CUSTOMER_TYPE_CODE in ('10','11')
and b.bill_cycle_code=bi.bill_cycle_code
and  b.invoice_num is not null
and x.bill_cycle_code=to_char(add_months(to_date(bi.bill_cycle_code,'RRRRMM'),-1),'RRRRMM')
and x.cust_id=bi.cust_id
and x.invoice_num is not null
and b.cust_id=bi.cust_id
AND cc.CAT_ID = cm.CATEGORY_ID
AND cc.EXP_DATE IS NULL
AND cm.CUSTOMER_TYPE_CODE = e.CUSTOMER_TYPE_CODE
--AND b.LOCATION_CODE = :p_location_code
AND v.MINISTRY_CODE||v.CUSTOMER_TYPE_CODE=SUBSTR(E.CUSTOMER_TYPE_CODE,1,4)
AND e.CUSTOMER_OWNER_CODE = o.CUSTOMER_OWNER_CODE
AND e.ministry_code = f.ministry_code
AND d.addr_type = 'B'
AND d.addr_exp_date IS NULL
AND e.ministry_code IS NOT NULL
AND f.ministry_code=:p_ministry_code
--AND NVL(e.MINISTRY_CODE,'37') LIKE :p_ministry_code
--AND NVL(e.CUSTOMER_TYPE_CODE_DUMMY,'71') LIKE :p_cust_type_code
--AND NVL(e.CUSTOMER_OWNER_CODE,'1') LIKE :p_owner_code
--AND DECODE(e.CUSTOMER_OWNER_CODE,'5','Y','N') LIKE DECODE(:p_inc_private,'Y','%','N')
ORDER  BY b.LOCATION_CODE,e.ministry_code, e.CUSTOMER_TYPE_CODE_DUMMY, e.CUSTOMER_OWNER_CODE ) a
group by a.ministry_code,a.Ministry, SUB_DEPT_DESC , SUB_DEPT_CODE , a.LOCATION_CODE,  a.loc_desc,bill_gr,book_no,cons_extg_num,customer_num,a.Customer_name,a.Address,a.curr_coll