
SELECT b.org_code,
            b.org_br_code,
            a.bill_month,
            a.account_number,
            a.bill_number,
            org_bank_code,
            b.pay_date,
            ORG_PRN_AMOUNT + VAT_AMOUNT tot_pay,
            C.TOTAL_BILL_AMOUNT,
            c.bill_due_date
       FROM epay_payment_dtl a, epay_payment_mst b, epay_utility_bill c
      WHERE     a.batch_no = b.batch_no
            AND c.account_number = a.account_number
            AND TO_CHAR (ADD_MONTHS (TO_DATE (a.bill_month, 'RRRRMM'), 1),
                         'RRRRMM') = c.bill_month
            AND C.TOTAL_BILL_AMOUNT > (ORG_PRN_AMOUNT + VAT_AMOUNT) * 2
--     AND c.location_code='201'
--       and  b.org_bank_code ='03'
            AND a.bill_month = 201711
   ORDER BY 1, 3 DESC, 2;
