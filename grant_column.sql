https://stackoverflow.com/questions/14462353/grant-alter-on-only-one-column-in-table


grant update (ename) on emp to xyz;
Syntax:

grant update(column-name) on table-name to user-name


grant select on emp to xyz with grant option;

grant update (ename),insert (empno, ename)  on emp to xyz;


grant update (WALK_SEQ) on BC_METER_READING_CARD_DTL to SBU



