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
        echo "*        SQL Menu Lab 5: Hetrogeneous Replication               *"
        echo "*****************************************************************"
	echo "* [1] Generate Transactions (MySQL 5.6)                         *"
	echo "* [2] Check Data on Source  (MySQL 5.6)                         *"
	echo "* [3] Check Data on Target  (Oracle 12c)                        *"
        echo "*                                                               *"
	echo "* [0] Exit/Stop                                                 *"
        echo "*****************************************************************"
        echo -n "Enter your menu choice [0-3]: "
	echo -n "${txtst}"
        read yourch

        case $yourch in
            1) . /home/oracle/mysql.env; sudo mysql -u amea -pamea < $SQL/trans_generator.sql ;;
            2) . /home/oracle/mysql.env; sudo mysql -u amea -pamea < $SQL/counts.sql; ;; 
            3) . /home/oracle/12c.env; sqlplus amer/amer@orcl12c @$GG/dirsql/getcount.sql; ;; 
            0) exit 0;;
            *) echo "Oops!!! Please select choice 0 - 3";;
        esac
            echo "Press Enter to continue. . ." ; read ;
done


