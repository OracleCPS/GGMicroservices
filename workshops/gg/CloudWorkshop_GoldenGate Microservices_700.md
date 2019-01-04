![](images/700/Lab700_image100.PNG)

Update January 04, 2019

## GoldenGate Micro services Heterogeneous Replication
## Introduction

In this lab, you will take a look at how to set up replication from MySQL DB to Oracle Database using Classic Goldengate for MySQL and Goldengate Micro services architecture.

This lab supports the following use cases:
-	Seting up goldengate for MySQL .
-	Setting up Replication in Goldengate Micro services architecture for Oracle PDB ( OGGOOW182 ).

## Objectives

In this lab, you will create a classic GoldenGate architecture capture process (Extract) for MySQL and a Microservices delivery process (Replicat) to receive the data.  While MySQL isn’t supported as a deployment option for Microservices yet, you can still connect to existing Classic GoldenGate instances to replicate data.

## Required Artifacts

#Steps A: MySQL Setup

GoldenGate for MySQL is already installed on the Ravello image.  You will be using another terminal session to run the MySQL transactions and GoldenGate processes

1. Open a Terminal window from the VNC Console (Figure 8-1).

Right mouse click -> Open Terminal

2. Change the environment variable for the GoldenGate home.

        $ export OGG_HOME=/opt/app/oracle/product/18.1.0_GGMySQL


3. Change to the MySQL GG home.

        $ cd $OGG_HOME


4. Run the GoldenGate command interpreter (GGSCI).

        $./ggsci

5. Start the manager and check with info all command

        $GGSCI> start MGR

        $GGSCI> info all

![](images/700/Lab700_image101.png)

6. Run the OGG obey script to create the replication processes and check with info all command

        $OGG Atlanta_1 3>obey ./dirprm/setup_mysql.oby

![](images/700/Lab700_image102.png)

#Steps B: Microservices Setup

1. Use the web UI for the Administration Service of the SanFran Deployment (http://<hostname>:17001).

a.  Open a new browser tab and connect to http://<hostname>:17001 
b.  Login with the following oggadmin/Welcome1
c.  On the Overview page click the plus sign (+) opposite the Replicat status.

![](images/700/Lab700_image103.png)

2. On the next page click “Next” to create an Integrated Replicat.

![](images/700/Lab700_image104.png)

3. Fill in the required parameters (See Screenshot).  Then click “Next”.

![](images/700/Lab700_image105.png)

4. The next page will show the parameter file.  Keep the default for now and click “Create”.

![](images/700/Lab700_image106.png)

5. The replicat will be running , It might fail if you have not started the Pump process on the Mysql side

![](images/700/Lab700_image107.png)

#Steps C: Loading Data and validating the setup

1. Start MySql Goldengate Process

![](images/700/Lab700_image108.png)

2. Load the data in Mysql DB with the script present at /home/oracle/OGG181_WHKSHP/Lab7/MySQL/dirsql

![](images/700/Lab700_image109.png)

![](images/700/Lab700_image110.png)

3. It will take couple minutes to load the data. After that We can see the statstics in the extract report file

![](images/700/Lab700_image111.png)

4. Below is the statstics in the Replicat side

![](images/700/Lab700_image112.png)

5. Count of the tables of Mysql DB

![](images/700/Lab700_image113.png)

5. Count of the tables of Oracle DB

![](images/700/Lab700_image114.png)

You have completed lab 700!   **Great Job!**