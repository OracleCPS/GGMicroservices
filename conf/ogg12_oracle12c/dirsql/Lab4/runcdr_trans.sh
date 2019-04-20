# runcdr_trans.sh
# Run CDR Lab Transactions against both 11g and 12c databases.

# Source Oracle 12c
source /home/oracle/12c.env

# Run gentrans.sql against amer schema on 12c database
sqlplus amer/amer @$SQL/gentrans.sql

# Source Oracle 11g
source /home/oracle/11g.env

# Run gentrans.sql against euro schema on 11g database
sqlplus euro/euro @$SQL/gentrans.sql

echo "Transaction run Complete"

