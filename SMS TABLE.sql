
CREATE TABLE SMS_COMPANY(
COMPANY_ID NUMBER,
COMPANY_CODE VARCHAR2(3),
COMPANY_NAME VARCHAR2(20),
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)

CREATE TABLE SMS_SUPPLAYER_MST(
SUPP_ID NUMBER,
SUPP_CODE VARCHAR2(3),
SUPP_NAME VARCHAR2(20),
SUPP_PHONE_NO VARCHAR2(15),
SUPP_ADDRESS VARCHAR2(50),
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)

CREATE TABLE SMS_CUSTOMERS(
CUST_ID NUMBER,
CUST_CODE VARCHAR2(3),
CUST_NAME VARCHAR2(20),
CUST_PHONE_NO VARCHAR2(15),
CUST_ADDRESS VARCHAR2(50),
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)

CREATE TABLE SMS_MASERMENT_UNIT(
MASRMNT_UNIT_ID NUMBER,
MASRMNT_UNIT_CODE VARCHAR2(3),
MASRMNT_UNIT_DESC VARCHAR2(20),
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)

CREATE TABLE SMS_ITEM_MST(
ITEM_ID NUMBER,
ITEM_CODE VARCHAR2(10),
ITEM_DESC VARCHAR2(20),
COMPANY_CODE VARCHAR2(3),
MASRMNT_UNIT_CODE VARCHAR2(3),
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)


CREATE TABLE SMS_PO_MST(
PO_ID NUMBER,
PO_CODE VARCHAR2(3),
PO_DATE DATE,
COMPANY_CODE VARCHAR2(3),
SUPP_CODE VARCHAR2(3),
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)

CREATE TABLE SMS_PO_DTL(
PO_DTL_ID NUMBER,
PO_ID NUMBER,
PO_CODE VARCHAR2(3),
ITEM_CODE VARCHAR2(10),
PO_RATE NUMBER,
QUENTITY NUMBER,
AMOUNT NUMBER,
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)

CREATE TABLE SMS_SALE_MST(
SALE_ID NUMBER,
SALE_CODE VARCHAR2(3),
SALE_DATE DATE,
COMPANY_CODE VARCHAR2(3),
CUST_CODE VARCHAR2(3),
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)

CREATE TABLE SMS_SALE_DTL(
SALE_DTL_ID NUMBER,
SALE_ID NUMBER,
SALE_CODE VARCHAR2(3),
ITEM_CODE VARCHAR2(10),
SALE_RATE NUMBER,
QUENTITY NUMBER,
AMOUNT NUMBER,
DUE_AMOUNT NUMBER,
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)

CREATE TABLE SMS_ITEM_LEDGER(
LEDGER_ID NUMBER,
TRANS_NO VARCHAR2(3),
TRANS_DATE DATE,
ITEM_CODE VARCHAR2(10),
PO_CODE VARCHAR2(3),
SALE_CODE VARCHAR2(3),
SUPP_CODE VARCHAR2(3),
CUST_CODE VARCHAR2(3),
PO_RATE NUMBER,
SALE_RATE NUMBER,
DB_QNTY NUMBER,
CR_QNTY NUMBER,
DB_AMOUNT NUMBER,
CR_AMOUNT NUMBER,
DUE_AMOUNT NUMBER,
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)

---

CREATE TABLE SMS_PO_SALE_INFO(
PS_ID NUMBER,
PS_DATE DATE,
OPEN_AMOUNT NUMBER,
CLOSE_AMOUNT NUMBER,
PO_AMOUNT NUMBER,
SALE_AMOUNT NUMBER,
DUE_AMOUNT NUMBER,
STATUS VARCHAR2(1) DEFAULT 'A',
CREATE_BY VARCHAR2(30),
CREATE_DATE DATE,
UPATE_BY VARCHAR2(30),
UPATE_DATE DATE
)