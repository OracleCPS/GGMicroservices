#!/bin/bash

sqlplus / as sysdba << EOF
col con_id format 9999999999
col name format A10
col name format A10
col create_scn format 999999999999999
select con_id, name, open_mode,create_scn from v\$pdbs;

col con_id format 9999999999
col name format A10
col name format A10
col create_scn format 999999999999999
select con_id, name, open_mode,create_scn from v\$pdbs;
exit;
EOF

lsnrctl status

echo
echo "Done Cloning Pluggable Database"
echo
echo
