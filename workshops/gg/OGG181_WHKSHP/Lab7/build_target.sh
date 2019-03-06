#!/bin/bash

echo "Setup GoldenGate Target Environment"

cd /home/oracle/OGG181_WHKSHP/Lab6/Reset/gg
./delete_deployment.sh Atlanta Welcome1 16000 16001 16002 16003 16004 16005
sleep 5
./delete_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
sleep 5
cd /home/oracle/OGG181_WHKSHP/Lab6/Build
./create_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
sleep 5
./create_credential_GGAlias.sh Welcome1 17001 c##ggate@orcl ggate SGGATE
sleep 5
./create_credential_Protcol.sh Welcome1 17001 oggadmin Welcome1 WSTARGET
sleep 5
./create_credential_GGAlias.sh Welcome1 17001 ggate@oggoow182 ggate TGGATE
sleep 5
./add_CheckpointTable.sh Welcome1 17001 OracleGoldenGate.TGGATE

echo "Completed GoldenGate Target Environment"

