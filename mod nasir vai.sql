
select a.location_code loc,g.DESCR office,
sum(i.Principal_Arrear) arrear_prin,sum(i.LPS_arrear) arrear_lps,sum(i.vat_Arrear) arrear_vat,
sum(i.Principal_Arrear+i.LPS_arrear+i.vat_Arrear) total_arrear
from ebc.bc_customers a,ebc.bc_customer_category b,ebc.bc_category_master c,ebc.bc_customer_addr e,
ebc.bc_monthly_likely f,ebc.bc_location_master g,
(select cust_id,sum(PRINCIPAL_AMT+PRINCIPAL_ADJ-PRINCIPAL_APPL) Principal_Arrear,sum(LPS_AMT+LPS_ADJ-LPS_APPL) LPS_arrear,
sum(VAT_AMT+VAT_ADJ-VAT_APPL) vat_Arrear from bc_invoice_hdr
group by cust_id) i
where  a.cust_id=e.cust_id
and  a.cust_id=f.cust_id
and a.cust_id=i.cust_id and b.CUST_ID=a.CUST_ID and b.cat_id=c.category_id and b.exp_date is null
and a.LOCATION_CODE=g.LOCATION_CODE
and  f.EXP_DATE is null and e.addr_type='B'
and e.ADDR_EXP_DATE is null and i.Principal_Arrear+i.LPS_arrear+i.vat_Arrear>1
and a.location_code=:loc
group by a.location_code ,g.DESCR
order by a.location_code ,g.DESCR ;