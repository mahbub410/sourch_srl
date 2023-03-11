
create table TB_EMPLOYEE (
EMPLOYEE_ID NUMBER,
OFFICE_ID NUMBER,
EMPLOYEE_CODE varchar2(5),
EMPLOYEE_NAME varchar2(100),
FATHER_NAME varchar2(100),
MOTHER_NAME varchar2(100),
VILLAGE varchar2(100),
POST_OFFICE varchar2(100),
SUB_DISTRICT varchar2(50),
DISTRICT varchar2(50),
DESIGNATION varchar2(80),
BIRTH_DATE date,
JOIN_DATE date,
BASIC_SALARY varchar2(100),
STATUS        VARCHAR2(1 BYTE)            DEFAULT 'C',
CREATE_BY         VARCHAR2(20 BYTE),
CREATE_DATE       DATE,
UPDATE_BY         VARCHAR2(20 BYTE),
UPDATE_DATE       DATE
);

create table TB_GROUP_INSURANCE_PUBLICATION (
PUBLICATION_ID number,
PUBLICATION_YEAR VARCHAR2(10),
PUBLICATION_NO VARCHAR2(30),
PUBLICATION_DATE  date,
SUBMISSION_DATE date,
STATUS        VARCHAR2(1 BYTE)            DEFAULT 'C',
CREATE_BY         VARCHAR2(20 BYTE),
CREATE_DATE       DATE,
UPDATE_BY         VARCHAR2(20 BYTE),
UPDATE_DATE       DATE
);


create table TB_GROUP_INSURANCE_SUBMISSION (
SUBMISSION_ID number,
PUBLICATION_ID number,
SUBMISSION_NO VARCHAR2(30),
SUBMISSION_DATE date,
STATUS        VARCHAR2(1 BYTE)            DEFAULT 'C',
CREATE_BY         VARCHAR2(20 BYTE),
CREATE_DATE       DATE,
UPDATE_BY         VARCHAR2(20 BYTE),
UPDATE_DATE       DATE
);


create table TB_GROUP_INSURANCE_SUBMISSION_DETAIL (
SUBMISSION_DETAIL_ID number,
SUBMISSION_ID number,
OFFICE_ID number,
EMPLOYEE_ID number,
REMARKS varchar2(500),
STATUS        VARCHAR2(1 BYTE)            DEFAULT 'C',
CREATE_BY         VARCHAR2(20 BYTE),
CREATE_DATE       DATE,
UPDATE_BY         VARCHAR2(20 BYTE),
UPDATE_DATE       DATE
);


create table TB_NOMINEE (
NOMINEE_MST_ID NUMBER,
REFERENCE_NO VARCHAR2(30),
REFERENCE_DATE DATE,
OFFICE_ID NUMBER,
EMPLOYEE_ID NUMBER,
STATUS        VARCHAR2(1 BYTE)            DEFAULT 'C',
CREATE_BY         VARCHAR2(20 BYTE),
CREATE_DATE       DATE,
UPDATE_BY         VARCHAR2(20 BYTE),
UPDATE_DATE       DATE
);


create table TB_NOMINEE_DETAIL (
NOMINEE_DTL_ID NUMBER,
NOMINEE_NAME VARCHAR2(100),
VILLAGE varchar2(100),
POST_OFFICE varchar2(100),
SUB_DISTRICT varchar2(50),
DISTRICT varchar2(50),
RELATION varchar2(50),
SIGNATURE BLOB,
NOMINATED_PERCENT varchar2(50),
STATUS        VARCHAR2(1 BYTE)            DEFAULT 'C',
CREATE_BY         VARCHAR2(20 BYTE),
CREATE_DATE       DATE,
UPDATE_BY         VARCHAR2(20 BYTE),
UPDATE_DATE       DATE
);



CREATE TABLE TB_NOMINEE_WITNESS (
NOMINEE_WITNESS_ID NUMBER,
EMPLOYEE_ID  NUMBER,
WITNESS_NAME varchar2(100),
VILLAGE varchar2(100),
POST_OFFICE varchar2(100),
SUB_DISTRICT varchar2(50),
DISTRICT varchar2(50),
SIGNATURE BLOB,
WITNESS_DATE DATE,
STATUS        VARCHAR2(1 BYTE)            DEFAULT 'C',
CREATE_BY         VARCHAR2(20 BYTE),
CREATE_DATE       DATE,
UPDATE_BY         VARCHAR2(20 BYTE),
UPDATE_DATE       DATE
)