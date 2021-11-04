#!/bin/bash
sleep 5
cd /home/oracle/OGG181_WHKSHP/Clear/
./stop_replication.sh Welcome1 16001 EXT1 16002 SOE2SOE1 17001 REP1
cd /home/oracle/OGG181_WHKSHP/Lab9/Reset/db
./clone_pdb_reset.sh
./clone_pdb_181.sh
./clone_pdb_182.sh 
cd /home/oracle/OGG181_WHKSHP/Clear/Reset/gg
./delete_deployment.sh Atlanta Welcome1 16000 16001 16002 16003 16004 16005
sleep 5
./delete_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005
