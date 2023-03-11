DBA_2PC_PENDING and DBA_2PC_NEIGHBORS

select * from DBA_2PC_NEIGHBORS
where DBUSER_OWNER='BILLPAY'

select * from DBA_2PC_PENDING


Query the DBA_2PC_PENDING and DBA_2PC_NEIGHBORS views to determine whether the databases involved in the transaction have committed.

If necessary, force a commit using the COMMIT FORCE statement or a rollback using the ROLLBACK FORCE statement.


---------------------------------------------------------

Manually Committing an In-Doubt Transaction
Before attempting to commit the transaction, ensure that you have the proper privileges. Note the following requirements:

User Committing the Transaction    Privilege Required
You    FORCE TRANSACTION
Another user    FORCE ANY TRANSACTION
Committing Using Only the Transaction ID
The following SQL statement commits an in-doubt transaction:

select * from DBA_2PC_PENDING

where db_user='EPAY'

COMMIT FORCE 'transaction_id';

The variable transaction_id is the identifier of the transaction as specified in either the LOCAL_TRAN_ID or GLOBAL_TRAN_ID columns of the DBA_2PC_PENDING data dictionary view.

For example, assume that you query DBA_2PC_PENDING and determine that LOCAL_TRAN_ID for a distributed transaction is 1:45.13.

You then issue the following SQL statement to force the commit of this in-doubt transaction:

COMMIT FORCE '1.45.13';
Committing Using an SCN
Optionally, you can specify the SCN for the transaction when forcing a transaction to commit. This feature lets you commit an in-doubt transaction with the SCN assigned when it was committed at other nodes.

Consequently, you maintain the synchronized commit time of the distributed transaction even if there is a failure. Specify an SCN only when you can determine the SCN of the same transaction already committed at another node.

For example, assume you want to manually commit a transaction with the following global transaction ID:

SALES.ACME.COM.55d1c563.1.93.29 
First, query the DBA_2PC_PENDING view of a remote database also involved with the transaction in question. Note the SCN used for the commit of the transaction at that node. Specify the SCN when committing the transaction at the local node. For example, if the SCN is 829381993, issue:

COMMIT FORCE 'SALES.ACME.COM.55d1c563.1.93.29', 829381993;
See Also:
Oracle Database SQL Language Reference for more information about using the COMMIT statement
Manually Rolling Back an In-Doubt Transaction
Before attempting to roll back the in-doubt distributed transaction, ensure that you have the proper privileges. Note the following requirements:

User Committing the Transaction    Privilege Required
You    FORCE TRANSACTION
Another user    FORCE ANY TRANSACTION
The following SQL statement rolls back an in-doubt transaction:

ROLLBACK FORCE 'transaction_id';
The variable transaction_id is the identifier of the transaction as specified in either the LOCAL_TRAN_ID or GLOBAL_TRAN_ID columns of the DBA_2PC_PENDING data dictionary view.

For example, to roll back the in-doubt transaction with the local transaction ID of 2.9.4, use the following statement:

ROLLBACK FORCE '2.9.4';


select * from DBA_2PC_NEIGHBORS A,DBA_2PC_PENDING B
where A.LOCAL_TRAN_ID=B.LOCAL_TRAN_ID
AND A.DBUSER_OWNER='BILLPAY'

select * from DBA_2PC_PENDING
