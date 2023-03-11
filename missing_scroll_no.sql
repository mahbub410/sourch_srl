where batch_no='238266'

SELECT 0 AS GAP_START, MIN(SCROLL_NO) AS GAP_END
FROM EPAY_PAYMENT_DTL
where batch_no='238266'
HAVING MIN(SCROLL_NO) < 1


select min_a - 1 + level
     from ( select min(SCROLL_NO) min_a
                 , max(SCROLL_NO) max_a
              from EPAY_PAYMENT_DTL where batch_no='238266'
          )
  connect by level <= max_a - min_a + 1
 minus
select SCROLL_NO
from EPAY_PAYMENT_DTL
where batch_no='238266'