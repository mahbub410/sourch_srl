select a.location_code loc,g.DESCR office,substr(a.AREA_CODE,4,2) bg,substr(a.AREA_CODE,1,3) b_k,
    a.CUSTOMER_NUM||a.CHECK_DIGIT con_no,a.WALKING_SEQUENCE wlk_or,
    a.CONS_EXTG_NUM pv_ac,substr(a.CUSTOMER_NAME,1,35) name,a.F_H_NAME "father/husband Name",
e.addr_descr1,e.addr_descr2,e.addr_descr3,tariff trf,f.MONTHLY_LIKELY_CONS likely,
b.METER_NUM_KWH mtr_no, MC.MANUF_NAME , CM.METER_CONNECT_DATE, CM.METER_INSTALL_DATE,
b.SANC_LOAD s_load,b.CONNECT_LOAD c_load,b.meter_cond_kwh m_cond,
decode(b.METER_STATUS,'2','Regular','1','Temp_Discon','3','Perm_Discon') status
 from ebc.bc_customers a,ebc.bc_bill_image b,ebc.bc_customer_addr e,ebc.bc_customer_meter cm, BC_EQUIP_MAST em,BC_MANUF_CODE mc
,ebc.bc_monthly_likely f,ebc.bc_location_master g
 where a.cust_id=b.cust_id and a.cust_id=e.cust_id and  a.cust_id=f.cust_id and
a.LOCATION_CODE=g.LOCATION_CODE and a.location_code=:loc 
and A.CUST_ID=CM.CUST_ID
and b.bill_cycle_code=:bil_cy  and e.addr_type='B'
and CM.METER_STATUS='2'
and A.CUSTOMER_STATUS_CODE='C'
and CM.EQUIP_ID=EM.EQUIP_ID
and EM.MANUF_CODE=MC.MANUF_CODE
and b.invoice_num is not null and f.EXP_DATE is null and e.ADDR_EXP_DATE is null
order by bg,b_k,wlk_or;