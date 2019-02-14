#!/bin/bash

#variables
vPass=$1
vDSHost=localhost
vDSPort=$2
vPathName=$3
vSrcTrail=$4
vRSHost=localhost
vRSPort=$5
vTgtTrail=$6

function _addDistoPath {
    curl -X POST \
    http://$vDSHost:$vDSPort/services/v2/sources/$vPathName \
    --user "oggadmin:"$vPass   \
    -H 'Cache-Control: no-cache' \
    -d '{
        "name": "'$vPathName'",
        "status": "stopped",
        "source": {
            "uri": "trail://'$vDSHost':'$vDSPort'/services/v2/sources?trail='$vSrcTrail'"
        },
        "target": {
            "uri": "ws://OracleGoldenGate+WSTARGET@'$vRSHost':'$vRSPort'/services/v2/targets?trail='$vTgtTrail'"
        }
    }' | python -mjson.tool
}

function _main {
     _addDistoPath
}

_main

