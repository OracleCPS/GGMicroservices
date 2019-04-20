# showsample.sh.sh
# Show samples of transformed data .
echo off
# Source Oracle 11g
source /home/oracle/11g.env

echo "Source 11G Tables"
echo "---------------------------------------------------------------------------------------"
sqlplus euro/euro @/u01/app/oracle/product/11gogg/dirsql/showsample.sql
echo "---------------------------------------------------------------------------------------"

# Source Oracle 12c
source /home/oracle/12c.env

echo "Target 12c Tables"

echo "---------------------------------------------------------------------------------------"
sqlplus amer/amer@orcl12c @/u01/app/oracle/product/12cogg/dirsql/showsample.sql
echo "---------------------------------------------------------------------------------------"
