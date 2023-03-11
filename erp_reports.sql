--------Personal Information Report----
--1
SELECT HRM_PERSONAL_INFO.EmP_ID,HRM_PERSONAL_INFO.EMP_NO, initcap(HRM_PERSONAL_INFO.FRST_NAME||' '|| initcap(HRM_PERSONAL_INFO.MIDL_NAME)||' '||
initcap(HRM_PERSONAL_INFO.LST_NAME)) name, initcap(HRM_PERSONAL_INFO.FH_NAME) FH_NAME , initcap(HRM_PERSONAL_INFO.MH_NAME) MH_NAME, 
initcap(HRM_PERSONAL_INFO.HB_NAME) HB_NAME, to_char(HRM_PERSONAL_INFO.BIRTH_DT,'dd/mm/rrrr') BIRTH_DT, HRM_PERSONAL_INFO.PLACE_OF_BIRTH, 
HRM_PERSONAL_INFO.NATIONALITY, HRM_PERSONAL_INFO.NIC_NO, HRM_PERSONAL_INFO.BLOOD_GROUP ,
HRM_PERSONAL_INFO.PASSPT_NO, HRM_PERSONAL_INFO.DRIVING_LIC_NO,
initcap(decode(HRM_PERSONAL_INFO.FREEDOM_FIGHTER,'Y','Yes','N','No')) FREEDOM_FIGHTER, HRM_PERSONAL_INFO.CERTIFICATE_NO, HRM_PERSONAL_INFO.TIN_NO, 
initcap(decode(HRM_PERSONAL_INFO.GENDER,'M','Male','F','Female')) GENDER, initcap(decode(HRM_PERSONAL_INFO.MARITAL_STA,'M','Married','U','Unmarried')) MARITAL_STA , Upper(HRM_PERSONAL_INFO.SPOUSE_NAME) SPOUSE_NAME, 
initcap(HRM_PERSONAL_INFO.NO_OF_CHILD) NO_OF_CHILD,HRM_PERSONAL_INFO.PHOTO_FILE_PATH, 
HRM_PERSONAL_INFO.PHOTO_SIG_PATH, initcap(HRM_PERSONAL_INFO.CONCT_PERS_NAME) CONCT_PERS_NAME, 
HRM_PERSONAL_INFO.CONCT_PERS_PHONE,initcap( HRM_PERSONAL_INFO.CONCT_PER_ADDR) CONCT_PER_ADDR, 
lower(HRM_PERSONAL_INFO.E_MAIL1) E_MAIL1 , HRM_PERSONAL_INFO.E_MAIL2, HRM_PERSONAL_INFO.MOBI_NO_PERS, 
HRM_PERSONAL_INFO.MAIL_PH_NO, HRM_PERSONAL_INFO.RESD_PHO_NO, HRM_PERSONAL_INFO.CREATE_DATE, HRM_PERSONAL_INFO.CREATE_BY, HRM_PERSONAL_INFO.UPDATE_DATE, HRM_PERSONAL_INFO.UPDATE_BY, decode(HRM_PERSONAL_INFO.JOB_STATUS,'A','Active') JOB_STATUS, 
HRM_PERSONAL_INFO.PHOTO, HRM_PERSONAL_INFO.SIGNATURE, HRM_PERSONAL_INFO.OLD_EMP_ID, 
HRM_PERSONAL_INFO.NO_OF_DAUGHTER, HRM_PERSONAL_INFO.NO_OF_SON,initcap( RCT_RELIGION_MST.RELIGION_DESC) RELIGION_DESC
FROM HRM_PERSONAL_INFO, RCT_RELIGION_MST,HRM_PERSONAL_OFFIC_INFO
WHERE   (HRM_PERSONAL_INFO.RELIGION_CODE = RCT_RELIGION_MST.RELIGION_CODE)
and HRM_PERSONAL_OFFIC_INFO.emp_id=HRM_PERSONAL_INFO.EMP_ID
and HRM_PERSONAL_INFO.EMP_ID like  decode( :P_EMP_ID,'ALL','%','','%',:P_EMP_ID)
order by HRM_PERSONAL_INFO.EMP_No

----2

SELECT   HPOI.EMP_ID,initcap(Decode(HPOI.EMP_TYPE,'P','Permanent','R','Probation','T','Temporary','N','NWNP')) Emp_type, 
HPOI.JOIN_OFFER_NO, to_char(HPOI.JOIN_DATE,'dd/mm/rrrr') JOIN_DATE, 
HPOI.PROB_PERIOD, to_char(HPOI.PROB_START_DT,'dd/mm/rrrr') PROB_START_DT, 
to_char(HPOI.PROB_END_DT,'dd/mm/rrrr') PROB_END_DT, to_char(HPOI.CONFIRM_DATE,'dd/mm/rrrr') CONFIRM_DATE, 
HPOI.SENR_SL_NO, HPOI.PAY_GRD_CODE, 
to_char(HPOI.BASIC_PAY, HPOI.CONT_STRT_DAT,'dd/mm/rrrr') CONT_STRT_DAT, 
to_char(HPOI.CONT_END_DAT,'dd/mm/rrrr') CONT_END_DAT,initcap(decode( HPOI.ACCOM_STATUS,'O','Office Residence','S','Self','D','Dormintory')) accom_status, 
HPOI.DISP_CODE, to_char(HPOI.PRST_POST_DT,'dd/mm/rrrr') PRST_POST_DT, 
to_char(HPOI.LAST_INCR_DT,'dd/mm/rrrr') LAST_INCR_DT, to_char(HPOI.NEXT_INC_DATE,'dd/mm/rrrr') NEXT_INC_DATE, 
to_char(HPOI.LAST_PROM_DATE,'dd/mm/rrrr') LAST_PROM_DATE, initcap(decode(HPOI.JOINING_TYPE,'D','Direct','A','Absorbed','L','Lien')) Joining_type, 
initcap(decode(HPOI.EMP_STATUS,'A','Active')) EMP_STATUS, initcap(decode(HPOI.EMP_DUTY_TYPE,'G','General','S','Shift')) EMP_DUTY_TYPE, 
initcap(decode(HPOI.EMP_CAT,'O','Officer','S','Staff')) Emp_cat, initcap(HPOI.FUND_TYPE) FUND_TYPE, 
HPOI.OFF_PHONE, HPOI.OFF_MOB_NO,
initcap(HOI.OFFICE_NAME) OFFICE_NAME,initcap(RDS.DESIG_NAME) DESIG_NAME
FROM HRM_PERSONAL_INFO HPI, HRM_PERSONAL_OFFIC_INFO HPOI,HRM_OFFICE_INFO HOI,RCT_DESIG_MST RDS
WHERE ((HPOI.EMP_ID = HPI.EMP_ID)
and (HPOI.PRST_OFF_CODE=HOI.office_code)
and (HPOI.PRST_DESIG_CODE=RDS.desig_code))
and HPI.EMP_ID like  decode( :P_EMP_ID,'ALL','%','','%',:P_EMP_ID)

---3

select "EDU_DTL_ID", 
"EMP_ID",
"EDU_LV_CODE",(select EDU_LV_DESC from RCT_EDU_LV_MST A
where A.Edu_lv_code=HRM_EDUCATION_DTL.Edu_lv_code) Edu_Level,
"EXAM_CODE",(select EXAM_DESC  from RCT_EXAM_MST B
where B.exam_code=HRM_EDUCATION_DTL.exam_code) EXAM_DESC,
"MJR_GR_CODE",(select MJR_GR_DESC  from RCT_MJR_GR_MST C
where C.MJR_GR_CODE=HRM_EDUCATION_DTL.MJR_GR_CODE) MJR_GR_DESC,
"INST_CODE",(select INST_DESC   from RCT_INST_MST D
where D.INST_CODE=HRM_EDUCATION_DTL.INST_CODE) INST_DESC,
"COUNTRY_CODE",
"RESULT_CODE",
"PASSING_YEAR" PASSING_YEAR ,
"BOARD",
decode("MEDIUM",'B','Bangla','E','English') Medium,
"DURATION",
"ACHIEVEMENT",
"CREATE_BY",
"CREATE_DATE",
"UPDATE_BY",
"UPDATE_DATE",
"STATUS",
"CGPA_MARKS",
"RESULT_DTL_ID",
case when RESULT_DTL_ID is not null then
( select RESULT_DESCR from rct_result_dtl where result_dtl_id=HRM_EDUCATION_DTL.RESULT_DTL_ID)
else
RESULT_DESCR
end 
as RESULT_DESCR
from "HRM_EDUCATION_DTL" 
where  EMP_ID like  decode( :P_EMP_ID,'ALL','%','','%',:P_EMP_ID)
order by PASSING_YEAR desc

---------Office Organogram Report----

select HRM_OFFICE_INFO.OFFICE_CODE,HRM_OFFICE_INFO.OFFICE_NAME,RCT_DESIG_MST.DESIG_CODE,RCT_DESIG_MST.DESIG_NAME,HRM_OFFICE_ORGANOGRAM.REMARKS,
HRM_OFFICE_ORGANOGRAM.APPROVED_POST,HRM_OFFICE_ORGANOGRAM.OCCUPIED_POST,HRM_OFFICE_ORGANOGRAM.NO_OF_VACANT_POST,HRM_OFFICE_ORGANOGRAM.OCCUPIED_PER
,HRM_OFFICE_ORGANOGRAM.OCCUPIED_TEM,HRM_OFFICE_ORGANOGRAM.ORGNRM_APPRVD_DT,RCT_DESIG_MST.Grade_Code
from hrm_office_INFO,HRM_OFFICE_ORGANOGRAM,RCT_DESIG_MST
WHERE HRM_OFFICE_ORGANOGRAM.OFFICE_CODE=HRM_OFFICE_INFO.OFFICE_CODE
AND RCT_DESIG_MST.DESIG_CODE=HRM_OFFICE_ORGANOGRAM.DESIG_CODE
AND HRM_OFFICE_INFO.OFFICE_CODE LIKE decode( :P_OFFICE,'ALL','%','','%',:P_OFFICE)
order by Office_Code,Grade_Code

-------------Designation Information Report-----------

select distinct 'Grade-'||RCT_DESIG_MST.GRADE_CODE GRADE_CODE,RCT_DESIG_MST.DESIG_name,RCT_DESIG_MST.DESIG_CODE,NULL AS REMARKS
from RCT_DESIG_MST
where RCT_DESIG_MST.GRADE_CODE is not null
and RCT_DESIG_MST.GRADE_CODE like nvl(:P_GRADE_CODE,'%')
order by TO_NUMBER(RCT_DESIG_MST.GRADE_CODE) asc;

------------Information of Employees Report---------

select HRM_PERSONAL_INFO.emp_id,HRM_PERSONAL_INFO.EMP_NO,
HRM_PERSONAL_INFO.FRST_NAME||' '||HRM_PERSONAL_INFO.MIDL_NAME||' '||HRM_PERSONAL_INFO.LST_NAME||','||chr(10)||
RCT_DESIG_MST.DESIG_NAME||','||chr(10)||PMIS_GRADE_CODE.GRADE_NAME Employee_Desig,
HRM_OFFICE_INFO.OFFICE_NAME,
decode(HRM_PERSONAL_OFFIC_INFO.EMP_CAT,'O','Officer','S','Staff') EMP_CAT,HRM_PERSONAL_OFFIC_INFO.SENIORITY_SL_NO,
(select max(allw_bon_amt) from PAYROLL_EMP_MON_SALARY where sys_id_payroll_sal =(
select max(SYS_ID_PAYROLL_SAL)
from   PAYROLL_EMP_MON_SALARY where SYS_ID_PAYROLL_SAL in (
select SYS_ID_PAYROLL_SAL from  PAYROLL_EMP_MON_SALARY_mst 
where emp_no=--(select a.emp_id from hrm_personal_info a  where a.emp_id =
HRM_PERSONAL_INFO.EMP_ID--)
and ALLW_CODE='01')
and ALLW_CODE='01')) START_BASIC,
HRM_PERSONAL_OFFIC_INFO.JOIN_DATE,
HRM_PERSONAL_OFFIC_INFO.CONFIRM_DATE,
HRM_PERSONAL_INFO.TIN_NO,
HRM_PERSONAL_BANK_INFO.BANK_AC_NO1,
decode(HRM_PERSONAL_INFO.GENDER,'M','Male','F','Female') GENDER,
initcap(HRM_SPOUSE_INFO.SPOUSE_NAME) SPOUSE_NAME,
HRM_PERSONAL_INFO.FH_NAME||','||chr(10)||
HRM_PERSONAL_INFO.MH_NAME F_M_NAME,
HRM_PERSONAL_INFO.BIRTH_DT,
HRM_PERSONAL_INFO.NIC_NO,
HRM_PERSONAL_INFO.MOBI_NO_PERS||','||chr(10)||
HRM_PERSONAL_INFO.E_MAIL1 MOBI_Email,
HRM_OFFICE_INFO.OFFICE_CODE
from  HRM_PERSONAL_INFO,RCT_DESIG_MST,HRM_PERSONAL_OFFIC_INFO,HRM_OFFICE_INFO
,HRM_PERSONAL_BANK_INFO,PMIS_GRADE_CODE,HRM_SPOUSE_INFO
where HRM_PERSONAL_INFO.EMP_ID=HRM_PERSONAL_OFFIC_INFO.EMP_ID
and HRM_PERSONAL_OFFIC_INFO.PRST_DESIG_CODE=RCT_DESIG_MST.DESIG_CODE
and HRM_PERSONAL_OFFIC_INFO.PRST_OFF_CODE=HRM_OFFICE_INFO.OFFICE_CODE
and HRM_PERSONAL_BANK_INFO.EMP_ID=HRM_PERSONAL_INFO.EMP_ID
and PMIS_GRADE_CODE.GRADE_CODE=RCT_DESIG_MST.GRADE_CODE
and HRM_SPOUSE_INFO.EMP_ID(+)=HRM_PERSONAL_INFO.EMP_ID
--and s.emp_no=HRM_PERSONAL_INFO.EMP_ID
and HRM_PERSONAL_INFO.JOB_STATUS not in( '03','06','08')
and HRM_PERSONAL_INFO.EMP_NO is not null
AND HRM_OFFICE_INFO.OFFICE_CODE=NVL(:P_OFFICE_NAME,HRM_OFFICE_INFO.OFFICE_CODE)
AND HRM_PERSONAL_OFFIC_INFO.PRST_DESIG_CODE=NVL(:P_DESIGNATION,HRM_PERSONAL_OFFIC_INFO.PRST_DESIG_CODE)
order by HRM_PERSONAL_OFFIC_INFO.PAY_GRD_CODE ,HRM_PERSONAL_OFFIC_INFO.SENIORITY_SL_NO asc;

------Subject Wise Employee Report-----

SELECT distinct(HRM_PERSONAL_INFO.EMP_NO) EMP_ID,HRM_PERSONAL_INFO.EMP_NO||'-'||HRM_PERSONAL_INFO.FRST_NAME||' '||HRM_PERSONAL_INFO.MIDL_NAME||' '||HRM_PERSONAL_INFO.LST_NAME NAME,
RCT_DESIG_MST.DESIG_NAME,HRM_OFFICE_INFO.OFFICE_NAME,HRM_PERSONAL_OFFIC_INFO.PAY_GRD_CODE,HRM_PERSONAL_OFFIC_INFO.JOIN_DATE,
HRM_PERSONAL_OFFIC_INFO.LAST_INCR_DT,RCT_MJR_GR_MST.MJR_GR_DESC
FROM HRM_PERSONAL_INFO,HRM_EDUCATION_DTL,RCT_MJR_GR_MST,RCT_DESIG_MST,HRM_PERSONAL_OFFIC_INFO,HRM_OFFICE_INFO
WHERE HRM_EDUCATION_DTL.EMP_ID=HRM_PERSONAL_INFO.EMP_ID
AND RCT_MJR_GR_MST.MJR_GR_CODE=HRM_EDUCATION_DTL.MJR_GR_CODE
and HRM_OFFICE_INFO.OFFICE_CODE=NVL(:P_OFFICE_NAME,HRM_OFFICE_INFO.OFFICE_CODE)
AND RCT_DESIG_MST.DESIG_CODE=NVL(:P_DESIGNATION,RCT_DESIG_MST.DESIG_CODE)
AND RCT_MJR_GR_MST.MJR_GR_CODE like nvl(:P_SUBJECT,'%')
AND HRM_PERSONAL_OFFIC_INFO.EMP_ID=HRM_PERSONAL_INFO.EMP_ID
AND HRM_PERSONAL_OFFIC_INFO.PRST_DESIG_CODE=RCT_DESIG_MST.DESIG_CODE
AND HRM_OFFICE_INFO.OFFICE_CODE=HRM_PERSONAL_OFFIC_INFO.PRST_OFF_CODE
order by to_number(HRM_PERSONAL_OFFIC_INFO.PAY_GRD_CODE ),HRM_PERSONAL_OFFIC_INFO.JOIN_DATE asc,HRM_PERSONAL_OFFIC_INFO.LAST_INCR_DT


-------Blood Group Report--------

select (HRM_PERSONAL_INFO.FRST_NAME||' '||HRM_PERSONAL_INFO.MIDL_NAME||' '||HRM_PERSONAL_INFO.LST_NAME) name,HRM_PERSONAL_INFO.EMP_ID,HRM_PERSONAL_INFO.EMP_NO,
RCT_DESIG_MST.DESIG_NAME,RCT_DESIG_MST.GRADE_CODE,
(select GRADE_NAME FROM PMIS_GRADE_CODE B
WHERE B.GRADE_CODE=RCT_DESIG_MST.GRADE_CODE) AS GRADE_NAME,
RCT_DISTRICT_MST.DIST_DESCR,HRM_OFFICE_INFO.OFFICE_NAME,HRM_OFFICE_INFO.OFFICE_CODE,
RCT_BLOOD_GROUP_MST.BL_GR_DESC,HRM_PERSONAL_INFO.MAIL_PH_NO
from HRM_PERSONAL_INFO,RCT_DESIG_MST,HRM_PERSONAL_OFFIC_INFO,HRM_PERSONAL_ADDRESS_INFO,
RCT_DISTRICT_MST,HRM_OFFICE_INFO,RCT_BLOOD_GROUP_MST
where RCT_DESIG_MST.DESIG_CODE=HRM_PERSONAL_OFFIC_INFO.PRST_DESIG_CODE
and HRM_PERSONAL_OFFIC_INFO.EMP_ID=HRM_PERSONAL_INFO.EMP_ID
and HRM_PERSONAL_ADDRESS_INFO.PER_DIST_CODE=RCT_DISTRICT_MST.DIST_CODE
and HRM_PERSONAL_ADDRESS_INFO.EMP_ID=HRM_PERSONAL_INFO.EMP_ID
and HRM_OFFICE_INFO.OFFICE_CODE=HRM_PERSONAL_OFFIC_INFO.PRST_OFF_CODE
and RCT_BLOOD_GROUP_MST.BL_GR_CODE=HRM_PERSONAL_INFO.BLOOD_GROUP
--and HRM_OFFICE_TYPE.OFFICE_TYPE_CODE=HRM_OFFICE_INFO.OFFICE_TYPE_CODE
--and HRM_OFFICE_TYPE.OFFICE_TYPE_CODE like nvl(:division,'%')
--and HRM_OFFICE_INFO.OFFICE_CODE like nvl(:P96_OFFICE,'%')
AND RCT_BLOOD_GROUP_MST.BL_GR_CODE LIKE nvl(:P_BLOOD_GROUP,'%')
--AND RCT_BLOOD_GROUP_MST.BL_GR_CODE LIKE decode( :P96_BLOOD_GROUP,'ALL','%','','%',:P96_BLOOD_GROUP)
--and RCT_DESIG_MST.GRADE_CODE like nvl(:P_GRADE,'%')
ORDER BY RCT_DESIG_MST.GRADE_CODE asc;

----Local Training Information Report----

Select to_number(HT.TRAINEE_ID),HT.TRAINEE_EMP_ID,(hpi.emp_no||'-'||hpi.frst_name||' '||hpi.midl_name||' '||hpi.lst_name) "Employee Name",rdm.DESIG_NAME,hoi.OFFICE_NAME,
HT.TRAINING_TITLE,HT.TRAINING_INSTITUTE,
HT.TRAINING_DURATION,HT.TRAINING_COUNTRY,HT.TRAINING_HOUR,HT.SUBJECT,HT.FROM_DATE,HT.TO_DATE,
HT.CRS_ID,HT.CRS_SCHEDULE_ID,ht.YEAR
from HRM_TRAINING ht,HRM_PERSONAL_INFO hpi,hrm_personal_offic_info hpoi,hrm_office_info hoi,rct_desig_mst rdm
where hpi.EMP_ID(+)=HT.TRAINEE_EMP_ID
and RDM.DESIG_CODE=HPOI.PRST_DESIG_CODE
and HPOI.PRST_OFF_CODE=hoi.OFFICE_CODE
and hpi.EMP_ID=HPOI.EMP_ID
and ht.TRAINING_COUNTRY = '880'
and ht.YEAR like nvl(:P_Year,'%')
and ht.CRS_ID like nvl(:P_CRS_ID,'%')
and hpi.EMP_ID like nvl(:P_EMP_ID,'%')
order by ht.YEAR desc,HPOI.SENIORITY_SL_NO asc


-----Promotion Information Report---

select 
DISTINCT(to_char(TO_DATE(:P_FORM_DATE,'DD-MON-RRRR'),'YYYY')) Yr,
TO_DATE(:P_FORM_DATE,'DD-MON-RRRR') fromdate,
TO_DATE (PMIS_PROMOTION.PROMO_DT,'DD-MON-RRRR') todate,
(to_char(TO_DATE(:P_FORM_DATE,'DD-MON-RRRR'),'MONTH')) MON,
PMIS_PROMOTION.PROMO_DT,
(HRM_PERSONAL_INFO.FRST_NAME||' '||HRM_PERSONAL_INFO.MIDL_NAME||' '||HRM_PERSONAL_INFO.LST_NAME) name,HRM_PERSONAL_INFO.EMP_NO,
RCT_DESIG_MST.DESIG_NAME,RCT_DESIG_MST.GRADE_CODE,
(SELECT GRADE_NAME FROM PMIS_GRADE_CODE
WHERE GRADE_CODE=RCT_DESIG_MST.GRADE_CODE) GRADE_NAME,
 HRM_OFFICE_INFO.OFFICE_NAME,
PMIS_PROMOTION.PRO_CIR_DATE,(A.DESIG_NAME) pre_desig,(b.DESIG_NAME) pro_desig
from HRM_PERSONAL_INFO,RCT_DESIG_MST,HRM_PERSONAL_OFFIC_INFO,
HRM_OFFICE_INFO,PMIS_PROMOTION,RCT_DESIG_MST a,RCT_DESIG_MST b
where 
RCT_DESIG_MST.DESIG_CODE=HRM_PERSONAL_OFFIC_INFO.PRST_DESIG_CODE 
and HRM_PERSONAL_OFFIC_INFO.EMP_ID=HRM_PERSONAL_INFO.EMP_ID
and HRM_OFFICE_INFO.OFFICE_CODE=HRM_PERSONAL_OFFIC_INFO.PRST_OFF_CODE
and PMIS_PROMOTION.EMP_no=HRM_PERSONAL_INFO.EMP_ID
and A.DESIG_CODE=PMIS_PROMOTION.PREV_DESIG_CODE
and B.DESIG_CODE=PMIS_PROMOTION.PROMO_DESIG_CODE
and ((PMIS_PROMOTION.PROMO_DT >=NVL (TO_DATE(:P_FORM_DATE,'DD/MON/RRRR'),TO_DATE(PMIS_PROMOTION.PROMO_DT ,'DD/MON/RRRR')))
or (PMIS_PROMOTION.PROMO_DT LIKE decode(TO_DATE( :P_FORM_DATE,'DD/MON/RRRR'),'ALL','%','','%',TO_DATE(:P_FORM_DATE,'DD/MON/RRRR'))))
and ((PMIS_PROMOTION.PROMO_DT <=NVL ( TO_DATE(:P_TO_DATE,'DD/MON/RRRR'),TO_DATE(PMIS_PROMOTION.PROMO_DT ,'DD/MON/RRRR')))
or (PMIS_PROMOTION.PROMO_DT LIKE decode(TO_DATE( :P_TO_DATE,'DD/MON/RRRR'),'ALL','%','','%',TO_DATE(:P_TO_DATE,'DD/MON/RRRR'))))
and HRM_OFFICE_INFO.OFFICE_CODE like nvl(:P_OFFICE_LIST,'%')

---- Increment Information ----
select e.GRADE_NAME,desig_name,c.OFFICE_CODE,office_name,d.frst_name||' '||d.midl_name||' '||d.lst_name Name,d.FH_NAME,f.JOIN_DATE,
NVL(TO_DATE(:P188_FROM_DATE,'DD-MON-RRRR'),:P188_FROM_DATE) FROMDATE,
NVL(TO_DATE(:P188_TO_DATE,'DD-MON-RRRR'),:P188_TO_DATE) TODATE,
D.EMP_NO,
F.EMP_ID,
F.LAST_INCR_DT EFFECT_DATE,
F.NEXT_INC_DATE
from rct_desig_mst b,hrm_office_info c,hrm_personal_info d,PMIS_GRADE_CODE e,HRM_PERSONAL_OFFIC_INFO f
where 
b.desig_code=F.PRST_DESIG_CODE
and 
E.GRADE_CODE=F.PAY_GRD_CODE
AND F.EMP_ID=D.EMP_ID
--and b.GRADE_CODE=e.GRADE_CODE
and c.OFFICE_CODE=F.PRST_OFF_CODE
and c.OFFICE_CODE=nvl(:P188_OFFICE_LIST,c.OFFICE_CODE)
--and c.OFFICE_CODE=nvl(:P186_OFFICE_LIST,c.OFFICE_CODE)
--and E.EMP_CAT=nvl(:P98_OFF_STAFF,E.EMP_CAT)
and ((F.NEXT_INC_DATE >=NVL (TO_DATE(:P188_FROM_DATE,'DD-MON-RRRR'),TO_DATE(F.NEXT_INC_DATE,'DD-MON-RRRR')))
or (F.NEXT_INC_DATE LIKE decode(TO_DATE( :P188_FROM_DATE,'DD-MON-RRRR'),'ALL','%','','%',TO_DATE(:P188_FROM_DATE,'DD-MON-RRRR'))))
and ((F.NEXT_INC_DATE <=NVL ( TO_DATE(:P188_TO_DATE,'DD-MON-RRRR'),TO_DATE(F.NEXT_INC_DATE,'DD-MON-RRRR')))
or (F.NEXT_INC_DATE LIKE decode(TO_DATE( :P188_TO_DATE,'DD-MON-RRRR'),'ALL','%','','%',TO_DATE(:P188_TO_DATE,'DD-MON-RRRR'))))
order by F.NEXT_INC_DATE


---------------- Payroll Report ---------

---- Salary Pay Slip----

SELECT  b.OFFICE_NAME  AS unit, 
                 DECODE(Initcap(sm.mon),'Jan','January','Feb','February','Mar','March','Apr','April','May','May','Jun','June','Jul','July','Aug','August',
'Sep','September','Oct','October','Nov','November','Dec','December'
)||' '||sm.year AS month,p.FRST_NAME||' '||p.MIDL_NAME||decode(nvl(p.MIDL_NAME,'+'),'+','',' ')||p.LST_NAME  AS emp_name,
                P.EMP_id emp_NO,NVL(P.EMP_ID,p.emp_no) S_EMP_NO,p.emp_no emp_no12,
                g.DESIG_NAME,BAN.BANK_AC_NO1,
                 (am.allw_name) allw_name,
    (DECODE(sd.allw_bon_type,'A',' (A)   Salary and Allowances :','D',' (B)   Deductions :')) AS allw_bon_typ,
    (DECODE(sd.allw_bon_type,'A',' Total Salary and Allowances:','D',' Total Deductions:')) AS total_allw_bon_typ,
              (DECODE(sd.allw_bon_type,'A','Gross Pay (Tk.) :','D','Total Deduction')) AS sub_total,
               sd.allw_bon_type,
                sd.ALLW_BON_AMT+DECODE(sd.allw_bon_type,'D',(-1)*sd.ADJUST_AMT,'A',sd.ADJUST_AMT) ALLW_BON_AMT,sm.process_date,am.du_sl
 FROM HRM_OFFICE_INFO b,
     HRM_PERSONAL_INFO p,
     HRM_PERSONAL_OFFIC_INFO q,
     HRM_PERSONAL_BANK_INFO ban,
     rct_desig_mst g, 
     pmis_allowance_code_mst am,
     payroll_emp_mon_salary sd,
     payroll_emp_mon_salary_mst sm
 WHERE Q.PRST_OFF_CODE=b.OFFICE_CODE
       AND sd.emp_no=p.emp_id
       and p.emp_id=ban.emp_id(+)
       and Q.EMP_ID=P.EMP_ID
       and ban.STATUS='S'
       AND q.PRST_DESIG_CODE=g.desig_code
       AND sd.sys_id_payroll_sal=sm.sys_id_payroll_sal
       AND sd.allw_code=am.allw_code
       AND sm.salary_bonus_type='S'
       AND p.EMP_ID like nvl(:p_empno,'%')
      AND sm.mon like nvl(:p_mon,'%')
      AND sm.year=:p_year
     AND q.EMP_CAT LIKE nvl(:p_emp_cat,'%') 
     and q.PRST_OFF_CODE like nvl(:p_dept,'%')
      AND SM.AUTHO_STATUS LIKE 'A'
ORDER BY b.OFFICE_CODE,g.GRADE_CODE,am.du_sl;

------ Pay Sheet ---

SELECT g.GRADE_CODE SENIORITY_NO,p.emp_id,
              (p.frst_name||' '||p.midl_name||' '||p.lst_name||' ['||p.emp_id||']') AS emp_name,
              g.desig_code,
              g.desig_name desig_name,
              GRC.GRADE_NAME,
             g.GRADE_CODE,
              am.allw_code,
             am.allw_name,
             b.office_code,
             b.office_name AS unit,
           sm.year,
           sm.mon,
--       DECODE(sm.salary_bonus_type,'S', 'Salary Sheet for ','B','Bonus Sheet for ')||sm.mon||' '||sm.year AS report_title, 
        DECODE(sm.salary_bonus_type,'S', 'Salary Statement for the Month of ','B','Bonus Statement for the Month of ')||DECODE(Initcap(sm.mon),'Jan','January','Feb','February','Mar','March','Apr','April','May','May','Jun','June','Jul','July','Aug','August','Sep','September',    'Oct','October','Nov','November','Dec','December')||' '||sm.year AS report_title, 
--       DECODE(am.allw_bon_type,'A','   Allowances','D','   Deductions') AS allowance_bonus_type,
       sm.salary_bonus_type,
       DECODE(sd.allw_bon_type,'A','  Salary and Allowances','D','  Deductions') AS allowance_bonus_type,
                   sd.allw_bon_type,
       DECODE(sd.allw_bon_type,'A',NVL(sd.allw_bon_amt,0)+NVL(sd.adjust_amt,0),
       'D',NVL(sd.allw_bon_amt,0)+((-1)*NVL(sd.adjust_amt,0))) AS a_amt
        FROM HRM_PERSONAL_INFO p,
        HRM_PERSONAL_OFFIC_INFO q,
        rct_desig_mst g,
        HRM_OFFICE_INFO b,
        payroll_emp_mon_salary_mst sm,
        payroll_emp_mon_salary sd,
        pmis_allowance_code_mst am,
        PMIS_GRADE_CODE grc
 WHERE nvl(SM.OFFICE_CODE, q.prst_off_code)=b.office_code
   AND nvl(SM.DESIG_CODE,q.prst_desig_code)=g.desig_code
   and p.emp_id=q.emp_id
   and GRC.GRADE_CODE=G.GRADE_CODE
   AND sm.emp_no=p.emp_id
   AND sm.sys_id_payroll_sal=sd.sys_id_payroll_sal
   AND sd.allw_code=am.allw_code
   AND sm.year=:p_year
and P.JOB_STATUS not in(03)
   AND Initcap(sm.mon)=Initcap(:p_mon)
  and SM.OFFICE_CODE LIKE nvl(:p_branch_code,'%')
   AND g.desig_code LIKE nvl(:p_desig_code,'%')
   AND g.grade_code LIKE nvl(:p_grade,'%')
  AND sm.salary_bonus_type=:p_sb
 and p.emp_id like nvl(to_char(:emp_no),'%')
   and sm.AUTHO_STATUS='A'
GROUP BY  b.office_code,b.office_name,sm.year,sm.mon,b.office_code,g.GRADE_CODE,g.desig_code,g.desig_name,
                     p.emp_id,p.frst_name,p.midl_name,p.lst_name,sm.salary_bonus_type,sd.allw_bon_type,am.allw_code,am.allw_name,
                    sd.allw_bon_amt,sd.adjust_amt,GRC.GRADE_NAME,q.JOIN_DATE
ORDER BY g.GRADE_CODE,q.JOIN_DATE,b.office_code

----- Bonus Sheet---

SELECT g.GRADE_CODE SENIORITY_NO,p.emp_id,
              (p.frst_name||' '||p.midl_name||' '||p.lst_name||' ['||p.emp_id||']') AS emp_name,
              g.desig_code,
              g.desig_name,GRC.GRADE_CODE ,
              am.allw_code,
             am.allw_name,
             b.office_code,
             b.office_name AS unit,
           sm.year,SM.BASIC_AMT,
           sm.mon, 
       'Statement of '|| am.allw_name||''||DECODE(sm.salary_bonus_type,'S', ' Month of ','B',' for the Year ')||' '||sm.year AS report_title, 
       sm.salary_bonus_type,
       DECODE(sd.allw_bon_type,'A','  Salary and Allowances','D','  Deductions','B','  Bonus') AS allowance_bonus_type,
                   sd.allw_bon_type,
       round(DECODE(sd.allw_bon_type,'A',NVL(sd.allw_bon_amt,0)+NVL(sd.adjust_amt,0),'B',NVL(sd.allw_bon_amt,0)+NVL(sd.adjust_amt,0),
       'D',NVL(sd.allw_bon_amt,0)+((-1)*NVL(sd.adjust_amt,0)))) AS a_amt
        FROM HRM_PERSONAL_INFO p,
        HRM_PERSONAL_OFFIC_INFO q,
        rct_desig_mst g,
        HRM_OFFICE_INFO b,
        payroll_emp_mon_salary_mst sm,
        payroll_emp_mon_salary sd,
        pmis_allowance_code_mst am,
        PMIS_GRADE_CODE grc
 WHERE q.prst_off_code=b.office_code
   AND q.prst_desig_code=g.desig_code
   and p.emp_id=q.emp_id
   and GRC.GRADE_CODE=G.GRADE_CODE
   AND sm.emp_no=p.emp_id
   AND sm.sys_id_payroll_sal=sd.sys_id_payroll_sal
   AND sd.allw_code=am.allw_code
   AND sm.year=:p_year
   AND Initcap(sm.mon)=Initcap(:p_mon)
   AND b.office_code LIKE nvl(:p_branch_code,'%')
   AND g.desig_code LIKE nvl(:p_desig_code,'%')
   AND g.grade_code LIKE nvl(:p_grade,'%')
  AND sm.salary_bonus_type=:p_sb
  and decode(nvl(SM.BONUS_CODE,'X'),'X',:p_bonus_code,SM.BONUS_CODE)=:p_bonus_code
  and p.Emp_id like nvl(:EMP_NO,'%')
  and sm.AUTHO_STATUS='A'
  and round(DECODE(sd.allw_bon_type,'A',NVL(sd.allw_bon_amt,0)+NVL(sd.adjust_amt,0),'B',NVL(sd.allw_bon_amt,0)+NVL(sd.adjust_amt,0),
       'D',NVL(sd.allw_bon_amt,0)+((-1)*NVL(sd.adjust_amt,0)))) > 0
GROUP BY  b.office_code,b.office_name,sm.year,sm.mon,b.office_code,g.GRADE_CODE,g.desig_code,g.desig_name,GRC.GRADE_CODE ,
                     p.emp_id,p.frst_name,p.midl_name,p.lst_name,sm.salary_bonus_type,sd.allw_bon_type,am.allw_code,am.allw_name,SM.BASIC_AMT,
                    sd.allw_bon_amt,sd.adjust_amt,GRC.GRADE_NAME
ORDER BY GRC.GRADE_CODE,b.office_code,g.GRADE_CODE,emp_name

------ Pay Certificate --

SELECT  b.OFFICE_CODE,p.emp_no,b.OFFICE_NAME  AS unit, 
               p.FRST_NAME||' '||p.MIDL_NAME||decode(nvl(p.MIDL_NAME,'+'),'+','',' ')||p.LST_NAME  AS emp_name,
               P.FH_NAME,
               DECODE(Q.EMP_TYPE,'P','Permanent','R','Probation','T','Temporary','N','NWNP','TR','Trainee','A','Apprentice') Type,
               Q.JOIN_DATE,
                P.EMP_ID emp_NO,NVL(P.EMP_ID,p.emp_no) S_EMP_NO,
                g.DESIG_NAME,BAN.BANK_AC_NO1,
                 (am.allw_name) allw_name,
    UPPER(DECODE(sd.allw_bon_type,'A',' (A)   Salary And Allowances:','D',' (B)   Deductions:')) AS allw_bon_typ,
    UPPER(DECODE(sd.allw_bon_type,'A',' Total Salary And Allowances:','D',' Total Deductions:')) AS total_allw_bon_typ,
               UPPER(DECODE(sd.allw_bon_type,'A','Gross Pay','D','Total Deduction')) AS sub_total,
               sd.allw_bon_type,
               sum( sd.ALLW_BON_AMT+DECODE(sd.allw_bon_type,'D',(-1)*sd.ADJUST_AMT,'A',sd.ADJUST_AMT)) ALLW_BON_AMT,am.du_sl
 FROM HRM_OFFICE_INFO b,
     HRM_PERSONAL_INFO p,
     HRM_PERSONAL_OFFIC_INFO q,
     HRM_PERSONAL_BANK_INFO ban,
     rct_desig_mst g, 
     pmis_allowance_code_mst am,
     payroll_emp_mon_salary sd,
     payroll_emp_mon_salary_mst sm
 WHERE Q.PRST_OFF_CODE=b.OFFICE_CODE
       AND sd.emp_no=p.emp_id
       and p.emp_id=ban.emp_id(+)
       and Q.EMP_ID=P.EMP_ID
       and ban.STATUS='S'
       AND q.PRST_DESIG_CODE=g.desig_code
       AND sd.sys_id_payroll_sal=sm.sys_id_payroll_sal
       AND sd.allw_code=am.allw_code
       AND sm.salary_bonus_type='S'
       AND p.EMP_ID like nvl(:p_empno,'%')
      AND (sm.year||to_char(to_date(sm.mon,'MON'),'mm')>=:p_start_mon_yr
      and sm.year||to_char(to_date(sm.mon,'Mon'),'mm')<=:p_end_mon_yr)
     AND q.EMP_CAT LIKE :p_emp_cat 
     and q.PRST_OFF_CODE like nvl(:p_dept,'%')
      AND SM.AUTHO_STATUS LIKE 'A'
group by  b.OFFICE_NAME, 
               p.FRST_NAME||' '||p.MIDL_NAME||decode(nvl(p.MIDL_NAME,'+'),'+','',' ')||p.LST_NAME,
               P.FH_NAME,
               DECODE(Q.EMP_TYPE,'P','Permanent','R','Probation','T','Temporary','N','NWNP','TR','Trainee','A','Apprentice'),
               Q.EMP_TYPE,
               Q.JOIN_DATE,
                P.EMP_ID,NVL(P.EMP_ID,p.emp_no),
                g.DESIG_NAME,BAN.BANK_AC_NO1,
                 (am.allw_name),
    UPPER(DECODE(sd.allw_bon_type,'A',' (A)   Salary And Allowances:','D',' (B)   Deductions:')),
    UPPER(DECODE(sd.allw_bon_type,'A',' Total Salary And Allowances:','D',' Total Deductions:')),
               UPPER(DECODE(sd.allw_bon_type,'A','Gross Pay','D','Total Deduction')),
               sd.allw_bon_type,am.du_sl,b.OFFICE_CODE,p.emp_no
ORDER BY b.OFFICE_CODE,p.emp_no,am.du_sl;

------ Bonus Pay slip---

SELECT  (b.OFFICE_NAME ||' ['||b.OFFICE_CODE||']')  AS unit, 
                DECODE(Initcap(sm.mon),'Jan','January','Feb','February','Mar','March','Apr','April','May','May',
                'Jun','June','Jul','July','Aug','August','Sep','September','Oct','October','Nov','November','Dec','December')||' '||sm.year AS month,
    (P.FRST_NAME||' '||P.MIDL_NAME||' '||P.LST_NAME) AS emp_name,
                p.emp_no,
                g.desig_name,
                g.grade_code,
                sg.sub_grade_code, BAN.BANK_AC_NO1||' ('||BNK.BANK_DESC||')' bank_name,               
    am.allw_name,
    DECODE(sm.salary_bonus_type,'B','Particulars of Bonus:') AS allw_bon_typ,round(
    TO_NUMBER(NVL(TO_CHAR(sd.allw_bon_amt-sd.adjust_amt),0))) AS allw_bon_amount
     FROM HRM_OFFICE_INFO b,
      HRM_PERSONAL_INFO p,
      HRM_PERSONAL_OFFIC_INFO hpoi,
                rct_desig_mst g,
                payroll_sub_gr_desig sg, 
     pmis_allowance_code_mst am,
     payroll_emp_mon_salary sd,
      HRM_PERSONAL_BANK_INFO ban,
      RCT_BANK_MST bnk,
                payroll_emp_mon_salary_mst sm
 WHERE HPOI.PRST_OFF_CODE =b.OFFICE_CODE 
       AND sd.emp_no=to_char(p.emp_id)
       and P.EMP_ID=HPOI.EMP_ID
       AND HPOI.PRST_DESIG_CODE =g.desig_code
       AND sg.desig_code=G.DESIG_CODE
       and P.EMP_ID=BAN.EMP_ID
       and BAN.BANK_CODE1=BNK.BANK_CODE
       AND sd.sys_id_payroll_sal=sm.sys_id_payroll_sal
       AND sd.allw_code=am.allw_code
       AND sm.salary_bonus_type='B'
       and SM.AUTHO_STATUS='A'
       AND sm.year=:year
       AND Initcap(sm.mon)=Initcap(:pmon)
       AND b.OFFICE_CODE LIKE nvl(:branch_code,'%')
       AND g.desig_code LIKE nvl(:designation,'%') 
       AND to_char(p.emp_id) LIKE nvl(to_char(:employee),'%') 
       AND g.grade_code LIKE nvl(:grade,'%') 
ORDER BY g.grade_code,b.OFFICE_CODE,emp_name,am.allw_code


----- Overtime Report -----

select 
(select a.FRST_NAME || ' '||    a.MIDL_NAME || ' '||    a.LST_NAME  name   from hrm_personal_info a WHERE A.EMP_ID=PAY_OVERTIME_ENTRY.OVER_EMP_ID) Name,
        ( select DESIG_NAME from HRM_PERSONAL_OFFIC_INFO a,RCT_DESIG_MST b
 where a.PRST_DESIG_CODE=b.DESIG_CODE
 and A.EMP_ID=PAY_OVERTIME_ENTRY.OVER_EMP_ID) emp_desig,
       ( select DESIG_NAME from HRM_PERSONAL_OFFIC_INFO a,RCT_DESIG_MST b
 where a.PRST_DESIG_CODE=b.DESIG_CODE
 and A.EMP_ID=PAY_OVERTIME_ENTRY.OT_AUTHO_EMP_ID) Authorize,
 PAY_OVERTIME_ENTRY.BASIC_PAY,OT_RATE,OT_HOURS||'/ '||OT_MIN time,round(OT_CAL_AMT),round(OT_PAY_UPTO),round(OT_ACT_PAY_AMT)
 from PAY_OVERTIME_ENTRY ,HRM_PERSONAL_OFFIC_INFO
 where MONTH=:P_mon
and YAER=:P_year
and AUTHORIZED='A'
and PAY_OVERTIME_ENTRY.OVER_EMP_ID=HRM_PERSONAL_OFFIC_INFO.EMP_ID
and HRM_PERSONAL_OFFIC_INFO.PRST_OFF_CODE=:P_office_code
 order by YAER,MONTH,emp_desig 
 
 
 ------- Incentive Bonus Report ---
 
 SELECT g.GRADE_CODE SENIORITY_NO,p.emp_id,
              (p.frst_name||' '||p.midl_name||' '||p.lst_name||' ['||p.emp_id||']') AS emp_name,
              g.desig_code,
              g.desig_name,GRC.GRADE_CODE ,
              bon.allw_code,
             bon.allw_name,
             b.office_code,
             b.office_name AS unit,
           sm.year,SM.FROM_YEAR||'-'||SM.TO_YEAR year_of,SM.TO_MON||'-'||SM.TO_YEAR month_of,
           sm.mon,
           SM.FROM_MON,SM.FROM_YEAR,SM.OFF_DAY,SM.TO_MON,SM.TO_YEAR,
           sm.to_day,
           Q.JOIN_DATE,
           SM.BASIC_AMT,SM.BASIC_MON,SM.BASIC_YEAR, 
       DECODE(sm.salary_bonus_type,'S', 'Salary Sheet for ','B','Bonus Sheet for ')||DECODE(Initcap(sm.mon),'Jan','January','Feb','February','Mar','March','Apr','April','May','May',
       'Jun','June','Jul','July','Aug','August','Sep','September',    'Oct','October','Nov','November','Dec','December')||' '||sm.year AS report_title,
         DECODE(sm.salary_bonus_type,'S', 'Salary Sheet for ','B','Incentive Bonus Statement For The Period ')||
       DECODE(Initcap(SM.FROM_MON ),'Jan','January','Feb','February','Mar','March','Apr','April','May','May','Jun','June','Jul','July','Aug','August','Sep','September',
       'Oct','October','Nov','November','Dec','December')||' '||SM.FROM_YEAR||' to '||DECODE(Initcap(SM.TO_MON),'Jan','January','Feb','February','Mar','March','Apr','April','May','May','Jun','June','Jul','July','Aug','August','Sep','September',
       'Oct','October','Nov','November','Dec','December')||' '||SM.TO_YEAR AS report_title2,  
       sm.salary_bonus_type,
       bon.allowance_bonus_type,
                   bon.allw_bon_type,
       sum(DECODE(sd.allw_bon_type,'A',NVL(sd.allw_bon_amt,0),'B',NVL(sd.allw_bon_amt,0))) AS bonus_pay_amt,
       sum(DECODE(sd.allw_bon_type,'A',NVL(sd.adjust_amt,0),'B',NVL(sd.adjust_amt,0))) AS arrear_adjust_amt,
       bon.a_amt
        FROM HRM_PERSONAL_INFO p,
        HRM_PERSONAL_OFFIC_INFO q,
        rct_desig_mst g,
        HRM_OFFICE_INFO b,
        payroll_emp_mon_salary_mst sm,
        payroll_emp_mon_salary sd,
        pmis_allowance_code_mst am,
        PMIS_GRADE_CODE grc,
        (SELECT p.emp_id,
                   sd.allw_bon_type,am.allw_code,am.allw_name,decode(sd.allw_bon_type,'B','  Bonus','D','  Deductions') AS allowance_bonus_type,
               round(DECODE(sd.allw_bon_type,'A',NVL(sd.allw_bon_amt,0)+NVL(sd.adjust_amt,0),'B',NVL(sd.allw_bon_amt,0)+NVL(sd.adjust_amt,0),
               'D',NVL(sd.allw_bon_amt,0)+((-1)*NVL(sd.adjust_amt,0)))) AS a_amt
                FROM HRM_PERSONAL_INFO p,
                HRM_PERSONAL_OFFIC_INFO q,
                rct_desig_mst g,
                HRM_OFFICE_INFO b,
                payroll_emp_mon_salary_mst sm,
                payroll_emp_mon_salary sd,
                pmis_allowance_code_mst am,
                PMIS_GRADE_CODE grc
         WHERE q.prst_off_code=b.office_code
           AND q.prst_desig_code=g.desig_code
           and p.emp_id=q.emp_id
           and  SM.BONUS_CODE = '92'
           and GRC.GRADE_CODE=G.GRADE_CODE
           AND to_number(sm.emp_no)=p.emp_id
           AND sm.sys_id_payroll_sal=sd.sys_id_payroll_sal
           AND sd.allw_code=am.allw_code
           AND sm.year=:p_year
           AND Initcap(sm.mon)=Initcap(:p_mon)
           AND b.office_code LIKE nvl(:p_branch_code,'%')
           AND g.desig_code LIKE nvl(:p_desig_code,'%')
           AND g.grade_code LIKE nvl(:p_grade,'%')
           and SM.EMP_NO like nvl(:EMP_NO,'%')
          AND sm.salary_bonus_type=:p_sb
           and sm.AUTHO_STATUS='A'
        GROUP BY  p.emp_id,sd.allw_bon_type,am.allw_code,am.allw_name,
                            sd.allw_bon_amt,sd.adjust_amt) bon
 WHERE q.prst_off_code=b.office_code
   AND q.prst_desig_code=g.desig_code
   and p.emp_id=q.emp_id
   and GRC.GRADE_CODE=G.GRADE_CODE
   AND to_number(sm.emp_no)=p.emp_id
   and bon.emp_id=p.emp_id
   AND sm.sys_id_payroll_sal=sd.sys_id_payroll_sal
   AND sd.allw_code=am.allw_code
   AND sm.year=:p_year
   AND Initcap(sm.mon)=Initcap(:p_mon)
   AND b.office_code LIKE nvl(:p_branch_code,'%')
   AND g.desig_code LIKE nvl(:p_desig_code,'%')
   AND g.grade_code LIKE nvl(:p_grade,'%')
   and SM.EMP_NO like nvl(:EMP_NO,'%')
  AND sm.salary_bonus_type=:p_sb
and SM.BONUS_CODE = '92'
   and sm.AUTHO_STATUS='A'
and  bon.a_amt >0
GROUP BY  b.office_code,b.office_name,sm.year,sm.mon,b.office_code,g.GRADE_CODE,g.desig_code,g.desig_name,GRC.GRADE_CODE ,
                     p.emp_id,p.frst_name,p.midl_name,p.lst_name,sm.salary_bonus_type,bon.allw_bon_type,bon.allw_code,bon.allw_name,
                    bon.a_amt,GRC.GRADE_NAME,SM.FROM_MON,SM.FROM_YEAR,SM.OFF_DAY,SM.TO_MON,SM.TO_YEAR,
                    Q.JOIN_DATE,sm.to_day,SM.BASIC_AMT,SM.BASIC_MON,SM.BASIC_YEAR,bon.allowance_bonus_type
ORDER BY GRC.GRADE_CODE,b.office_code,g.GRADE_CODE,emp_name


--- Employee Bank Wise Bonus and  Employee Bank Wise Salary ----

(select rownum AS sl,:p_voucher_no+rownum v_no,a.emp_name,a.dept_name, a.DESIG_NAME,
       a.bank_acc_no,a.BANK_NO,a.bank_info,
       round(a.net_pay) net_pay
    from
(SELECT P.FRST_NAME||' '||P.MIDL_NAME||' '||P.LST_NAME AS emp_name,
       P.EMP_ID EMP_NO,
       pb.OFFICE_NAME dept_name,
       pdc.DESIG_NAME,
       hPBI.BANK_AC_NO1 bank_acc_no,HPBI.BRANCH_CODE1 BANK_NO,
       pbi.bank_name bank_info,pdc.DESIG_CODE,
              sm.total_amt+sm.ADJUST_AMT net_pay,
                   decode(nvl(SUM(total_amt),0),0,'--',In_word(SUM(total_amt))) AS in_words
  FROM hrm_personal_info p,
        hrm_personal_offic_info hpoi,
         hrm_personal_bank_info hpbi,
         payroll_emp_mon_salary_mst sm,
       (select RBRM.BRANCH_CODE ,RBM.BANK_DESC||','||RBRM.BRANCH_DESC bank_name 
            from RCT_BANK_MST rbm,
            RCT_BANK_BRANCH_MST rbrm
        where RBM.BANK_CODE=RBRM.BANK_CODE) pbi,
       hrm_office_info pb,
       rct_desig_mst pdc
 WHERE p.emp_id=sm.emp_no
    and hPBI.EMP_ID=P.EMP_ID
    and HPOI.EMP_ID=P.EMP_ID
   AND sm.mon=:mon
and p.JOB_STATUS not in '03'
   AND sm.year=:year
and sm.BONUS_CODE like nvl (:p_BONUS_CODE,'%')
   and SM.SALARY_BONUS_TYPE =:p_sb
   and sm.AUTHO_STATUS='A'
   and pdc.DESIG_CODE=HPOI.PRST_DESIG_CODE
   and HPOI.EMP_CAT like decode(nvl(:p_emp_cat,'%'),'A','%',:p_emp_cat)
   and (sm.total_amt+sm.ADJUST_AMT)>0
   and pbi.BRANCH_CODE =HPBI.BRANCH_CODE1
   and HPBI.BRANCH_CODE1=:P_BANK_NO
   and HPOI.PRST_OFF_CODE =pb.OFFICE_CODE
GROUP BY P.FRST_NAME,P.MIDL_NAME,P.LST_NAME,P.EMP_ID,hPBI.BANK_AC_NO1,sm.total_amt+sm.ADJUST_AMT,HPBI.BRANCH_CODE1 ,pdc.GRADE_CODE,
pbi.bank_name,pb.OFFICE_NAME ,pb.OFFICE_CODE,pdc.DESIG_NAME,pdc.DESIG_CODE
ORDER BY pdc.GRADE_CODE,pb.OFFICE_CODE,pdc.DESIG_CODE) a)


----- Insurance Report -----

select a.frst_NAME||' '||a.midl_name||' '||a.lst_name  name,r.DESIG_NAME,c.OFFICE_NAME,r.GRADE_CODE,a.BIRTH_DT,pds.ALLW_AMT,a.FH_NAME
  from HRM_PERSONAL_INFO a,HRM_PERSONAL_OFFIC_INFO b ,HRM_OFFICE_INFO c,rct_desig_mst r, PAYROLL_EMP_MON_SALARY pd,PAYROLL_EMP_MON_SALARY_MST pm,PAYROLL_SUB_GR_EMP_DTL pds,PAYROLL_SUB_GR_EMP_MST pms
where a.emp_id=B.EMP_ID
and B.PRST_DESIG_CODE=r.desig_code
and B.PRST_OFF_CODE=C.OFFICE_CODE
and JOB_STATUS=01
and PMS.EMP_NO=PM.EMP_NO
and  PM.SYS_ID_PAYROLL_SAL=PD.SYS_ID_PAYROLL_SAL
and PM.MON=:p_mon
and A.EMP_ID=PM.EMP_NO
and pm.YEAR=:p_YEAR
and PD.ALLW_CODE='01'
and PM.EMP_NO like nvl(:p_emp_id,'%')
and b.PRST_OFF_CODE=:p_OFFICE_CODE
and pm.AUTHO_STATUS='A'
and pds.ALLW_CODE=01
and pds.EXP_DATE is null
and PMs.SUB_GR_EMP_SYS_ID=PDs.SUB_GR_EMP_SYS_ID
 order by r.GRADE_CODE,A.EMP_NO,b.JOIN_DATE 
 
 ----- Employee Bank Wise Incentive Bonus ----
 
 (select rownum AS sl,:p_voucher_no+rownum v_no,a.emp_name,a.dept_name, a.DESIG_NAME,
       a.bank_acc_no,a.BANK_NO,a.bank_info,
       round(a.net_pay) net_pay
    from
(SELECT P.FRST_NAME||' '||P.MIDL_NAME||' '||P.LST_NAME AS emp_name,
       P.EMP_ID EMP_NO,
       pb.OFFICE_NAME dept_name,
       pdc.DESIG_NAME,
       hPBI.BANK_AC_NO1 bank_acc_no,HPBI.BRANCH_CODE1 BANK_NO,
       pbi.bank_name bank_info,pdc.DESIG_CODE,
              sm.total_amt+sm.ADJUST_AMT net_pay,
                   decode(nvl(SUM(total_amt),0),0,'--',In_word(SUM(total_amt))) AS in_words
  FROM hrm_personal_info p,
        hrm_personal_offic_info hpoi,
         hrm_personal_bank_info hpbi,
         payroll_emp_mon_salary_mst sm,
       (select RBRM.BRANCH_CODE ,RBM.BANK_DESC||','||RBRM.BRANCH_DESC bank_name 
            from RCT_BANK_MST rbm,
            RCT_BANK_BRANCH_MST rbrm
        where RBM.BANK_CODE=RBRM.BANK_CODE) pbi,
       hrm_office_info pb,
       rct_desig_mst pdc
 WHERE p.emp_id=sm.emp_no
    and hPBI.EMP_ID=P.EMP_ID
    and HPOI.EMP_ID=P.EMP_ID
   AND sm.mon=:mon
and p.JOB_STATUS not in '03'
   AND sm.year=:year
and sm.BONUS_CODE like nvl (:p_BONUS_CODE,'%')
   and SM.SALARY_BONUS_TYPE =:p_sb
   and sm.AUTHO_STATUS='A'
   and pdc.DESIG_CODE=HPOI.PRST_DESIG_CODE
   and HPOI.EMP_CAT like decode(nvl(:p_emp_cat,'%'),'A','%',:p_emp_cat)
   and (sm.total_amt+sm.ADJUST_AMT)>0
   and pbi.BRANCH_CODE =HPBI.BRANCH_CODE1
   and HPBI.BRANCH_CODE1=:P_BANK_NO
   and HPOI.PRST_OFF_CODE =pb.OFFICE_CODE
GROUP BY P.FRST_NAME,P.MIDL_NAME,P.LST_NAME,P.EMP_ID,hPBI.BANK_AC_NO1,sm.total_amt+sm.ADJUST_AMT,HPBI.BRANCH_CODE1 ,pdc.GRADE_CODE,
pbi.bank_name,pb.OFFICE_NAME ,pb.OFFICE_CODE,pdc.DESIG_NAME,pdc.DESIG_CODE
ORDER BY pdc.GRADE_CODE,pb.OFFICE_CODE,pdc.DESIG_CODE) a)


----- Salary Pay Slip Confirmation Report ---

select a.EMP_ID,A.EMP_NO||'-'||a.frst_NAME||' '||a.midl_name||' '||a.lst_name  name,r.DESIG_NAME,c.OFFICE_NAME,pc.P_MON,pc.P_YEAR,to_char(PC.CON_DATE) CON_DATE
from PAYSLIP_CONFIRM pc,HRM_PERSONAL_INFO a,HRM_PERSONAL_OFFIC_INFO b ,HRM_OFFICE_INFO c,rct_desig_mst r
where pc.EMP_ID=a.EMP_ID
and a.emp_id=B.EMP_ID
and B.PRST_DESIG_CODE=r.desig_code
and B.PRST_OFF_CODE=C.OFFICE_CODE
and C.OFFICE_CODE=:P_Office
and pc.P_MON=:P_MON
and pc.P_YEAR=:PYEAR
order by b.SENIORITY_SL_NO


--------- Leave Encashment Statement ------

select HOI.OFFICE_NAME,HPI.EMP_NO,HPI.EMP_ID,
    decode(nvl(HPI.FRST_NAME,'x'),'x',HPI.FRST_NAME,HPI.FRST_NAME)||
    decode(nvl(HPI.MIDL_NAME ,'x'),'x',HPI.MIDL_NAME,' '||HPI.MIDL_NAME)||
    decode(nvl(HPI.LST_NAME ,'x'),'x',HPI.LST_NAME,' '||HPI.LST_NAME) emp_info,DES.DESIG_NAME Designation,PLTY.LV_NAME lv_name,
    plen.LEAVE_TYPE_CODE, plen.ENCASHED_DAYS, plen.RATE_PER_DAY, plen.STATUS, plen.ENCASH_DATE,
    DES.GRADE_CODE,plen.ENCASHED_AMOUNT,plen.PYEAR,hpoi.SENIORITY_SL_NO,
    (select SGD.ALLW_AMT
        from payroll_sub_gr_emp_dtl sgd
    where SGD.ALLW_CODE='01'
    and  (SGD.EFFECT_DATE <=to_date('3112'||nvl(plen.PYEAR,'1901'),'ddmmrrrr')
    and nvl(SGD.EXP_DATE ,sysdate)>=to_date('3112'||nvl(plen.PYEAR,'1901'),'ddmmrrrr'))
    and SGD.SUB_GR_EMP_SYS_ID in
    (select SGM.SUB_GR_EMP_SYS_ID
        from payroll_sub_gr_emp_mst sgm
    where (SGM.EFFECT_DATE<=to_date('3112'||nvl(plen.PYEAR,'1901'),'ddmmrrrr')
    and nvl(SGM.EXPIRE_DATE,sysdate)>=to_date('3112'||nvl(plen.PYEAR,'1901'),'ddmmrrrr'))
    and SGM.EMP_NO=HPI.EMP_ID)
    union
    select SD.ALLW_BON_AMT
        from PAYROLL_EMP_MON_SALARY sd,
        PAYROLL_EMP_MON_SALARY_MST sm
    where SM.SYS_ID_PAYROLL_SAL=SD.SYS_ID_PAYROLL_SAL
    and SM.MON='Dec'
    and SM.YEAR=plen.PYEAR
    and SM.YEAR<2014
    and SD.ALLW_CODE='01'
    and SD.EMP_NO=HPI.EMP_ID) dec_basic
    from PMIS_LEAVE_encash plen,
    pmis_leave_type_code plty,
    hrm_personal_offic_info hpoi,
    hrm_personal_info hpi,
    rct_desig_mst des,
    hrm_office_info hoi
where  PLen.LEAVE_TYPE_CODE=PLTY.LV_TYPE_CODE
and HPOI.EMP_ID=PLen.EMP_ID
and hpoi.EMP_ID=hpi.EMP_ID
and HPOI.PRST_DESIG_CODE=DES.DESIG_CODE
and HOI.OFFICE_CODE=HPOI.PRST_OFF_CODE
and  HPI.EMP_ID Like nvl(:P_EMP_NO,'%')
and PLTY.LV_TYPE_CODE Like nvl(:P_LEAVE_TYPE_CODE,'%')
and  plen.ENCASH_DATE Like nvl(:P_ENCASH_DATE,'%')
AND DES.DESIG_CODE LIKE NVL(:P_DESIGNATION,'%')
AND HOI.OFFICE_CODE LIKE NVL(:P_OFFICE_NAME,'%')
order by to_number(hpoi.SENIORITY_SL_NO) asc;

-----   Employee Bank Wise Leave Encashment ------

(select rownum AS sl,:p_voucher_no+rownum v_no,a.emp_name,a.dept_name, a.DESIG_NAME,a.bank_acc_no,a.BANK_NO,a.bank_info,a.net_pay
 from (SELECT P.FRST_NAME||' '||P.MIDL_NAME||' '||P.LST_NAME AS emp_name,P.EMP_ID EMP_NO,pb.OFFICE_NAME dept_name,pdc.DESIG_NAME,
          hPBI.BANK_AC_NO1 bank_acc_no,HPBI.BRANCH_CODE1 BANK_NO,pbi.bank_name bank_info,pdc.DESIG_CODE,
          ple.ENCASHED_AMOUNT net_pay,decode(nvl(SUM(ENCASHED_AMOUNT),0),0,'--',In_word(SUM(ENCASHED_AMOUNT))) AS in_words
FROM hrm_personal_info p,hrm_personal_offic_info hpoi,hrm_personal_bank_info hpbi,PMIS_LEAVE_ENCASH ple,
           (select RBRM.BRANCH_CODE ,RBM.BANK_DESC||','||RBRM.BRANCH_DESC bank_name 
            from RCT_BANK_MST rbm,RCT_BANK_BRANCH_MST rbrm
            where RBM.BANK_CODE=RBRM.BANK_CODE) pbi,
            hrm_office_info pb,rct_desig_mst pdc
WHERE p.emp_id=ple.EMP_ID
and hPBI.EMP_ID=P.EMP_ID
and HPOI.EMP_ID=P.EMP_ID
and p.JOB_STATUS not in '03'
and ple.PYEAR=:year
and pdc.DESIG_CODE=HPOI.PRST_DESIG_CODE
and HPOI.EMP_CAT like decode(nvl(:p_emp_cat,'%'),'A','%',:p_emp_cat)
and ple.ENCASHED_AMOUNT >0
and pbi.BRANCH_CODE =HPBI.BRANCH_CODE1
and HPBI.BRANCH_CODE1=:P_BANK_NO
and HPOI.PRST_OFF_CODE =pb.OFFICE_CODE
GROUP BY P.FRST_NAME,P.MIDL_NAME,P.LST_NAME,P.EMP_ID,hPBI.BANK_AC_NO1,ple.ENCASHED_AMOUNT,HPBI.BRANCH_CODE1 ,pdc.GRADE_CODE,
pbi.bank_name,pb.OFFICE_NAME ,pb.OFFICE_CODE,pdc.DESIG_NAME,pdc.DESIG_CODE
ORDER BY pdc.GRADE_CODE,pb.OFFICE_CODE,pdc.DESIG_CODE) a)


------ K.P.I Bonus Report ---

SELECT g.GRADE_CODE SENIORITY_NO,p.emp_id,
              (p.frst_name||' '||p.midl_name||' '||p.lst_name||' ['||p.emp_id||']') AS emp_name,
              g.desig_code,
              g.desig_name,GRC.GRADE_CODE ,
              bon.allw_code,
             bon.allw_name,
             b.office_code,
             b.office_name AS unit,
           sm.year,SM.FROM_YEAR||'-'||SM.TO_YEAR year_of,SM.TO_MON||'-'||SM.TO_YEAR month_of,
           sm.mon,
           SM.FROM_MON,SM.FROM_YEAR,SM.OFF_DAY,SM.TO_MON,SM.TO_YEAR,
           sm.to_day,
           Q.JOIN_DATE,
           SM.BASIC_AMT,SM.BASIC_MON,SM.BASIC_YEAR, 
       DECODE(sm.salary_bonus_type,'S', 'Salary Sheet for ','B','Bonus Sheet for ')||DECODE(Initcap(sm.mon),'Jan','January','Feb','February','Mar','March','Apr','April','May','May',
       'Jun','June','Jul','July','Aug','August','Sep','September',    'Oct','October','Nov','November','Dec','December')||' '||sm.year AS report_title,
         DECODE(sm.salary_bonus_type,'S', 'Salary Sheet for ','B','K.P.I Bonus Statement For The Period ')||
       DECODE(Initcap(SM.FROM_MON ),'Jan','January','Feb','February','Mar','March','Apr','April','May','May','Jun','June','Jul','July','Aug','August','Sep','September',
       'Oct','October','Nov','November','Dec','December')||' '||SM.FROM_YEAR||' to '||DECODE(Initcap(SM.TO_MON),'Jan','January','Feb','February','Mar','March','Apr','April','May','May','Jun','June','Jul','July','Aug','August','Sep','September',
       'Oct','October','Nov','November','Dec','December')||' '||SM.TO_YEAR AS report_title2,  
       sm.salary_bonus_type,
       bon.allowance_bonus_type,
                   bon.allw_bon_type,
       sum(DECODE(sd.allw_bon_type,'A',NVL(sd.allw_bon_amt,0),'B',NVL(sd.allw_bon_amt,0))) AS bonus_pay_amt,
       sum(DECODE(sd.allw_bon_type,'A',NVL(sd.adjust_amt,0),'B',NVL(sd.adjust_amt,0))) AS arrear_adjust_amt,
       bon.a_amt,
       bon.percentage
        FROM HRM_PERSONAL_INFO p,
        HRM_PERSONAL_OFFIC_INFO q,
        rct_desig_mst g,
        HRM_OFFICE_INFO b,
        payroll_emp_mon_salary_mst sm,
        payroll_emp_mon_salary sd,
        pmis_allowance_code_mst am,
        PMIS_GRADE_CODE grc,
        (SELECT p.emp_id,
                   sd.allw_bon_type,am.allw_code,am.allw_name,decode(sd.allw_bon_type,'B','  Bonus','D','  Deductions') AS allowance_bonus_type,
               round(DECODE(sd.allw_bon_type,'A',NVL(sd.allw_bon_amt,0)+NVL(sd.adjust_amt,0),'B',NVL(sd.allw_bon_amt,0)+NVL(sd.adjust_amt,0),
               'D',NVL(sd.allw_bon_amt,0)+((-1)*NVL(sd.adjust_amt,0)))) AS a_amt,SM.REMARKS AS percentage
                FROM HRM_PERSONAL_INFO p,
                HRM_PERSONAL_OFFIC_INFO q,
                rct_desig_mst g,
                HRM_OFFICE_INFO b,
                payroll_emp_mon_salary_mst sm,
                payroll_emp_mon_salary sd,
                pmis_allowance_code_mst am,
                PMIS_GRADE_CODE grc
         WHERE q.prst_off_code=b.office_code
           AND q.prst_desig_code=g.desig_code
           and p.emp_id=q.emp_id
           and  SM.BONUS_CODE = '101'
           and GRC.GRADE_CODE=G.GRADE_CODE
           AND to_number(sm.emp_no)=p.emp_id
           AND sm.sys_id_payroll_sal=sd.sys_id_payroll_sal
           AND sd.allw_code=am.allw_code
           AND sm.year=:p_year
           AND Initcap(sm.mon)=Initcap(:p_mon)
           AND b.office_code LIKE nvl(:p_branch_code,'%')
           AND g.desig_code LIKE nvl(:p_desig_code,'%')
           AND g.grade_code LIKE nvl(:p_grade,'%')
           and SM.EMP_NO like nvl(:EMP_NO,'%')
          AND sm.salary_bonus_type=:p_sb
           and sm.AUTHO_STATUS='A'
        GROUP BY  p.emp_id,sd.allw_bon_type,am.allw_code,am.allw_name,
                            sd.allw_bon_amt,sd.adjust_amt,SM.REMARKS) bon
 WHERE q.prst_off_code=b.office_code
   AND q.prst_desig_code=g.desig_code
   and p.emp_id=q.emp_id
   and GRC.GRADE_CODE=G.GRADE_CODE
   AND to_number(sm.emp_no)=p.emp_id
   and bon.emp_id=p.emp_id
   AND sm.sys_id_payroll_sal=sd.sys_id_payroll_sal
   AND sd.allw_code=am.allw_code
   AND sm.year=:p_year
   AND Initcap(sm.mon)=Initcap(:p_mon)
   AND b.office_code LIKE nvl(:p_branch_code,'%')
   AND g.desig_code LIKE nvl(:p_desig_code,'%')
   AND g.grade_code LIKE nvl(:p_grade,'%')
   and SM.EMP_NO like nvl(:EMP_NO,'%')
  AND sm.salary_bonus_type=:p_sb
and SM.BONUS_CODE = '101'
   and sm.AUTHO_STATUS='A'
and  bon.a_amt >0
GROUP BY  b.office_code,b.office_name,sm.year,sm.mon,b.office_code,g.GRADE_CODE,g.desig_code,g.desig_name,GRC.GRADE_CODE ,
                     p.emp_id,p.frst_name,p.midl_name,p.lst_name,sm.salary_bonus_type,bon.allw_bon_type,bon.allw_code,bon.allw_name,
                    bon.a_amt,bon.percentage,GRC.GRADE_NAME,SM.FROM_MON,SM.FROM_YEAR,SM.OFF_DAY,SM.TO_MON,SM.TO_YEAR,
                    Q.JOIN_DATE,sm.to_day,SM.BASIC_AMT,SM.BASIC_MON,SM.BASIC_YEAR,bon.allowance_bonus_type
ORDER BY GRC.GRADE_CODE,b.office_code,g.GRADE_CODE,emp_name