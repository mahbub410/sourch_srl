

=========NAO TO SRL==============

TRUNCATE TABLE BC_PRINT_BILL_CONTROL


INSERT INTO BC_PRINT_BILL_CONTROL
SELECT * FROM EMP.BC_PRINT_BILL_CONTROL@BILLING_NAO

COMMIT;


TRUNCATE TABLE BC_PRINT_BILL


INSERT INTO BC_PRINT_BILL
SELECT * FROM EMP.BC_PRINT_BILL@BILLING_NAO

COMMIT;


=========SRL TO PAB==============

INSERT INTO  EMP.BC_PRINT_BILL_CONTROL@BILLING_PAB
SELECT FILE_ID, FILE_NAME, PRINT_DATE, USAGE_TYPE, RUN_ID, NULL
 FROM BC_PRINT_BILL_CONTROL

COMMIT;

INSERT INTO  EMP.BC_PRINT_BILL@BILLING_PAB
SELECT * FROM BC_PRINT_BILL

COMMIT;




SELECT COUNT(*) FROM EMP.BC_PRINT_BILL_CONTROL@BILLING_PAB

SELECT COUNT(*) FROM EMP.BC_PRINT_BILL@BILLING_PAB
