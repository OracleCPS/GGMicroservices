#!/bin/bash


function _initReplicat() {
#Replicat
  curl -X POST \
  http://localhost:17001/services/v2/replicats/RLOAD \
  --user "oggadmin:"Welcome1  \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
    "description": "Create an initial load replicat - File Based",
    "checkpoint": {
        "table": "ggate.checkpoints"
    } ,
    "config": [
        "Replicat RLOAD",
        "UseridAlias TGGATE",
        "sourcecatalog OGGOOW182;",
        "Map OGGOOW181.SOE.CUSTOMERS, Target SOE.CUSTOMERS;",
        "Map OGGOOW181.SOE.ADDRESSES, Target SOE.ADDRESSES;",
        "Map OGGOOW181.SOE.CARD_DETAILS, Target SOE.CARD_DETAILS;",
        "Map OGGOOW181.SOE.WAREHOUSES, Target SOE.WAREHOUSES;",
        "Map OGGOOW181.SOE.ORDERS, Target SOE.ORDERS;",
        "Map OGGOOW181.SOE.PRODUCT_INFORMATION, Target SOE.PRODUCT_INFORMATION;",
        "Map OGGOOW181.SOE.LOGON, Target SOE.LOGON;",
        "Map OGGOOW181.SOE.PRODUCT_DESCRIPTIONS, Target SOE.PRODUCT_DESCRIPTIONS;",
        "Map OGGOOW181.SOE.ORDERENTRY_METADATA, Target SOE.ORDERENTRY_METADATA;",
        "Map OGGOOW181.SOE.ORDER_ITEMS, Target SOE.ORDER_ITEMS;",
        "Map OGGOOW181.SOE.INVENTORIES, Target SOE.INVENTORIES;"
    ],
    "credentials": {
        "alias": "TGGATE"
    },
    "mode": {
        "parallel": false,
        "type": "nonintegrated"
    },
    "registration": "none",
    "source": {
        "name": "CB"
    },
    "status": "running"
}' | python -mjson.tool
}

function _stopReplicat(){
     curl -X POST \
       http://localhost:17001/services/v2/commands/execute \
       --user "oggadmin:"Welcome1  \
       -H 'Cache-Control: no-cache' \
       -d '{
                "name":"stop",
                "processName":"RLOAD",
                "processType":"replicat"
            }' | python -mjson.tool
}

function _delReplicat(){
     curl -X DELETE \
       http://localhost:17001/services/v2/replicats/RLOAD \
       --user "oggadmin:"Welcome1  \
       -H 'Cache-Control: no-cache' | python -mjson.tool
}

function _initDistroPath() {
#DistroPath
     curl -X POST \
       http://localhost:16002/services/v2/sources/INITLOAD \
       --user "oggadmin:"Welcome1  \
       -H 'Cache-Control: no-cache' \
       -d '{
         "name": "INITLOAD",
         "status": "running",
         "source": {
             "uri": "trail://localhost:16002/services/v2/sources?trail=CA"
         },
         "target": {
             "uri": "ws://OracleGoldenGate+WSTARGET@localhost:17003/services/v2/targets?trail=CB"
         }
     }' | python -mjson.tool
}

function _stopDistroPath(){
 curl -X PATCH \
  http://localhost:16002/services/v2/sources/INITLOAD \
  --user "oggadmin:"Welcome1  \
  -H 'Cache-Control: no-cache' \
  -d '{
        "status":"stopped"
    }' | python -mjson.tool
}

function _delDistroPath(){
     curl -X DELETE \
       http://localhost:16002/services/v2/sources/INITLOAD \
       --user "oggadmin:"Welcome1  \
       -H 'Cache-Control: no-cache' \
       -d '{
              "distpath":"INITLOAD"
            }' | python -mjson.tool
}

function _initExtract() {
#Extract
curl -X POST \
  http://localhost:16001/services/v2/extracts/LOAD \
  --user "oggadmin:"Welcome1  \
  -H 'Cache-Control: no-cache' \
  -d '{
          "description": "Create an initial load extract - File Based",
          "config":
              [
                  "Extract LOAD",
                    "UseridAlias SGGATE",
                                        "ExtFile CA ",
                                        "sourcecatalog OGGOOW181",
                                        "Table SOE.CUSTOMERS;",
                                        "Table SOE.ADDRESSES;",
                                        "Table SOE.CARD_DETAILS;",
                                        "Table SOE.WAREHOUSES;",
                                        "Table SOE.ORDERS;",
                                        "Table SOE.PRODUCT_INFORMATION;",
                                        "Table SOE.LOGON;",
                                        "Table SOE.PRODUCT_DESCRIPTIONS;",
                                        "Table SOE.ORDERENTRY_METADATA;",
                                        "Table SOE.ORDER_ITEMS;",
                                        "Table SOE.INVENTORIES;"
              ],
              "source": "tables",
              "status": "running"
          }' | python -mjson.tool
}

function _startExtract(){
      curl -X POST \
      http://localhost:16001/services/v2/commands/execute \
      --user "oggadmin:"Welcome1  \
      -H 'Cache-Control: no-cache' \
      -d '{
            "name":"start",
            "processName":"LOAD",
            "processType":"extract"
          }' | python -mjson.tool
}

function _stopExtract(){
      curl -X POST \
      http://localhost:16001/services/v2/commands/execute \
      --user "oggadmin:"Welcome1  \
      -H 'Cache-Control: no-cache' \
      -d '{
              "name":"stop",
              "processName":"LOAD",
              "processType":"extract"
          }' | python -mjson.tool
}

function _delExtract(){
  curl -X DELETE \
  http://localhost:16001/services/v2/extracts/LOAD \
  --user "oggadmin:"Welcome1  \
  -H 'Cache-Control: no-cache' | python -mjson.tool
}

function getSrcMinMax(){
    local SrcMinMax=$(echo "set feed off
    set pages 0
    select 'source CUSTOMERS            table -> '|| nvl(count(1),0) from SOE.CUSTOMERS;
        select 'source ADDRESSES            table -> '|| nvl(count(1),0) from SOE.ADDRESSES;
        select 'source CARD_DETAILS         table -> '|| nvl(count(1),0) from SOE.CARD_DETAILS;
        select 'source WAREHOUSES           table -> '|| nvl(count(1),0) from SOE.WAREHOUSES;
        select 'source ORDERS               table -> '|| nvl(count(1),0) from SOE.ORDERS;
        select 'source PRODUCT_INFORMATION  table -> '|| nvl(count(1),0) from SOE.PRODUCT_INFORMATION;
        select 'source LOGON                table -> '|| nvl(count(1),0) from SOE.LOGON;
        select 'source PRODUCT_DESCRIPTIONS table -> '|| nvl(count(1),0) from SOE.PRODUCT_DESCRIPTIONS;
        select 'source ORDERENTRY_METADATA  table -> '|| nvl(count(1),0) from SOE.ORDERENTRY_METADATA;
        select 'source ORDER_ITEMS          table -> '|| nvl(count(1),0) from SOE.ORDER_ITEMS;
        select 'source INVENTORIES          table -> '|| nvl(count(1),0) from SOE.INVENTORIES;
    exit" | sqlplus -s system/Welcome1@//localhost:1521/OGGOOW181.oracle.com
    )
    echo $SrcMinMax
}

function getTgtMinMax(){
    local TgtMinMax=$(echo "set feed off
    set pages 0
   select 'target CUSTOMERS            table -> '|| nvl(count(1),0) from SOE.CUSTOMERS;
        select 'target ADDRESSES            table -> '|| nvl(count(1),0) from SOE.ADDRESSES;
        select 'target CARD_DETAILS         table -> '|| nvl(count(1),0) from SOE.CARD_DETAILS;
        select 'target WAREHOUSES           table -> '|| nvl(count(1),0) from SOE.WAREHOUSES;
        select 'target ORDERS               table -> '|| nvl(count(1),0) from SOE.ORDERS;
        select 'target PRODUCT_INFORMATION  table -> '|| nvl(count(1),0) from SOE.PRODUCT_INFORMATION;
        select 'target LOGON                table -> '|| nvl(count(1),0) from SOE.LOGON;
        select 'target PRODUCT_DESCRIPTIONS table -> '|| nvl(count(1),0) from SOE.PRODUCT_DESCRIPTIONS;
        select 'target ORDERENTRY_METADATA  table -> '|| nvl(count(1),0) from SOE.ORDERENTRY_METADATA;
        select 'target ORDER_ITEMS          table -> '|| nvl(count(1),0) from SOE.ORDER_ITEMS;
        select 'target INVENTORIES          table -> '|| nvl(count(1),0) from SOE.INVENTORIES;
        exit" | sqlplus -s system/Welcome1@//localhost:1521/OGGOOW182.oracle.com
    )
    echo $TgtMinMax
}

function _removeProcess(){
  _delExtract
  sleep 5
  _delDistroPath
  sleep 5
  _delReplicat
}

function _main() {
	v_result=$?
	if [ $v_result -eq 0 ];
		then            
			echo "Build Initial Load Replicat"
			_initReplicat
			if [ $v_result -eq 0 ]
				then
					echo "Initial Load Replicat Built"
					echo "Build Initial Load Path"
					_initDistroPath
					if [ $v_result -eq 0 ]
						then
							echo "Initial Load Path Built"
							echo "Build Initial Load Extract"
							_initExtract
							if [ $v_result -eq 0 ];
								then
									echo "Initial Load Extract Built"
								else
									echo "Failed to run : _initExtract"
							fi #endif - _initExtract
						else
							echo "Failed to run : _initDistroPath"
					fi #endif - _initDistroPath
				else
					echo "Failed to run : _initReplicat"
			fi #endif - _initReplicat
	fi #endif
} #endFunction Main
#Program - Call Main
_main
