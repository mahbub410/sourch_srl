SELECT PO.PO_NO,PO.PO_USER_NO,TO_CHAR(PO.PO_DATE,'DD/MM/RRRR') PO_DATE,DECODE(PO.PO_ORIGIN,'F','Foreign','L','Local') PO_ORIGIN,
S.SUP_CODE,S.SUP_DESC AS SUPPLIER_NAME,PO.LOC_CODE,L.LOC_DESC LOCATION_NAME,PO.PO_MEMO_NO AS INVOICE_NO,
TO_CHAR(PO.PO_MEMO_DATE,'DD/MM/RRRR') AS INVOICE_DATE,RM.BILL_OF_LADING_NO,TO_CHAR(RM.BILL_OF_LADING_DATE,'DD/MM/RRRR') AS BILL_OF_LADING_DATE,
RM.RI_NO,RM.RI_USER_NO,TO_CHAR(RM.RI_DATE,'DD/MM/RRRR') AS RI_DATE,PO.PO_LC_NO,TO_CHAR(PO.PO_LC_DATE,'DD/MM/RRRR') AS PO_LC_DATE,I.ITEM_DESC AS ITEM_NAME,
ITEM_PART_NO AS ITEM_SPECIFICATION,M.MSR_UNIT_DESC MSR_UNIT_NAME,RD.RI_ITEM_QTY,RD.UNIT_COST,SUM(RD.RI_ITEM_QTY*RD.UNIT_COST) AS TOTAL_COST,
'Room_Loca-'||RS.LOC_CODE||';'||'Rack-Bin--'||RS.RACK_CODE||'-'||RS.BIN_CODE AS ITEM_LOCATION_STORE,I.ACCOUNT_CARD_NO
FROM ST_RI_MST RM, ST_RI_DTL RD, ST_RI_STORAGE RS, ST_PO_MST PO,SFS.SUPPLIER_MST S,ST_LOCATION L,ST_ITEM_MST I,MEASURE_UNIT M
WHERE RM.RI_MST_ID=RD.RI_MST_ID
AND RM.RI_MST_ID=RS.RI_MST_ID(+)
AND RM.PO_NO=PO.PO_NO
AND PO.SUP_CODE=S.SUP_CODE
AND RM.LOC_CODE=L.LOC_CODE
AND RM.RI_USER_NO=p_RI_NO
AND RM.RI_DATE=p_RI_DATE
AND RM.LOC_CODE IN (SELECT LOC_CODE FROM ST_LOCATION
                    WHERE UNIT_CODE IN(SELECT UNIT_CODE FROM UNITOFFICE
                                       START WITH UNIT_CODE IN(SELECT UNIT_CODE FROM SFS.ADMIN_USER_MST
                                                               WHERE USER_CODE=p_USER)
                                       CONNECT BY PRIOR UNIT_CODE=PARENT_CODE))
AND RD.ITEM_CODE=I.ITEM_CODE
AND RD.MSR_UNIT_CODE=M.MSR_UNIT_CODE(+)
GROUP BY PO.PO_NO,PO.PO_USER_NO,PO.PO_DATE ,PO.PO_ORIGIN,S.SUP_CODE,S.SUP_DESC,PO.LOC_CODE,L.LOC_DESC ,PO.PO_MEMO_NO ,
PO.PO_MEMO_DATE,RM.BILL_OF_LADING_NO,RM.BILL_OF_LADING_DATE,RM.RI_NO,RM.RI_USER_NO,RM.RI_DATE,PO.PO_LC_NO,PO.PO_LC_DATE,
I.ITEM_DESC ,ITEM_PART_NO ,M.MSR_UNIT_DESC ,RD.RI_ITEM_QTY,RD.UNIT_COST,I.ACCOUNT_CARD_NO,RS.LOC_CODE,RS.RACK_CODE,RS.BIN_CODE








SELECT RM.RI_MST_ID,PO.PO_NO,PO.PO_USER_NO,TO_CHAR(PO.PO_DATE,'DD/MM/RRRR') PO_DATE,DECODE(PO.PO_ORIGIN,'F','Foreign','L','Local') PO_ORIGIN,
        S.SUP_CODE,S.SUP_DESC AS SUPPLIER_NAME,PO.LOC_CODE,L.LOC_DESC LOCATION_NAME,PO.PO_MEMO_NO AS INVOICE_NO,
        TO_CHAR(PO.PO_MEMO_DATE,'DD/MM/RRRR') AS INVOICE_DATE,RM.BILL_OF_LADING_NO,TO_CHAR(RM.BILL_OF_LADING_DATE,'DD/MM/RRRR') AS BILL_OF_LADING_DATE,
        RM.RI_NO,RM.RI_USER_NO,TO_CHAR(RM.RI_DATE,'DD/MM/RRRR') AS RI_DATE,PO.PO_LC_NO,TO_CHAR(PO.PO_LC_DATE,'DD/MM/RRRR') AS PO_LC_DATE,I.ITEM_DESC AS ITEM_NAME,
        ITEM_PART_NO AS ITEM_SPECIFICATION,M.MSR_UNIT_DESC MSR_UNIT_NAME,RD.RI_ITEM_QTY, RS.RI_STORAGE_QTY,RD.UNIT_COST,(RS.RI_STORAGE_QTY*RD.UNIT_COST) AS TOTAL_COST,
       'Loca-('||L.LOC_DESC||')'||'SECTION-('||SEC_DESC||')'||'Rack-('||R.RACK_DESC||'),'||'BIN-('||BIN_DESC||')' AS ITEM_LOCATION_STORE,I.ACCOUNT_CARD_NO
        FROM ST_RI_MST RM, ST_RI_DTL RD, ST_RI_STORAGE RS, ST_PO_MST PO,SFS.SUPPLIER_MST S,ST_LOCATION L,ST_ITEM_MST I,MEASURE_UNIT M,
        ST_PO_DTL PD, ST_SECTION SC,ST_RACK R,ST_BIN B
        WHERE RM.RI_MST_ID=RD.RI_MST_ID
        AND RD.RI_DTL_ID=RS.RI_DTL_ID
        AND RM.PO_NO=PO.PO_NO
        AND PO.SUP_CODE=S.SUP_CODE
        AND RM.LOC_CODE=L.LOC_CODE
        AND RM.RI_USER_NO=:p_RI_NO
        AND RM.RI_DATE=:p_RI_DATE
        AND RM.LOC_CODE IN (SELECT LOC_CODE FROM ST_LOCATION
                    WHERE UNIT_CODE IN(SELECT UNIT_CODE FROM UNITOFFICE
                                       START WITH UNIT_CODE IN(SELECT UNIT_CODE FROM SFS.ADMIN_USER_MST
                                                               WHERE USER_CODE=:p_USER)
                                       CONNECT BY PRIOR UNIT_CODE=PARENT_CODE))
        AND RD.ITEM_CODE=I.ITEM_CODE
        AND PD.MSR_UNIT_CODE=M.MSR_UNIT_CODE(+)
        AND PO.PO_NO=PD.PO_NO
        AND RS.SEC_CODE=SC.SEC_CODE
        AND RS.RACK_CODE=R.RACK_CODE
        AND RS.BIN_CODE=B.BIN_CODE;