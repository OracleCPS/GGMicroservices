#!/bin/bash

#Variables
vDName=$1
vPass=$2
vSMPort=$3
vAMPort=$4
vDSPort=$5
vRSPort=$6
vPMSPort=$7
vPMSUDP=$8

cp ./oggca_deployment_add.rsp ./oggca_$vDName.rsp
sed -i -e "s|###NAME###|$vDName|g" ./oggca_$vDName.rsp
sed -i -e "s|###PASS###|$vPass|g" ./oggca_$vDName.rsp
sed -i -e "s|###SMPORT###|$vSMPort|g" ./oggca_$vDName.rsp
sed -i -e "s|###AMPORT###|$vAMPort|g" ./oggca_$vDName.rsp
sed -i -e "s|###DSPORT###|$vDSPort|g" ./oggca_$vDName.rsp
sed -i -e "s|###RSPORT###|$vRSPort|g" ./oggca_$vDName.rsp
sed -i -e "s|###PMSPORT###|$vPMSPort|g" ./oggca_$vDName.rsp
sed -i -e "s|###PMSPORTUDP###|$vPMSUDP|g" ./oggca_$vDName.rsp

cd $OGG_HOME/bin
./oggca.sh -silent -responseFile /home/oracle/OGG181_WHKSHP/Reset/oggca_$vDName.rsp

cd ~/OGG181_WHKSHP/Reset
rm -f ./oggca_$vDName.rsp

