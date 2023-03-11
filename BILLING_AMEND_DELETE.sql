
--insert into BC_AMEND_CONTROL_TEMP

SELECT * FROM BC_AMEND_CONTROL
WHERE CONSUMER_NUMBER=:P_CONSUMER_NUMBER
--AND SOURCE_FLAG='BC_BILCORR'


DELETE FROM BC_AMEND_ERROR_DTL
WHERE ERROR_ID IN (
            SELECT ERROR_ID FROM BC_AMEND_ERROR
            WHERE REF_ID IN (
                        SELECT REF_ID FROM BC_AMEND_CONTROL
                        WHERE CONSUMER_NUMBER=:P_CONSUMER_NUMBER
                        --AND SOURCE_FLAG='BC_MEXCINT'
                        )
)



DELETE FROM BC_AMEND_DESCRIPTION
WHERE ERROR_ID IN (
            SELECT ERROR_ID FROM BC_AMEND_ERROR
            WHERE REF_ID IN (
                        SELECT REF_ID FROM BC_AMEND_CONTROL
                        WHERE CONSUMER_NUMBER=:P_CONSUMER_NUMBER
                        AND SOURCE_FLAG='BC_MEXCINT'
                        )
)


DELETE FROM BC_AMEND_ERROR
WHERE REF_ID IN (
SELECT REF_ID FROM BC_AMEND_CONTROL
WHERE CONSUMER_NUMBER=:P_CONSUMER_NUMBER
AND SOURCE_FLAG='BC_MEXCINT'
)


DELETE FROM BC_AMEND_CONTROL
WHERE CONSUMER_NUMBER=:P_CONSUMER_NUMBER
AND SOURCE_FLAG='BC_MEXCINT'


COMMIT;