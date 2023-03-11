

select * from ALL_SCHEDULER_running_JOBS@epay_ctg

select STATE,A.* from ALL_SCHEDULER_JOBS a--@epay_ctg A
where owner='EPAY'

select * from v$scheduler_running_jobs@epay_ctg

select
   log_date,
   job_name,
   status,
   run_duration
from
   dba_scheduler_job_run_details@epay_ctg
   where JOB_NAME='EPAY_BANK_PAYMENT_VALID'
   order by LOG_DATE desc
   
   execute DPG_EPAY_ONL_OPT_PYMT_VALID_RB.DPD_PAY_BILL_VALD_PASS_CONT;
   
   exec scheduler_jobs