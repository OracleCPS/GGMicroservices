#!/bin/bash
cd /home/oracle/OGG181_WHKSHP/Lab6/Reset/db
./clone_pdb_reset.sh
./clone_pdb_181.sh
./clone_pdb_182.sh 
cd /home/oracle/OGG181_WHKSHP/Lab6/Reset/gg
#./delete_deployment.sh Atlanta Welcome1 16000 16001 16002 16003 16004 16005
#./delete_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
cd /home/oracle/OGG181_WHKSHP/Lab6/Build
sleep 30
#./create_deployment.sh Atlanta Welcome1 16000 16001 16002 16003 16004 16005
#./create_credential_GGAlias.sh Welcome1 16001 c##ggate@orcl ggate SGGATE1
#./create_credential_Protcol.sh Welcome1 16001 oggadmin Welcome1 WSTARGET1
#./create_credential_GGAlias.sh Welcome1 16001 ggate@oggoow181 ggate TGGATE1
sleep 30
./add_SchemaTrandata_181.sh Welcome1 16001
./add_CheckpointTable.sh Welcome1 16001 OracleGoldenGate.TGGATE1
./add_Extract1.sh Welcome1 16001 EXTSOE1
sleep 15
./add_DistroPath1.sh Welcome1 16002 SOE2SOE1 aa 17003 ab
sleep 15
./add_Replicat1.sh Welcome1 16001 IREP1
sleep 15
#./create_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
#./create_credential_GGAlias.sh Welcome1 17001 c##ggate@orcl ggate SGGATE2
#./create_credential_Protcol.sh Welcome1 17001 oggadmin Welcome1 WSTARGET2
#./create_credential_GGAlias.sh Welcome1 17001 ggate@oggoow182 ggate TGGATE2
sleep 30
./add_SchemaTrandata_182.sh Welcome1 17001
./add_CheckpointTable.sh Welcome1 17001 OracleGoldenGate.TGGATE2
sleep 15
./add_Extract2.sh Welcome1 17001 EXTSOE2
sleep 15
./add_DistroPath2.sh Welcome1 17002 SOE2SOE2 bb 16003 ba
sleep 15
./add_Replicat2.sh Welcome1 17001 IREP2
sleep 20

