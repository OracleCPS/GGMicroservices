#!/bin/bash

#variables
ORADATA_HOME=/opt/app/oracle/oradata/ORCL

echo $ORACLE_HOME
echo "Building directory structure"
mkdir -p $ORADATA_HOME/oggoow182

echo
echo "Cloning Pluggable Database"
echo
echo

sqlplus / as sysdba << EOF
col con_id format 9999999999
col name format A10
col name format A10
col create_scn format 999999999999999
select con_id, name, open_mode,create_scn from v\$pdbs;

alter pluggable database oggoow181 close immediate;
alter pluggable database oggoow181 open read only;

create pluggable database oggoow182 from oggoow181 file_name_convert = ('$ORADATA_HOME/oggoow181','$ORADATA_HOME/oggoow182');
alter pluggable database oggoow182 open;

alter session set container=cdb$root;
alter pluggable database oggoow181 close immediate;
alter pluggable database oggoow181 open;

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
