#!/bin/bash

#variables
vPass=$1
vASHost=localhost
vASPort=$2
vExtName=$3
vGGAlias=SGGATE2

function _addExtract {
    curl -X POST \
    http://$vASHost:$vASPort/services/v2/extracts/$vExtName \
    --user "oggadmin:"$vPass   \
    -H 'Cache-Control: no-cache' \
    -d '{
        "description":"Integrated Extract",
        "config":[
            "Extract     '$vExtName'",
            "ExtTrail    bb",
            "UseridAlias '$vGGAlias'",
            "TRANLOGOPTIONS EXCLUDETAG 182",
            "sourcecatalog oggoow182;",
            "table soe.addresses;",
            "table soe.customers;",
            "table soe.orders;",
            "table soe.order_items;",
            "table soe.card_details;",
            "table soe.logon;",
            "table soe.product_information;",
            "table soe.inventories;",
            "table soe.product_descriptions;",
            "table soe.warehouses;",
            "table soe.orderentry_metadata;"
        ],
        "source":{
            "tranlogs":"integrated"
        },
        "credentials":{
            "alias":"'$vGGAlias'"
        },
        "registration":{
            "containers": [ "oggoow182" ],
            "optimized":false
        },
        "begin":"now",
        "targets":[
            {
                "name":"bb",
                "sizeMB":250
            }
        ],
        "status":"stopped"
    }' | python -mjson.tool
}

function _main {
     _addExtract
}

_main

