
SELECT O.OBJECT_NAME, S.SID, S.SERIAL#, P.SPID, S.PROGRAM,S.USERNAME,
S.MACHINE,S.PORT , S.LOGON_TIME,SQ.SQL_FULLTEXT 
FROM V$LOCKED_OBJECT L, DBA_OBJECTS O, V$SESSION S, 
V$PROCESS P, V$SQL SQ 
WHERE L.OBJECT_ID = O.OBJECT_ID 
AND L.SESSION_ID = S.SID AND S.PADDR = P.ADDR 
AND S.SQL_ADDRESS = SQ.ADDRESS;


====================================================

SELECT
    O.OBJECT_NAME,
    S.SID,
    S.SERIAL#,
    P.SPID,
    S.PROGRAM,
    SQ.SQL_FULLTEXT,
    S.LOGON_TIME
FROM
    V$LOCKED_OBJECT L,
    DBA_OBJECTS O,
    V$SESSION S,
    V$PROCESS P,
    V$SQL SQ
WHERE
    L.OBJECT_ID = O.OBJECT_ID
    AND L.SESSION_ID = S.SID
    AND S.PADDR = P.ADDR
    AND S.SQL_ADDRESS = SQ.ADDRESS;
    
=====================================================

alter system kill session 'SID,SERIAL#';
(For example, alter system kill session '13,36543';)    