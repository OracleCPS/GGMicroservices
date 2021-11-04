#!/bin/bash
cd /home/oracle/OGG181_WHKSHP/Reset
./create_deployment.sh Atlanta Welcome1 16000 16001 16002 16003 16004 16005
sleep 15
./create_credential_GGAlias.sh Welcome1 16001 c##ggate@orcl ggate SGGATE
sleep 15
./create_credential_Protcol.sh Welcome1 16001 oggadmin Welcome1 WSTARGET
sleep 15
./add_SchemaTrandata_181.sh Welcome1 16001
sleep 15
./create_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
sleep 15
./create_credential_GGAlias.sh Welcome1 17001 ggate@oggoow182 ggate TGGATE
sleep 15
./add_CheckpointTable.sh Welcome1 17001 OracleGoldenGate.TGGATE
