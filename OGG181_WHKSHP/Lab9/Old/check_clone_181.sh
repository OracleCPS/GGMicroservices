#!/bin/bash

echo "Check OGGOOW181 Database"

sqlplus / as sysdba << EOF
col con_id format 9999999999
col name format A10
col name format A10
col create_scn format 999999999999999
select con_id, name, open_mode,create_scn from v\$pdbs where name = 'OGGOOW181';

exit;
EOF

echo
echo "Done checking OGGOOW181 Database"
echo
echo
