#!/bin/bash

#variables
ORADATA_HOME=/opt/app/oracle/oradata/ORCL


#for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
#do

echo $1

sqlplus OGGMSALAB$1/Wel_Come#321@dipcadwc_low << EOF

truncate table OGGMSALAB$1.ACCOUNT; 
truncate table OGGMSALAB$1.ACCOUNT_TRANS;
truncate table OGGMSALAB$1.BRANCH;
truncate table OGGMSALAB$1.BRANCH_ATM;
truncate table OGGMSALAB$1.TELLER;
truncate table OGGMSALAB$1.TELLER_TRANS;
truncate table OGGMSALAB$1.TRANS_TYPE;
exit;

EOF

#done


echo "Truncated Target tables"
