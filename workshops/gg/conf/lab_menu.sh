#!/bin/bash
SCRIPTS=/home/oracle/LabPrep
txtred=$(tput setaf 1) #RED
txtgreen=$(tput setaf 2) #GREEN
txtst=$(tput sgr0) #Reset
while :
do
        clear
        echo "${txtred}*****************************************************************"
        echo "* Oracle GoldenGate Lab Prep					*"
        echo "*****************************************************************"
	echo "${txtgreen}* NOTE: Lab 1 (Install and Config) must be done first.	        *"
	echo "* [1] Lab 1 Complete Install (Automated Full Lab 1 Install)	*"
        echo "${txtred}* [2] Lab 2: (Zero Downtime Configuration)		        *"	
        echo "* [3] Lab 3: (Uni-Directional DML and DDL Replication)          *"
	echo "* [4] Lab 4: (12c Features and CDR)				*"
        echo "* [5] Lab 5: (Heterogeneous Replication - Oracle Prep)		*"
	echo "${txtgreen}* NOTE: MySQL Prep must be done as root                         *"        
        echo "${txtred}* [6] Lab 5: (Heterogeneous Replication - MySQL Prep)	        *"
        echo "* [7] Lab 6: Data Transformations                               *"
        echo "*                                                       	*"
	echo "* [0] Exit/Stop                                         	*"
        echo "****************************************************************"
        echo -n "Enter your menu choice [0-7]: "
	echo -n "${txtst}"
        read yourch

        case $yourch in
                1) $SCRIPTS/Lab1/Lab1_Complete_Install.sh; sleep 3 ;;                
                2) $SCRIPTS/Lab2/prep_ogg.sh 2; sleep 3 ;;
                3) $SCRIPTS/Lab3/prep_ogg.sh 3; sleep 3 ;;
                4) $SCRIPTS/Lab4/prep_ogg.sh 4; sleep 3 ;;
                5) $SCRIPTS/Lab5/prep_ogg.sh 5; sleep 3 ;;                
                6) $SCRIPTS/Lab5/prep_mysql.sh; sleep 3 ;;
                7) $SCRIPTS/Lab6/prep_ogg.sh 6; sleep 3 ;;
                0) exit 0;;
		*) echo "Oops!!! Please select choice 1 - 6 or 0";
                echo "Press Enter to continue. . ." ; read ;;
        esac

done

