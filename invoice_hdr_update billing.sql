update bc_invoice_hdr
set (vat_amt,vat_appl,vat_adj,lps_amt,lps_appl,lps_adj,principal_amt,principal_appl,principal_adj,invoice_amt,invoice_applied_amt,invoice_adjusted_amt)=(
select sum(decode(tariff_type_code,'01',Invoice_amount,0)) Vat_amt,sum(decode(tariff_type_code,'01',applied_amount,0)) Vat_appl,sum(decode(tariff_type_code,'01',adjusted_amount,0)) Vat_adj,
sum(decode(tariff_type_code,'02',Invoice_amount,0)) lps_amt,sum(decode(tariff_type_code,'02',applied_amount,0)) lps_appl,sum(decode(tariff_type_code,'02',adjusted_amount,0)) lps_adj,
sum(decode(tariff_type_code,'01',0,'02',0,Invoice_amount)) prin_amt,sum(decode(tariff_type_code,'01',0,'02',0,applied_amount)) prin_appl,sum(decode(tariff_type_code,'01',0,'02',0,adjusted_amount)) prin_adj,
sum(Invoice_amount) Invoice_amount,sum(applied_amount) invoice_applied,sum(adjusted_amount) invoice_adjusted
from bc_invoice_dtl
where invoice_num=:inv_num )
where invoice_num=:inv_num

commit;


