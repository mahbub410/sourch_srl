SELECT
  GRANTEE, GRANTED_ROLE
FROM
  DBA_ROLE_PRIVS
  where GRANTEE IN ('SBU','BPDB','BILLPAY','BILL')
  
  
    select * from DBA_TAB_PRIVS
where  owner in ('EBC','EMP')
and grantee in ('SBU','BPDB','BILL')