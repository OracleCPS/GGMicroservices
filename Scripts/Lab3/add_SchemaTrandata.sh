#!/bin/bash

#variables
vPass=$1
vASHost=localhost
vASPort=$2
vGGAlias=SGGATE

function _addSchemaTrandata {
        curl -X POST \
        http://$vASHost:$vASPort/services/v2/connections/OracleGoldenGate.$vGGAlias/trandata/schema \
        --user "oggadmin:"$vPass   \
        -H 'Cache-Control: no-cache' \
        -d '{
            "operation":"add",
            "schemaName":"oggoow181.soe"
        }' | python -mjson.tool
}

function _main {
     _addSchemaTrandata
}

_main

