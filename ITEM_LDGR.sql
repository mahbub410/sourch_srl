SELECT I.ITEM_DESC,I.ITEM_PART_NO,I.ITEM_CODE,'Room-'||L.LOC_DESC ||',Rack-'||R.RACK_DESC ||',Bin-'||B.BIN_DESC  AS ITEM_LOCATION,M.MSR_UNIT_DESC AS MEASURE_UNIT 
FROM ST_ITEM_LEDGER IL, ST_ITEM_MST I,ST_LOCATION L,ST_RACK R,ST_BIN B,SFS.MEASURE_UNIT M
WHERE IL.ITEM_CODE=I.ITEM_CODE
AND IL.LOCATION=L.LOC_CODE
AND IL.RACK_CODE=R.RACK_CODE
AND IL.BIN_CODE=B.BIN_CODE
AND IL.MSR_UNIT_CODE=M.MSR_UNIT_CODE