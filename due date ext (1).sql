UPDATE 
BC_BILL_CYCLE_CODE 
SET BILL_DUE_DATE='21-JULY-2014' 
WHERE SUBSTR(AREA_CODE,4)=:bg and location_code=:loc 
AND bill_cycle_code=:p_bill_cycle