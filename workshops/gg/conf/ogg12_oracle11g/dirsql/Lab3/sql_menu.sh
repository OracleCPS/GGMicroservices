#!/bin/bash
txtred=$(tput setaf 1) #RED
txtgreen=$(tput setaf 2) #GREEN
txtst=$(tput sgr0) #Reset
#clear
while :
do
clear
        echo "                                                                 "
        echo "*****************************************************************"
        echo "*        SQL Menu Lab 3: Uni-Directional DML and DDL            *"
        echo "*****************************************************************"
	echo "* [1] Generate Transactions (Oracle 12c)                        *"
	echo "* [2] Check Data on Source  (Oracle 12c)                        *"
	echo "* [3] Check Data on Target  (Oracle 11g)                        *"
	echo "* [4] Execute DDL on Source (Oracle 12c)                        *"
	echo "* [5] Check DDL on Source   (Oracle 12c)                        *"
	echo "* [6] Check DDL on Target   (Oracle 11g)                        *"
        echo "*                                                               *"
	echo "* [0] Exit/Stop                                                 *"
        echo "*****************************************************************"
        echo -n "Enter your menu choice [0-6]: "
	echo -n "${txtst}"
        read yourch

        case $yourch in
            1) . /home/oracle/12c.env; sqlplus amer/amer@orcl12c @/u01/app/oracle/product/12cogg/dirsql/gentrans.sql; ;; 
            2) . /home/oracle/12c.env; sqlplus amer/amer@orcl12c @/u01/app/oracle/product/12cogg/dirsql/getcount.sql; ;; 
            3) . /home/oracle/11g.env; sqlplus euro/euro @/u01/app/oracle/product/11gogg/dirsql/getcount.sql; ;; 
            4) . /home/oracle/12c.env; sqlplus amer/amer@orcl12c @/u01/app/oracle/product/12cogg/dirsql/ddl_changes.sql; ;; 
            5) . /home/oracle/12c.env; sqlplus amer/amer@orcl12c @/u01/app/oracle/product/12cogg/dirsql/describe.sql; ;; 
            6) . /home/oracle/11g.env; sqlplus euro/euro @/u01/app/oracle/product/11gogg/dirsql/describe.sql; ;; 
            0) exit 0;;
            *) echo "Oops!!! Please select choice 0 - 6";;
        esac
            echo "Press Enter to continue. . ." ; read ;
done

