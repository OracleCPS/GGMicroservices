#!/bin/bash

echo
echo "Remove AutoCDR from tables in database"
echo
echo

sqlplus / as sysdba << EOF
alter session set container=oggoow181;
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','addresses');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','customers');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','orders');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','order_items');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','card_details');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','product_information');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','inventories');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','product_descriptions');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','warehouses');

alter session set container=oggoow182;
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','addresses');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','customers');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','orders');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','order_items');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','card_details');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','product_information');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','inventories');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','product_descriptions');
exec DBMS_GOLDENGATE_ADM.REMOVE_AUTO_CDR('soe','warehouses');
exit;
EOF


echo
echo "Done removing AutoCDR"
echo
echo
