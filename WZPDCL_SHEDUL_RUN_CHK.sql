

   SELECT OWNER, JOB_NAME, ELAPSED_TIME
     FROM SYS.DBA_SCHEDULER_RUNNING_JOBS
    WHERE OWNER = 'EPAY'
    
    