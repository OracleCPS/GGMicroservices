#!/bin/bash

#variables
vPass=$1
vASHost=localhost
vASPort=$2
vProtoUser=$3
vProtoPass=$4
vProtoAlias=$5

function _createAlias {
     curl -X POST \
       http://$vASHost:$vASPort/services/v2/credentials/OracleGoldenGate/$vProtoAlias \
       --user "oggadmin:"$vPass   \
       -H 'Cache-Control: no-cache' \
       -d '{
         "userid":"'$vProtoUser'",
         "password":"'$vProtoPass'"
     }'| python -mjson.tool
}

function _main {
     _createAlias
}

_main

