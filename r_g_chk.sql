

SELECT FLAG_DESC,COUNT(*) FROM VW_EPAY_RECON_UNSUC_OPT_ROBI
GROUP BY FLAG_DESC

Not Reconciled    116
Not Import    525
Reconciled Process Runing    9
Reconciled Error    1

SELECT FLAG_DESC,COUNT(*) FROM VW_EPAY_RECON_UNSUC_OPT_GP
GROUP BY FLAG_DESC

Not Reconciled    2
Reconciled Error    7