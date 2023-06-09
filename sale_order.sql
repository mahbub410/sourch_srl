SELECT distinct om.SALE_ORDER_NUMBER SALE_ORDER_NO,'SONo:'||om.SALE_ORDER_NUMBER||',RefSONo:'||REF_SALE_ORDER_NUMBER||
    ',Company:'||C.COMPANY_NAME||',Customer:'||CU.CUSTOMER_NAME||',OrderDate:'||TO_CHAR(OM.ORDER_DATE,'dd/mm/yy')||
    ',DelDate:'||TO_CHAR(OM.DELIVERY_DATE,'dd/mm/yy') SALE_ORDER_DESC
    FROM SALE_ORDER_MST OM,COMPANY C,CUSTOMER CU,SALE_ORDER_dtl od
    WHERE OM.COMPANY_CODE = C.COMPANY_CODe(+)
    and om.SALE_ORDER_NUMBER = od.SALE_ORDER_NUMBER
    AND AUTHO_STATUS = 'Y'
    AND OM.CUST_CODE=CU.CUSTOMER_CODE
and (om.SALE_ORDER_NUMBER,od.ITEM_CODE) in (
select SALE_ORDER_NUMBER,ITEM_CODE from (
select dd.SALE_ORDER_NUMBER,ITEM_CODE,sum(nvl(QNTY,0)) from SALE_ORDER_dtl dd,SALE_ORDER_MST dm
where dd.SALE_ORDER_NUMBER = dm.SALE_ORDER_NUMBER
and AUTHO_STATUS='Y'
group by dd.SALE_ORDER_NUMBER,ITEM_CODE
minus
select dd.SALE_ORDER_NUMBER,ITEM_CODE,sum(nvl(QNTY,0)) from DELIVERY_DTL dd,DELIVERY_MST dm
where dd.DELIVERY_NUMBER = dm.DELIVERY_NUMBER
group by dd.SALE_ORDER_NUMBER,ITEM_CODE))
    ORDER BY 1 DESC;
    
 -----------------
    
SELECT distinct om.SALE_ORDER_NUMBER SALE_ORDER_NO,'SONo:'||om.SALE_ORDER_NUMBER||',RefSONo:'||REF_SALE_ORDER_NUMBER||
',Company:'||C.COMPANY_NAME||',Customer:'||CU.CUSTOMER_NAME||',OrderDate:'||TO_CHAR(OM.ORDER_DATE,'dd/mm/yy')||
',DelDate:'||TO_CHAR(OM.DELIVERY_DATE,'dd/mm/yy') SALE_ORDER_DESC
FROM SALE_ORDER_MST OM,COMPANY C,CUSTOMER CU,SALE_ORDER_dtl od
WHERE OM.COMPANY_CODE = C.COMPANY_CODe(+)
and om.SALE_ORDER_NUMBER = od.SALE_ORDER_NUMBER
AND AUTHO_STATUS = 'Y'
AND OM.CUST_CODE=CU.CUSTOMER_CODE
and (om.SALE_ORDER_NUMBER,od.ITEM_CODE) in (
select SALE_ORDER_NUMBER,ITEM_CODE from ITEM_SO_DELIVERY_LEDGER
where nvl(DB_QNTY,0)<>nvl(CR_QNTY,0)
group by SALE_ORDER_NUMBER,ITEM_CODE
)