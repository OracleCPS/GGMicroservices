prompt
accept username prompt 'Enter user to grant access to : '
prompt

GRANT SELECT ON v_$sql_plan TO &username;

GRANT SELECT ON gv_$sql TO &username;

GRANT SELECT ON v_$session TO &username;

GRANT SELECT ON V_$SQL_PLAN_STATISTICS_ALL TO &username;


