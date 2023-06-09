--INSERT INTO PAYROLL_SUB_GR_EMP_MST 
EMP_NO ,SUB_GRADE_CODE,TIMES, INCRE_NATURE,
SUB_GR_EMP_SYS_ID,
DESIG_CODE, EFFECT_DATE, EXPIRE_DATE,SUB_GR_CD_TS_SG , DEPT_CODE 
(k.emp_ID,k.sub_grade_code,0,'N',seq_emp_sub_grade.NEXTVAL,
         k.prst_desig_code,k.prst_desig_date,NULL,NULL,k.PRST_OFF_CODE)


HRM_PERSONAL_INFO,HRM_PERSONAL_OFFIC_INFO,PAYROLL_SUB_GR_DESIG

SELECT * FROM ERP.HRM_PERSONAL_OFFIC_INFO
WHERE EMP_ID=1629

SELECT * FROM ERP.HRM_PERSONAL_INFO

SELECT * FROM ERP.PAYROLL_SUB_GR_DESIG

--SAVE--PAYROLL_SUB_GR_EMP_MST

SELECT PI.EMP_NO,PRST_OFF_CODE ,PRST_DESIG_CODE,NVL(POI.LAST_PROM_DATE,POI.JOIN_DATE) prst_desig_date, SGD.SUB_GRADE_CODE
FROM ERP.HRM_PERSONAL_INFO PI,ERP.HRM_PERSONAL_OFFIC_INFO POI,ERP.PAYROLL_SUB_GR_DESIG SGD
WHERE PI.EMP_ID = POI.EMP_ID
AND POI.PRST_DESIG_CODE=SGD.DESIG_CODE
AND POI.PRST_OFF_CODE='000031'
AND POI.EMP_CAT='O'
AND PI.JOB_STATUS='01'
AND (PI.EMP_NO,POI.PRST_DESIG_CODE,POI.PRST_OFF_CODE) NOT IN (
SELECT EMP_NO,DESIG_CODE,DEPT_CODE FROM ERP.PAYROLL_SUB_GR_EMP_MST
WHERE DEPT_CODE='000031'
)

SELECT * FROM PAYROLL_SUB_GR_EMP_DTL

--ALLW_CODE,ALLW_AMT,PERC_AMT,PERC_ALLW_CODE,EFFECT_DATE,EXP_DATE

select SUB_GRADE_CODE,ALLW_CODE, ALLW_AMT, PERC_AMT, PERC_ALLW_CODE,EFFECT_DATE,EXP_DATE
from erp.PMIS_SUB_GRADE_dtl d

SELECT * FROM ERP.PAYROLL_SUB_GR_DESIG

select * from erp.PAYROLL_SUB_GR_EMP_MST 




