SELECT PO.PO_NO,PO.PO_USER_NO,TO_CHAR(PO.PO_DATE,'DD/MM/RRRR') PO_DATE,DECODE(PO.PO_ORIGIN,'F','Foreign','L','Local') PO_ORIGIN,
SU.SUP_CODE,SU.SUP_DESC AS SUPPLIER_NAME,PO.LOC_CODE,LO.LOC_DESC LOCATION_NAME,PO.PO_MEMO_NO AS INVOICE_NO,
TO_CHAR(PO.PO_MEMO_DATE,'DD/MM/RRRR') AS INVOICE_DATE,RI.BILL_OF_LADING_NO,TO_CHAR(RI.BILL_OF_LADING_DATE,'DD/MM/RRRR') AS BILL_OF_LADING_DATE,
RI.RI_NO,RI.RI_USER_NO,TO_CHAR(RI.RI_DATE,'DD/MM/RRRR') AS RI_DATE,PO.PO_LC_NO,TO_CHAR(PO.PO_LC_DATE,'DD/MM/RRRR') AS PO_LC_DATE,IT.ITEM_DESC AS ITEM_NAME,
ITEM_PART_NO AS ITEM_SPECIFICATION,ME.MSR_UNIT_DESC MSR_UNIT_NAME,R.RI_ITEM_QTY,R.UNIT_COST,SUM(ME.MSR_UNIT_CODE*R.UNIT_COST) AS TOTAL_COST,IT.ACCOUNT_CARD_NO
FROM ST_PO_MST PO,SFS.SUPPLIER_MST SU,ST_RI_MST RI,ST_RI_DTL R,ST_LOCATION LO,ST_ITEM_MST IT,MEASURE_UNIT ME
WHERE PO.SUP_CODE=SU.SUP_CODE
AND PO.LOC_CODE=LO.LOC_CODE
AND PO.PO_NO=RI.PO_NO
AND RI.RI_MST_ID=R.RI_MST_ID
AND R.MSR_UNIT_CODE=ME.MSR_UNIT_CODE(+)
GROUP BY PO.PO_NO,PO.PO_USER_NO,TO_CHAR(PO.PO_DATE,'DD/MM/RRRR'),DECODE(PO.PO_ORIGIN,'F','Foreign','L','Local'),
SU.SUP_CODE,SU.SUP_DESC ,PO.LOC_CODE,LO.LOC_DESC ,PO.PO_MEMO_NO ,
PO.PO_MEMO_DATE ,RI.BILL_OF_LADING_NO,RI.BILL_OF_LADING_DATE,RI.RI_NO,RI.RI_USER_NO,RI.RI_DATE,
PO.PO_LC_NO,PO.PO_LC_DATE,IT.ITEM_DESC ,ITEM_PART_NO ,R.RI_ITEM_QTY, R.UNIT_COST,ACCOUNT_CARD_NO,ME.MSR_UNIT_DESC



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
AND RD.ITEM_CODE=I.ITEM_CODE
AND RD.MSR_UNIT_CODE=M.MSR_UNIT_CODE(+)
GROUP BY PO.PO_NO,PO.PO_USER_NO,PO.PO_DATE ,PO.PO_ORIGIN,S.SUP_CODE,S.SUP_DESC,PO.LOC_CODE,L.LOC_DESC ,PO.PO_MEMO_NO ,
PO.PO_MEMO_DATE,RM.BILL_OF_LADING_NO,RM.BILL_OF_LADING_DATE,RM.RI_NO,RM.RI_USER_NO,RM.RI_DATE,PO.PO_LC_NO,PO.PO_LC_DATE,
I.ITEM_DESC ,ITEM_PART_NO ,M.MSR_UNIT_DESC ,RD.RI_ITEM_QTY,RD.UNIT_COST,I.ACCOUNT_CARD_NO,RS.LOC_CODE,RS.RACK_CODE,RS.BIN_CODE

   
           
            
