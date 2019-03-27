#!/bin/bash

#variables
ORADATA_HOME=/opt/app/oracle/oradata/ORCL

sqlplus / as sysdba << EOF
alter pluggable database oggoow182 close immediate;
drop pluggable database oggoow182 including datafiles;

col con_id format 9999999999
col name format A10
col name format A10
col create_scn format 999999999999999
select con_id, name, open_mode,create_scn from v\$pdbs;

exit;
EOF

echo "Building directory structure"
rm -rf $ORADATA_HOME/oggoow182