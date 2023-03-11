
                    
                    SELECT 'public string '||COLUMN_NAME||' { get; set; }' FROM ALL_TAB_COLUMNS
WHERE OWNER='SFS_STORE'
AND TABLE_NAME='X'
ORDER BY COLUMN_ID