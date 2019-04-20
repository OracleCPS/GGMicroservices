#!/bin/bash

#Title: Edit TNSNames.ora

#variables
ORACLE_PDB=$1

echo "Updating tnsnames.ora"

cd $ORACLE_HOME/network/admin
cp ./tnsnames.ora ./tnsnames.ora.copy

echo '$ORACLE_PDB =
          (DESCRIPTION = 
            (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
            (CONNECT_DATA =
              (SERVER = DEDICATED)
              (SERVICE_NAME = $ORACLE_PDB.oracle.com)
            )
          )' >> ./tnsnames.ora

echo "Done updating tnsnames.ora"