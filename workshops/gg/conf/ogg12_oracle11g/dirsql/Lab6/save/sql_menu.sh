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
        echo "*           SQL Menu Lab 5: Data Transformations                *"
        echo "*****************************************************************"
	echo "* [1] Generate Transactions (Oracle 11g)                        *"
	echo "* [2] Check Record Count on Source  (Oracle 11g)                *"
	echo "* [3] Check Record Count on Target  (Oracle 12g)                *"
        echo "*                                                               *"
	echo "* [0] Exit/Stop                                                 *"
        echo "*****************************************************************"
        echo -n "Enter your menu choice [0-3]: "
	echo -n "${txtst}"
        read yourch

        case $yourch in
            1) . /home/oracle/11g.env; sqlplus euro/euro @/u01/app/oracle/product/11gogg/dirsql/gentrans.sql; ;; 
            2) . /home/oracle/11g.env; sqlplus euro/euro @/u01/app/oracle/product/11gogg/dirsql/getcount.sql; ;; 
            3) . /home/oracle/12c.env; sqlplus amer/amer@orcl12c @/u01/app/oracle/product/12cogg/dirsql/getcount.sql; ;; 
            0) exit 0;;
            *) echo "Oops!!! Please select choice 0 - 3";;
        esac
            echo "Press Enter to continue. . ." ; read ;
done

