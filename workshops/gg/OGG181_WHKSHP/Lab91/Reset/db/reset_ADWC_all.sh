#!/bin/bash

#variables
ORADATA_HOME=/opt/app/oracle/oradata/ORCL


for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
do

echo i

sqlplus OGGMSALAB$i/Wel_Come#321@dipcadwc_low << EOF

truncate table OGGMSALAB$i.ACCOUNT; 
truncate table OGGMSALAB$i.ACCOUNT_TRANS;
truncate table OGGMSALAB$i.BRANCH;
truncate table OGGMSALAB$i.BRANCH_ATM;
truncate table OGGMSALAB$i.TELLER;
truncate table OGGMSALAB$i.TELLER_TRANS;
truncate table OGGMSALAB$i.TRANS_TYPE;
exit;

EOF

done

sleep 5
cd /home/oracle/OGG181_WHKSHP/Lab91/Build
./del_CheckpointTable.sh Welcome1 17001 OracleGoldenGate.GGADMIN
./add_CheckpointTable.sh Welcome1 17001 OracleGoldenGate.GGADMIN



echo "Truncated Target tables"
