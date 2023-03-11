--1-fms_tender_ministry_info

CREATE TABLE PMIS.PMIS_TENDER_MASTER 
(
tender_id NUMBER,
app_id NUMBER,
MINISTRY_ID       NUMBER,
DIVISION_ID  NUMBER,
ORG_ID  NUMBER,
ENTITY_ID  NUMBER,
pro_nature VARCHAR2(20),
pro_type VARCHAR2(10),
event_type VARCHAR2(10),
invit_for VARCHAR2(30),
invit_reference_no VARCHAR2(50),
pro_method VARCHAR2(50),
budget_type VARCHAR2(30),
source_of_funds VARCHAR2(50),
project_code VARCHAR2(20),
project_name VARCHAR2(200),
Package_ID NUMBER,
schedul_date date,
schedul_time date,
tender_publi_date date,
tender_publi_time VARCHAR2(10),
tender_doc_selling_date date,
tender_doc_selling_time VARCHAR2(10),
tender_meeting_start_date date,
tender_meeting_start_time VARCHAR2(10),
tender_meeting_end_date date,
tender_meeting_end_time VARCHAR2(10),
tender_opening_date date,
tender_opening_time VARCHAR2(10),
tender_closing_date date,
tender_closing_time VARCHAR2(10),
tender_last_date date,
tender_last_time VARCHAR2(10),
LOT_ID NUMBER,
inviting_name VARCHAR2(100),
inviting_desg VARCHAR2(100),
inviting_address VARCHAR2(300),
inviting_phone VARCHAR2(15),
inviting_emaile VARCHAR2(50),
STATUS   VARCHAR2(1) DEFAULT 'N',
CREATE_BY VARCHAR2(100 CHAR),
CREATE_DATE DATE,
UPDATE_BY VARCHAR2(100 CHAR),
UPDATE_DATE DATE
)




---2-fms_tender_particular_info
particular_info_id number,
ministry_ID NUMBER,
project_code VARCHAR2(20),
project_name VARCHAR2(200),
tender_package_No VARCHAR2(10),
tender_package_desc VARCHAR2(300),
category VARCHAR2(500),
schedul_date date,
schedul_time date,
tender_publi_date date,
tender_publi_time VARCHAR2(10),
tender_doc_selling_date date,
tender_doc_selling_time VARCHAR2(10),
tender_meeting_start_date date,
tender_meeting_start_time VARCHAR2(10),
tender_meeting_end_date date,
tender_meeting_end_time VARCHAR2(10),
tender_opening_date date,
tender_opening_time VARCHAR2(10),
tender_closing_date date,
tender_closing_time VARCHAR2(10),
tender_last_date date
tender_last_time VARCHAR2(10),


--3- fms_tender_consultant_info
consultant_id number,
ministry_ID NUMBER,
eligibility_of_tender VARCHAR2(100),
brief_desc_of_gd VARCHAR2(100),
related_service VARCHAR2(30),
evaluation_type VARCHAR2(50),
document_available VARCHAR2(50),
document_fees VARCHAR2(50),
tender_document_price number,
Payment_mode VARCHAR2(50),
tndr_security_valid_up_to date,
tender_valid_up_to date



--4-fms_tender_procuring_entity_details
entity_details_id number,
ministry_ID NUMBER,
office_inviting_name VARCHAR2(100),
office_inviting_desg VARCHAR2(100),
office_inviting_address VARCHAR2(300),
office_inviting_phone VARCHAR2(15),
office_inviting_emaile VARCHAR2(50),



CREATE TABLE PMIS.PMIS_DESIGINATION_INFO (
DESGI_ID NUMBER,
DESGI_NAME VARCHAR2(100),
STATUS  VARCHAR2(1) DEFAULT 'N',
CREATE_BY VARCHAR2(50),
CREATE_DATE DATE,
UPDATE_BY VARCHAR2(50),
UPDATE_DATE DATE
);




CREATE TABLE PMIS.PMIS_PERSONAL_INFO (
PERSON_ID NUMBER,
NAME VARCHAR2(100),
DESGI_ID NUMBER,
DATE_OF_BIRTH DATE,
AGE NUMBER,
PHONE_NO VARCHAR2(10),
EMAIL VARCHAR2(30),
ADDRESS VARCHAR2(200),
STATUS  VARCHAR2(1) DEFAULT 'N',
CREATE_BY VARCHAR2(50),
CREATE_DATE DATE,
UPDATE_BY VARCHAR2(50),
UPDATE_DATE DATE
);


CREATE TABLE PMIS.PMIS_EDUCATION_INFO (
edu_id NUMBER,
PERSON_ID NUMBER,
Education_Level VARCHAR2(100),
major_subject VARCHAR2(100),
Result VARCHAR2(50),
Board_Institute VARCHAR2(100),
Passing_year VARCHAR2(4),
Duration VARCHAR2(10),
STATUS  VARCHAR2(1) DEFAULT 'N',
CREATE_BY VARCHAR2(50),
CREATE_DATE DATE,
UPDATE_BY VARCHAR2(50),
UPDATE_DATE DATE
);


CREATE TABLE PMIS.PMIS_EXPERIANCE_INFO (
experiance_id NUMBER,
PERSON_ID NUMBER,
DESGI_ID NUMBER,
project_NAME  VARCHAR2(100),
job_responcibility VARCHAR2(200),
experiance  VARCHAR2(10),
total_experiance VARCHAR2(10),
company_name VARCHAR2(100),
STATUS  VARCHAR2(1) DEFAULT 'N',
CREATE_BY VARCHAR2(50),
CREATE_DATE DATE,
UPDATE_BY VARCHAR2(50),
UPDATE_DATE DATE
);

-------


CREATE TABLE PMIS.PMIS_MINISTRY_MASTER
(
  MINISTRY_ID       NUMBER,
  MINISTRY_CODE  VARCHAR2(50 CHAR),
  MINISTRY_NAME     VARCHAR2(100 CHAR),
  STATUS   VARCHAR2(1) DEFAULT 'N',
  CREATE_BY VARCHAR2(100 CHAR),
  CREATE_DATE DATE,
  UPDATE_BY VARCHAR2(100 CHAR),
  UPDATE_DATE DATE
)

CREATE TABLE PMIS.PMIS_MINISTRY_DIVITION_INFO
(
  MINISTRY_ID       NUMBER,
  DIVISION_ID  NUMBER,
  DIVISION_NAME     VARCHAR2(100 CHAR),
  STATUS   VARCHAR2(1) DEFAULT 'N',
  CREATE_BY VARCHAR2(100 CHAR),
  CREATE_DATE DATE,
  UPDATE_BY VARCHAR2(100 CHAR),
  UPDATE_DATE DATE
)

CREATE TABLE PMIS.PMIS_MINISTRY_ORG_INFO
(
  MINISTRY_ID       NUMBER,
  DIVISION_ID  NUMBER,
  ORG_ID  NUMBER,
  ORGN_NAME     VARCHAR2(100 CHAR),
  STATUS   VARCHAR2(1) DEFAULT 'N',
  CREATE_BY VARCHAR2(100 CHAR),
  CREATE_DATE DATE,
  UPDATE_BY VARCHAR2(100 CHAR),
  UPDATE_DATE DATE
)

CREATE TABLE PMIS.PMIS_MINISTRY_ENTITY_INFO
(
  MINISTRY_ID       NUMBER,
  DIVISION_ID  NUMBER,
  ORG_ID  NUMBER,
  ENTITY_ID  NUMBER,
  ENTITY_CODE  VARCHAR2(50 CHAR),
  ENTITY_NAME     VARCHAR2(100 CHAR),
  STATUS   VARCHAR2(1) DEFAULT 'N',
  CREATE_BY VARCHAR2(100 CHAR),
  CREATE_DATE DATE,
  UPDATE_BY VARCHAR2(100 CHAR),
  UPDATE_DATE DATE
)

CREATE TABLE PMIS.PMIS_TENDER_CATEGORY
(
  TENDER_ID       NUMBER,
  package_ID NUMBER,
  PACKAGE_NO  VARCHAR2(100 CHAR),
  package_desc     VARCHAR2(200 CHAR),
  package_CATEGORY     VARCHAR2(500 CHAR),
  STATUS   VARCHAR2(1) DEFAULT 'N',
  CREATE_BY VARCHAR2(100 CHAR),
  CREATE_DATE DATE,
  UPDATE_BY VARCHAR2(100 CHAR),
  UPDATE_DATE DATE
)

CREATE TABLE PMIS.PMIS_TENDER_LOT
(
  TENDER_ID       NUMBER,
  LOT_ID NUMBER,
  LOT_NO  VARCHAR2(100 CHAR),
  LOT_desc     VARCHAR2(500 CHAR),
  LOCATION VARCHAR2(200 CHAR),
  SECURITY_AMOUNT VARCHAR2(100 CHAR),
  START_DATE DATE,
  COMPLETION_DATE DATE,
  STATUS   VARCHAR2(1) DEFAULT 'N',
  CREATE_BY VARCHAR2(100 CHAR),
  CREATE_DATE DATE,
  UPDATE_BY VARCHAR2(100 CHAR),
  UPDATE_DATE DATE
)
