
select * from DBA_2PC_PENDING 
where state='prepared'


COMMIT FORCE '13.32.4491936';


select * from DBA_2PC_NEIGHBORS 
where local_tran_id='13.32.4491936';




--rollback force '606.36.301120';

--49.32.50715