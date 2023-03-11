
select sum(decode(sign(no_of_month-3),1,0,prn_arrear+vat_arrear+lps_arrear)) arr_3,
sum(decode(sign(no_of_month-3),1,decode(sign(no_of_month-6),1,0,prn_arrear+vat_arrear+lps_arrear),0)) arr_6,
sum(decode(sign(no_of_month-3),1,decode(sign(no_of_month-6),1,decode(sign(no_of_month-12),1,0,prn_arrear+vat_arrear+lps_arrear),0),0)) arr_12,
sum(decode(sign(no_of_month-3),1,decode(sign(no_of_month-6),1,decode(sign(no_of_month-12),1,prn_arrear+vat_arrear+lps_arrear,0),0),0)) arr_12_above from ( select cust_id, sum(prn_arrear) prn_arrear ,sum(vat_arrear) vat_arrear,sum(lps_arrear) lps_arrear,count(1) no_of_month from( select b.cust_id,bill_cycle_code,
sum(decode(tariff_type_code,'01',invoice_amount-applied_amount+adjusted_amount,0)) vat_arrear,sum(decode(tariff_type_code,'02',invoice_amount-applied_amount+adjusted_amount,0)) lps_arrear,
sum(decode(tariff_type_code,'01',0,'02',0,invoice_amount-applied_amount+adjusted_amount)) prn_arrear  from bc_invoice_dtl a, bc_invoice_hdr b,bc_customer_category cc,bc_category_master cm where a.invoice_num=b.invoice_num and  bill_cycle_code<='201811'
and invoice_amount-applied_amount+adjusted_amount<>0
and b.cust_id=cc.cust_id
and cc.exp_date is null
and cc.cat_id=cm.category_id
and b.cust_id in(select cust_id from bc_customers where location_code=:p_loc
MINUS
select a.cust_id
FROM      BC_CUSTOMERS a,
       BC_CUSTOMER_TYPE_CODE e,
    BC_MINISTRY_CODE f,
    BC_CUSTOMER_OWNER_TYPE o,
    BC_CUSTOMER_CATEGORY cc,
    BC_CATEGORY_MASTER cm,
    VW_MIN_CUST_TYPE V
WHERE    a.cust_id = cc.cust_id
AND cc.CAT_ID = cm.CATEGORY_ID
AND cc.EXP_DATE IS NULL
AND cm.CUSTOMER_TYPE_CODE = e.CUSTOMER_TYPE_CODE
AND v.MINISTRY_CODE||v.CUSTOMER_TYPE_CODE=SUBSTR(E.CUSTOMER_TYPE_CODE,1,4)
AND e.CUSTOMER_OWNER_CODE = o.CUSTOMER_OWNER_CODE
AND e.ministry_code = f.ministry_code
and a.cust_id in(select cust_id from bc_customers where location_code=:p_loc)
AND e.ministry_code IS NOT NULL
) group by bill_cycle_code,b.cust_id
) c
group by c.cust_id
)