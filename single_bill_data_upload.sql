
select EPAY.DFN_SING_DATA_UPL (:P_LOCATION_CODE ,:P_BILL_NUM ) from dual

select * from epay_utility_Bill--@epayment
where bill_number='451985090'
and location_code='H7'