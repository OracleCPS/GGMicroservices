#!/bin/bash
sleep 5
cd /home/oracle/OGG181_WHKSHP/Lab8/
./stop_replication.sh Welcome1 16001 EXT1 16002 SOE2SOE1 17001 REP1
cd /home/oracle/OGG181_WHKSHP/Lab8/Reset/db
./clone_pdb_reset.sh
./clone_pdb_181.sh
./clone_pdb_182.sh 
cd /home/oracle/OGG181_WHKSHP/Lab8/Reset/gg
./delete_deployment.sh Atlanta Welcome1 16000 16001 16002 16003 16004 16005
sleep 5
./delete_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
sleep 5
cd /home/oracle/OGG181_WHKSHP/Lab8/Build
./create_deployment.sh Atlanta Welcome1 16000 16001 16002 16003 16004 16005
sleep 5
./create_credential_GGAlias.sh Welcome1 16001 c##ggate@orcl ggate SGGATE1
sleep 5
./create_credential_Protcol.sh Welcome1 16001 oggadmin Welcome1 WSTARGET1
sleep 5
./create_credential_GGAlias.sh Welcome1 16001 ggate@oggoow181 ggate TGGATE1
sleep 5
./add_SchemaTrandata_181.sh Welcome1 16001
#sleep 5
#./add_CheckpointTable.sh Welcome1 16001 OracleGoldenGate.TGGATE1
sleep 5
./add_Extract1.sh Welcome1 16001 EXT1
sleep 5
./add_DistroPath1.sh Welcome1 16002 SOE2SOE1 aa 17003 ab
#sleep 5
#./add_Replicat1.sh Welcome1 16001 IREP1
sleep 5
./create_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
sleep 5
./create_credential_GGAlias.sh Welcome1 17001 c##ggate@orcl ggate SGGATE2
sleep 5
./create_credential_Protcol.sh Welcome1 17001 oggadmin Welcome1 WSTARGET2
sleep 5
./create_credential_GGAlias.sh Welcome1 17001 ggate@oggoow182 ggate TGGATE2
#sleep 5
#./add_SchemaTrandata_182.sh Welcome1 17001
sleep 5
./add_CheckpointTable.sh Welcome1 17001 OracleGoldenGate.TGGATE2
#sleep 5
#./add_Extract2.sh Welcome1 17001 EXTSOE2
#sleep 5
#./add_DistroPath2.sh Welcome1 17002 SOE2SOE2 bb 16003 ba
sleep 5
./add_Replicat2.sh Welcome1 17001 REP1
sleep 5
cd /home/oracle/OGG181_WHKSHP/Lab8/
./start_replication.sh Welcome1 16001 EXT1 16002 SOE2SOE1 17001 REP1