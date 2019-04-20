#!/bin/bash

#variables
ORADATA_HOME=/opt/app/oracle/oradata/ORCL

sqlplus / as sysdba << EOF
col con_id format 9999999999
col name format A10
col name format A10
col create_scn format 999999999999999
select con_id, name, open_mode,create_scn from v\$pdbs;

alter pluggable database oggoow181 close immediate;
drop pluggable database oggoow181 including datafiles;

alter pluggable database oggoow182 close immediate;
drop pluggable database oggoow182 including datafiles;

col con_id format 9999999999
col name format A10
col name format A10
col create_scn format 999999999999999
select con_id, name, open_mode,create_scn from v\$pdbs;

exit;
EOF

echo "Remove data directory structure"
rm -rf $ORADATA_HOME/oggoow181
rm -rf $ORADATA_HOME/oggoow182
