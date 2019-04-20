#!/bin/bash

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


function _main() {
      echo "Source Table - Min/Max"
      getSrcMinMax
      echo "Target Table - Min/Max"
      getTgtMinMax                
} #endFunction Main
#Program
_main
