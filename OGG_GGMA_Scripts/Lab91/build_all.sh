#!/bin/bash
cd /home/oracle/OGG181_WHKSHP/Lab91/Reset/db
./clone_pdb_reset.sh
./clone_pdb_181.sh
./clone_pdb_182.sh 
cd /home/oracle/OGG181_WHKSHP/Lab91/Reset/gg
./delete_deployment.sh Atlanta Welcome1 16000 16001 16002 16003 16004 16005
sleep 5
./delete_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
sleep 5
sudo ./delete_mySQLGG.sh
sleep 5
cd /home/oracle/OGG181_WHKSHP/Lab91/Build
./create_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
sleep 5
./create_credential_GGAlias.sh Welcome1 17001 ggadmin@dipcadwc_low Wel_Come#321 GGADMIN
sleep 5
#./del_CheckpointTable.sh Welcome1 17001 OracleGoldenGate.GGADMIN
./add_CheckpointTable.sh Welcome1 17001 OracleGoldenGate.GGADMIN


echo "Completed GoldenGate Target Environment"
