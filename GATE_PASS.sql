


SELECT DELIVERY_ID,DELIVERY_NUMBER,DELIVERY_TYPE,M.COMPANY_CODE,CO.COMPANY_NAME,DELIVERY_DATE,SOURCE_FACTORY,S.SITE_NAME, GATE_PASS_NO
FROM DELIVERY_MST M,COMPANY CO,SITE S
WHERE M.COMPANY_CODE = CO.COMPANY_CODE
AND M.SOURCE_FACTORY=S.SITE_CODE
AND M.DELIVERY_TYPE='GP'
AND M.DELIVERY_NUMBER

SELECT * FROM DELIVERY_DTL

SELECT DELIVERY_DTL_ID, DELIVERY_MST_ID, DELIVERY_NUMBER, A.ITEM_CODE,B.ITEM_DESC,A. MSR_UNIT_CODE,
 D.MSR_UNIT_DESC,ITEM_SPEC1, ITEM_SPEC2, ITEM_SPEC3,QNTY,ITEM_RATE,AMOUNT,PACKING_UNIT
FROM DELIVERY_DTL A, ITEM_MST B,MEASURE_UNIT D 
WHERE A.ITEM_CODE=B.ITEM_CODE
AND A.MSR_UNIT_CODE = D.MSR_UNIT_CODE
AND DELIVERY_NUMBER=:P_Delivery_Number
ORDER BY DELIVERY_DTL_ID;

SELECT M.DELIVERY_NUMBER, DECODE(DELIVERY_TYPE,'SO','Sale Order','WSO','Without Sale Order','GP','Gate Pass Only') DELIVERY_TYPE, 
        COMPANY_NAME,TO_CHAR(DELIVERY_DATE,'DD/MM/RRRR') DELIVERY_DATE,GATE_PASS_NO, 
        I.ITEM_DESC||' '||ITEM_SPEC1||' '||ITEM_SPEC2||' '||ITEM_SPEC3 ITEM_DESC, 
        MSR_UNIT_DESC,S.SITE_NAME SITE_NAME, NVL(QNTY,0) QNTY,PACKING_UNIT
        FROM DELIVERY_DTL D,DELIVERY_MST M,COMPANY C,ITEM_MST I,MEASURE_UNIT MU,SITE S
        WHERE M.DELIVERY_ID=D.DELIVERY_MST_ID
        AND M.DELIVERY_NUMBER=D.DELIVERY_NUMBER
        AND M.COMPANY_CODE=C.COMPANY_CODE
        AND D.ITEM_CODE=I.ITEM_CODE
        AND D.MSR_UNIT_CODE=MU.MSR_UNIT_CODE
        AND M.SOURCE_FACTORY=S.SITE_CODE
        AND M.COMPANY_CODE=:P_COMPANY_CODE
        AND M.DELIVERY_NUMBER=:P_DELIVERY_NUMBER
  
 
    