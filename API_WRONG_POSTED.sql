


select * from epay_payment_mst@EPAY_SRL_DCC
where batch_no='MBP82766'
and status<>'T'

insert into EPAY_PAYMENT_MST_BNK_BKP@EPAY_SRL_DCC
select * from epay_payment_mst@EPAY_SRL_DCC
where REF_BATCH_NO='MBP82766'

insert into EPAY_PAYMENT_dtl_BNK_BKP@EPAY_SRL_DCC
select * from epay_payment_dtl@EPAY_SRL_DCC
where REF_BATCH_NO='MBP82766'

commit;


delete from epay_payment_dtl@EPAY_SRL_DCC
where REF_BATCH_NO='MBP82766'


delete from epay_payment_mst@EPAY_SRL_DCC
where REF_BATCH_NO='MBP82766'




delete from epay_payment_dtl
where BATCH_NO='MBP82766'


delete from epay_payment_mst
where BATCH_NO='MBP82766'

commit;


select * from VW_MBP_API_BATCH_NOT_GET 
where loc_code='K3'

select * FROM MBP_PAYMENT_DTL_OVC_hist@MBP_23 
where pay_date='23-JUN-2020'
and org_br_code='K3'
and PAY_PC_CODE='77'
and PAY_PC_BR_CODE='008'

and --bill_number='2369746529'
account_number='26189661'


insert into MBP_PAYMENT_DTL_OVC_BKP@MBP_23
select * FROM MBP_PAYMENT_DTL_OVC_hist@MBP_23 
where pay_date='23-JUN-2020'
and org_br_code='K3'
and PAY_PC_CODE='77'
and PAY_PC_BR_CODE='008'

commit;


update MBP_PAYMENT_DTL_OVC_hist@MBP_23 
set STATUS='N'
where pay_date='23-JUN-2020'
and org_br_code='S1'
and PAY_PC_CODE='06'
and PAY_PC_BR_CODE='055'
and status='P'

and --bill_number='2369746529'
account_number='26189661'

commit;




insert into MBP_PAYMENT_DTL_OVC@MBP_23
select * FROM MBP_PAYMENT_DTL_OVC_hist@MBP_23 
where pay_date='23-JUN-2020'
and org_br_code='S1'
and PAY_PC_CODE='06'
and PAY_PC_BR_CODE='055'


commit;

delete FROM MBP_PAYMENT_DTL_OVC_hist@MBP_23 
where pay_date='23-JUN-2020'
and org_br_code='S1'
and PAY_PC_CODE='06'
and PAY_PC_BR_CODE='055'

commit;


select *  from MBP_RECON_LOG@MBP_23
where pay_date='23-JUN-2020'
and PAY_COLL_CODE='06'
and PAY_COLL_BR_CODE='055'


delete  from MBP_RECON_LOG@MBP_23
where pay_date='23-JUN-2020'
and PAY_COLL_CODE='06'
and PAY_COLL_BR_CODE='055'

commit;