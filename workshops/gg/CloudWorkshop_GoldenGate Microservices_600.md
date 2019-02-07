![](images/600/Lab600_image100.PNG)

Update December 28, 2018

## Bi-Directional Replication, AutoCDR, Rapid Deployment and Intro to the Admin Client
## Introduction

Since we’ve already done multiple labs, this one will take what we used so far to script this using DB container reset scripts, SQL scripts to setup AutoCDR in the database, OGGCA silent deployment scripts and GG REST API scripts to do a rapid deployment.

## Objectives

-	Rapid Deployment using:
    -   OGGCA silent deployment scripts (drop and recreate deployments).
    -   REST API to setup bi-directional GoldenGate replication between two databases.
    -	SQL Scripts to setup up auto conflict detection and resolution in the database.

## Required Artifacts

-   VNC Client for the deployment.
-	Browser to check the deployment.
-   Swingbench to apply transactions.

### **STEP 1**: Run a script to perform a rapid deployment.

-   Open up a terminal window and change directory to Lab6 and Review script build_all_bi_di.sh.

-   This script performs the following:
        1.	Drops the existing container databases.
        2.	Clones two container databases from a base container.
        3.	Deletes the two deployments (Atlanta and SanFran).  This will remove any current lab setups.
        4.	Creates the two deployments again.
        5.	Creates new credentials for both deployments.
        6.	Adds Schema supplemental logging to both container databases for the SOE schema.
        7.	Adds checkpoint tables on both container databases.
        8.	Adds the Extract, Distribution Path and Replicat for both deployments.  This includes the correct parameters for the Extract and Replicats

-   Run the build_all_bi_di.sh script.


### **STEP 2**: Add AutoCDR to tables in the database.

When more than one replica of a table allows changes to the table, a conflict can occur when a change is made to the same row in two different databases at nearly the same time. Oracle GoldenGate replicates changes using the row LCRs. 
It detects a conflict by comparing the old values in the row LCR for the initial change from the origin database with the current values of the corresponding table row at the destination database identified by the key columns. 
If any column value does not match, then there is a conflict.
After a conflict is detected, Oracle GoldenGate can resolve the conflict by overwriting values in the row with some values from the row LCR, ignoring the values in the row LCR, or computing a delta to update the row values.

Automatic conflict detection and resolution does not require application changes for the following reasons:
    •	Oracle Database automatically creates and maintains invisible timestamp columns.
    •	Inserts, updates, and deletes use the delete tombstone log table to determine if a row was deleted.
    •	LOB column conflicts can be detected.
    •	Oracle Database automatically configures supplemental logging on required columns.

This step runs the ADD_AUTO_CDR procedure in the DBMS_GOLDENGATE_ADM package in the database.

-   In the terminal window change directory to Lab6 and Review script setup_autocdr.sh.

This script performs the following:
    1.	Logs into the database.
    2.	Changes session to a container.
    3.	Executes the ADD_AUTO_CDR procedure in the DBMS_GOLDENGATE_ADM package.  This sets up the timestamp conflict detection and resolution.  You have to do this for any table you want to enable for CDR.  That’s why it’s best to have this scripted for multiple tables.

### **STEP 3**: Start Replication

-   In the terminal window change directory to Lab6 and run the check_clone.sh script.  This script will show the starting SCN values for the replication process startup.  Note the CREATE_SCN for both the OGGOOW181 and 182 container databases.
NOTE: The CREATE_SCN could be different than the screenshot, so use the values you have from running the script.

-   Run the start_replication.sh script to start the replication processes for the Atlanta capture and the SanFran delivery.  Use the CREATE SCN value from OGGOOW181 as the last value of the script.  This is for the startup of the Replicat on the SanFran deployment.

-   Next, run the start_replication.sh script again to start the replication processes for the SanFran capture and the Atlanta delivery.  Use the CREATE SCN value from OGGOOW182 as the last value of the script.  This is for the startup of the Replicat on the Atlanta deployment.

### **STEP 4**: Check using the AdminClient
This step will be a short introduction to the AdminClient.  If you’re familiar with Classic GoldenGate, this would be like using GGSCI.  However, the advantage with the AdminClient is that you can connect to separate GG deployments from this one interface.  With GGSCI you would need to execute it in each server environment where GG is installed.  

-   Change directory to OGG_HOME/bin and run adminclient.

-   Use connect command

            You’ll see an error that you have to specify the deployment name and it will give you a list of deployments.

-   Connect again using the deployment name of Atlanta.

-   Type in “help”.  You can scroll up and down the list.  For classic GG users you’ll see some familiar commands.

-   Type in “info all”.  You’ll see the services and their status and the replication processes and their status.

-   Type in "set debug on"

-   Type in "info all" again.


This time you'll see the JSON generated that you can use for the REST API.

-   Type in "set debug off"

-   Let’s type in a command that isn’t in classic GG.  Type in “health deployment Atlanta”.  You’ll get more info on the services than just the info all command gives.

-   Exit the AdminClient by typing in "exit".

### **STEP 5**: Run transactions and check conflicts with Performance Metric Service

In this step we’ll use a script to invoke Swingbench to apply data to both databases at the same time and then check them using the Performance Metric Service.

-   In the terminal window change directory to Lab6 and Review script start_swingbench.sh.

This script runs the swingbench jobs you ran in the other labs, but this time it will run two jobs in the background and each job applies data to one or the other databases.

-   Run start_swingbench.sh.

-   From the browser, log in to the Admin Service.  And click on the link to the Performance Metrics Server for Atlanta.
![](images/600/Lab600_image100.PNG)

-   Then click on the Replicat icon.

We’ll take a longer look at the Metric Service in another lab, so for now just click on the “Database Statistics” tab.

On this screen you’ll see the number of operations performed and their types and also the number of conflicts detected, and the number of conflicts resolved.  This is done automatically by the AutoCDR configuration.

If you want, you can check the Replicat of the other deployment and you’ll see a similar display.

You have completed lab 600! Great Job!