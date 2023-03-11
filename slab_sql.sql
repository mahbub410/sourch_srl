
slab_wise_consumtion_cen_name_2015_2016 

1 ----- 2014-1015

select Tariff,'Life Line' Cons_type ,sum(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201407' and bill_cycle_code<='201506'
 and tariff='A'
 and invoice_num is not null
 and  nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)<=50
 group by Tariff,'Life Line'
  union all
           select Tariff,'Slab1 1-75' Cons_type ,sum(
  decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-76),-1,
  nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0),75)) Cons
from ebc.bc_bill_image
 where bill_cycle_code>='201407' and bill_cycle_code<='201506'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 50 
    --and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=75
      group by Tariff,'Slab1 1-75'
        union all
      select Tariff,'Slab2 76-200' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-201),-1,
      nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-75,125)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201407' and bill_cycle_code<='201506'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 75 
  --and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=200
  group by Tariff,'Slab2 76-200'
  union all  
select Tariff,'Slab3 201-300' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-301),-1,nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-200,100)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201407' and bill_cycle_code<='201506'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 200 
 -- and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=300
  group by Tariff,'Slab3 201-300'
    union all
select Tariff,'Slab4 301-400' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-401),-1,
nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-300,100)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201407' and bill_cycle_code<='201506'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 300 
 -- and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=400
  group by Tariff,'Slab4 301-400' 
  union all
select Tariff,'Slab5 401-600' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-601),-1,
nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-400,200)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201407' and bill_cycle_code<='201506'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 400 
  --and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=600
  group by Tariff,'Slab5 401-600'
  union all
  select Tariff,'Slab6 >600' Cons_type,sum(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-600) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201407' and bill_cycle_code<='201506'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 600
   group by Tariff,'Slab6 >600'
    union all  
  select Tariff,'PK' Cons_type,sum(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201407' and bill_cycle_code<='201506'
 and tariff<>'A'
 and invoice_num is not null
   group by Tariff,'PK'
union all  
  select Tariff,'OFF PK' Cons_type,sum(nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201407' and bill_cycle_code<='201506'
 and tariff<>'A'
 and invoice_num is not null
   group by Tariff,'OFF PK'union all  
  select Tariff,'Flat' Cons_type,sum(nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201407' and bill_cycle_code<='201506'
 and tariff<>'A'
 and invoice_num is not null
   group by Tariff,'Flat'  
   order by 1,2
   
   
   
2 ------------ 2013-2014   
   
   select Tariff,'Life Line' Cons_type ,sum(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201307' and bill_cycle_code<='201406'
 and tariff='A'
 and invoice_num is not null
 and  nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)<=50
 group by Tariff,'Life Line'
  union all
           select Tariff,'Slab1 1-75' Cons_type ,sum(
  decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-76),-1,
  nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0),75)) Cons
from ebc.bc_bill_image
 where bill_cycle_code>='201307' and bill_cycle_code<='201406'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 50 
    --and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=75
      group by Tariff,'Slab1 1-75'
        union all
      select Tariff,'Slab2 76-200' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-201),-1,
      nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-75,125)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201307' and bill_cycle_code<='201406'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 75 
  --and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=200
  group by Tariff,'Slab2 76-200'
  union all  
select Tariff,'Slab3 201-300' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-301),-1,nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-200,100)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201307' and bill_cycle_code<='201406'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 200 
 -- and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=300
  group by Tariff,'Slab3 201-300'
    union all
select Tariff,'Slab4 301-400' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-401),-1,
nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-300,100)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201307' and bill_cycle_code<='201406'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 300 
 -- and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=400
  group by Tariff,'Slab4 301-400' 
  union all
select Tariff,'Slab5 401-600' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-601),-1,
nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-400,200)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201307' and bill_cycle_code<='201406'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 400 
  --and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=600
  group by Tariff,'Slab5 401-600'
  union all
  select Tariff,'Slab6 >600' Cons_type,sum(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-600) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201307' and bill_cycle_code<='201406'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 600
   group by Tariff,'Slab6 >600'
    union all  
  select Tariff,'PK' Cons_type,sum(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201307' and bill_cycle_code<='201406'
 and tariff<>'A'
 and invoice_num is not null
   group by Tariff,'PK'
union all  
  select Tariff,'OFF PK' Cons_type,sum(nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201307' and bill_cycle_code<='201406'
 and tariff<>'A'
 and invoice_num is not null
   group by Tariff,'OFF PK'union all  
  select Tariff,'Flat' Cons_type,sum(nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201307' and bill_cycle_code<='201406'
 and tariff<>'A'
 and invoice_num is not null
   group by Tariff,'Flat'  
   order by 1,2
   
   

   
  3 ------------ 2015-2016   
   
   
      select Tariff,'Life Line' Cons_type ,sum(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201507' and bill_cycle_code<='201512'
 and tariff='A'
 and invoice_num is not null
 and  nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)<=50
 group by Tariff,'Life Line'
  union all
           select Tariff,'Slab1 1-75' Cons_type ,sum(
  decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-76),-1,
  nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0),75)) Cons
from ebc.bc_bill_image
 where bill_cycle_code>='201507' and bill_cycle_code<='201512'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 50 
    --and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=75
      group by Tariff,'Slab1 1-75'
        union all
      select Tariff,'Slab2 76-200' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-201),-1,
      nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-75,125)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201507' and bill_cycle_code<='201512'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 75 
  --and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=200
  group by Tariff,'Slab2 76-200'
  union all  
select Tariff,'Slab3 201-300' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-301),-1,nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-200,100)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201507' and bill_cycle_code<='201512'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 200 
 -- and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=300
  group by Tariff,'Slab3 201-300'
    union all
select Tariff,'Slab4 301-400' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-401),-1,
nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-300,100)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201507' and bill_cycle_code<='201512'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 300 
 -- and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=400
  group by Tariff,'Slab4 301-400' 
  union all
select Tariff,'Slab5 401-600' Cons_type,sum(decode(sign(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-601),-1,
nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-400,200)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201507' and bill_cycle_code<='201512'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 400 
  --and nvl(CONS_KWH_SR,0)+nvl(OLD_KWH_SR_CONS,0)<=600
  group by Tariff,'Slab5 401-600'
  union all
  select Tariff,'Slab6 >600' Cons_type,sum(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)-600) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201507' and bill_cycle_code<='201512'
 and tariff='A'
 and invoice_num is not null
  and nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)+nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)+nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0) > 600
   group by Tariff,'Slab6 >600'
    union all  
  select Tariff,'PK' Cons_type,sum(nvl(CONS_KWH_PK,0)+nvl(OLD_KWH_PK_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201507' and bill_cycle_code<='201512'
 and tariff<>'A'
 and invoice_num is not null
   group by Tariff,'PK'
union all  
  select Tariff,'OFF PK' Cons_type,sum(nvl(CONS_KWH_ofPK,0)+nvl(OLD_KWH_ofPK_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201507' and bill_cycle_code<='201512'
 and tariff<>'A'
 and invoice_num is not null
   group by Tariff,'OFF PK'union all  
  select Tariff,'Flat' Cons_type,sum(nvl(CONS_KWH_sr,0)+nvl(OLD_KWH_sr_CONS,0)) Cons
 from ebc.bc_bill_image
 where bill_cycle_code>='201507' and bill_cycle_code<='201512'
 and tariff<>'A'
 and invoice_num is not null
   group by Tariff,'Flat'  
   order by 1,2