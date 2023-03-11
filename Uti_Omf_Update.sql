
select * from bc_customer_meter
where meter_num like '%50149071%'


---energy

update bc_customer_meter
set OVERALL_MF_KWH=''
where meter_num ='50149071E'
and meter_status=2


update bc_equip_mast
set SCALE_FACTOR_KWH=''
where EQUIP_ID in (
select EQUIP_ID from bc_customer_meter
where meter_num ='50149071E'
and meter_status=2
)

---var

update bc_customer_meter
set OVERALL_MF_KVARH=''
where meter_num ='50149071E'
and meter_status=2


update bc_equip_mast
set SCALE_FACTOR_KVARH=''
where EQUIP_ID in (
select EQUIP_ID from bc_customer_meter
where meter_num ='50149071E'
and meter_status=2
)

commit;