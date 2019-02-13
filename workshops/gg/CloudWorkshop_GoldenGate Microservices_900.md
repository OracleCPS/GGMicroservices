![](images/900/Lab900_image100.PNG)

Update January 10, 2019

## GoldenGate Micro Services Performance Metrics

## Introduction

## Objective:

In this lab we will setup replication to be used to load data using Swingbench and also to view the replication in real time with the Metric Service.

We already have credentials setup for the two databases, but we don’t have transactional data setup for the Swingbench schema (SOE).  We will do that now:

### **STEP 1**: Refresh the databases.

In this step you will run several scripts.

-	If you don't have a terminal window opened yet, right click on the Desktop of the VNC session and select **Open Terminal**

![](images/common/open_terminal.png)

-   From the Terminal window in the VNC Console, navigate to the Reset directory under ~/OGG181_WHKSHP.

        $ cd ~/OGG181_WHKSHP/Reset

-   Run the **clone_pdb_reset.sh** script.  This script drops the source and target PDBs.

        [oracle@OGG181DB183 Reset]$ ./clone_pdb_reset.sh

-   Run the **clone_pdb_181.sh** script.  This script recreates the source by cloning a base PDB.

       [oracle@OGG181DB183 Reset]$ ./clone_pdb_181.sh

-   Run the **clone_pdb_182.sh** script.  This script recreates the target by cloning the source PDB.

        [oracle@OGG181DB183 Reset]$ ./clone_pdb_182.sh

### **STEP 2**: Add Supplimental Logging to the source database.

-       From the Terminal window in the VNC Console, navigate to the Lab9 directory under ~/OGG181_WHKSHP.

        $ cd ~/OGG181_WHKSHP/Lab9

-       From here you will run the script to add transactional data (trandata) to the schema which we want to replicate.  In order to do this, you will need to run the add_SchemaTrandata.sh script.  To run this script, you need to execute the following at the command line:

        $ ./add_SchemaTrandata.sh Welcome1 16001

Once the script is executed, you will see a statement saying that the “schematrandata” has been added to the setup.

![](images/900/Lab900_image110.PNG)

-       You can check to see if trandata has been added from the Administration Service Configuration page as well.  Simply login to the SGGATE alias.

![](images/900/Lab900_image120.PNG)

-       Then under “Trandata”, make sure that the magnifying glass is selected, the radio button for Schema selected.  Then enter “oggoow181.soe” into the text box.  Select the magnifying glass in the text box to perform the search.

![](images/900/Lab900_image130.PNG)

-       After the search is performed, you will see a table that provides a number of tables have trandata enabled on them for that schema.

![](images/900/Lab900_image140.PNG)

You have now completed configuring the schema that will be used in the replication process.


### **STEP 3**: Create an Extract and Distribution Path to be used for replication.  We will create these using scripts to use the RESTful API.

You will use the following two scripts to configure these processes:

        $ Add_Extract.sh
        $ Add_DistroPath.sh

-       If not there already, from the Terminal Window in the VNC Console, navigate to the Lab9 directory under ~/OGG181_WHKSHP.

        $ cd ~/OGG181_WHKSHP/Lab9

![](images/900/Lab900_image150.PNG) 

-       Next, to create the Extract you will run the add_Extract.sh script as follows:

    $ ./add_Extract.sh Welcome1 16001 EXTSOE

-       After the script has ran, you will see that the output for the script reports that the Extract was successfully created and can now view the new Extract from the Administration Service > Overview page.

![](images/900/Lab900_image160.PNG) 

![](images/900/Lab900_image170.PNG) 

Now you will create the Distribution Path that will be used to ship trail files from the Atlanta Deployment to the Boston Deployment. In order to do this, you will need to run the add_DistroPath.sh script.

        $ ./add_DistroPath.sh Welcome1 16002 SOE2SOE aa 17003 ab

The values used in the script correspond to the following:

        “Welcome1” = OGGADMIN user password
        “16002” = Atlanta Deployment’s Distribution Service port
        “SOE2SOE” = Distribution Path name
        “aa” = Atlanta Deployment’s source trail file name prefix
        “17003” = Boston Deployment’s Receiver Service port
        “ab” = Boston Deployment’s remote trail file prefix

When the Distribution Path has been added, you will see a message on the command line stating that it was added.

![](images/900/Lab900_image180.PNG) 

You will also see the path that is created in the Distribution Service.

-       From the ServiceManager webpage, click the link for the Atlanta Deployment’s Distribution Service or enter http://<hostname>:16002 from within the browser.

![](images/900/Lab900_image190.PNG) 

### **STEP 4**:  Add the checkpoint table.

Since the database was refreshed, there is no checkpoint table.  We will run a script to create it.

-       From the same terminal window run the script **add_CheckpointTable.sh**.

        [oracle@OGG181DB183 Lab9]$ ./add_CheckpointTable.sh Welcome1 17001 OracleGoldenGate.TGGATE

### **STEP 5**: Create the Replicat

In this Task, you will install the Replicat within the **SanFran** Deployment.  Credentials should be there from previous labs.

To begin this Task, follow the below steps:

From the same terminal window, While in the Lab9 directory, you will create the Replicat again with a script using the RESTful API.  The following is the script that you will run.
        $ add_Replicat.sh

-       Enter the following command to run the script:

    $  ./add_Replicat.sh Welcome1 17001 IREP

-       Once the script has completed, you should see output saying that the Replicat was added.

![](images/900/Lab900_image230.PNG)

-       After adding the Replicat, you can view it from the Boston Deployment’s Administration Service > Overview page.

![](images/900/Lab900_image240.PNG)

### **STEP 6**:  Check the cloned databases SCN

-   In the same terminal window run the check_clone.sh script.  This script will show the starting SCN values for the replication process startup.  Note the CREATE_SCN for the OGGOOW181 container database.
**NOTE: The CREATE_SCN could be different than the screenshot, so use the values you have from running the script.**

        [oracle@OGG181DB183 Lab9]$ ./check_clone.sh 

        SQL*Plus: Release 18.0.0.0.0 - Production on Thu Feb 7 22:45:58 2019
        Version 18.3.0.0.0

        Copyright (c) 1982, 2018, Oracle.  All rights reserved.


        Connected to:
        Oracle Database 18c Enterprise Edition Release 18.0.0.0.0 - Production
        Version 18.3.0.0.0

        SQL> SQL> SQL> SQL> SQL> 
        CON_ID NAME       OPEN_MODE	CREATE_SCN
        ----------- ---------- ---------- ----------------
                2 PDB$SEED   READ ONLY	   1507780
                3 OGGOOWBASE READ WRITE	   5459418
                5 OGGOOW181  READ WRITE	   8370692 <----- Use this value from running the script
                6 OGGOOW182  READ WRITE	   8372379 

        SQL> Disconnected from Oracle Database 18c Enterprise Edition Release 18.0.0.0.0 - Production
        Version 18.3.0.0.0

-       Notice the CREATE_SCN values in the generated output, you need to ensure that the CREATE_SCN for oggoow181 is copied. This will be the SCN that you will start the Replicat with in a next step. Proceed to the next Task after the script completes.

![](images/900/Lab900_image210.PNG)

### **STEP 7**: Start replication and run the Swingbench transactions.

In this Task, you will start all the processes that we created in the previous Tasks and generate data load with the Swingbench utility. The scripts that will be used in this Task are called start_replication.sh and start_swingbench.sh.

The start_replication.sh script takes the following command line parameters. Eight (8) in total:

        Password = Password to login as OGGADMIN

        AdminService Port = Port number of the Administration Service for Deployment 1

        Extract Name = Name of the Extract in Deployment 1

        DistroService Port = Port number of the Distribution Service in Deployment 1

        Path Name = Name of the path that was created in the Distribution Service in Deployment 1

        AdminService Port = Port number of the Administration Service for Deployment 2

        Replicat Name = Name of the Replicat in Deployment 2

        System Change Number = Creating SCN number from when the Pluggable database was cloned

-       From the Terminal window in the VNC Console run the script **start_replication.sh**.

        $ ./start_replication.sh Welcome1 16001 EXTSOE 16002 SOE2SOE 17001 IREP 2175217

The script will start the replication processes in reverse order as follows:

        Replicat
        Distribution Path
        Extract

You can check to see if these processes are up and running by navigating to the associated HTML5 web pages for the processes:

![](images/900/Lab900_image250.PNG)

![](images/900/Lab900_image260.PNG)

![](images/900/Lab900_image270.PNG)


To test the replication environment, you will use Swingbench.  Swingbench has already been installed in the Script directory and you will use the command line to execute the Swingbench workload.

From the Lab9 directory, run the following script:

        $ ./start_swingbench.sh

For the final task we will view both Deployment’s Performance Metric Service to view transactions metrics within the Oracle GoldenGate configuration.

-       Click on the link to the Performance Metric Service for the Atlanta deployment from the ServiceManager page, or connect directly via the browser to http://<hostname>:16004, then click on the EXTSOE Extract process, and view the details about it.  

![](images/900/Lab900_image280.PNG)

-       Click on the Database Statistics tab and we can view details on the transactions being captured.

![](images/900/Lab900_image290.PNG)


![](images/900/Lab900_image300.PNG)


-       Now click on the link to the Performance Metric Service for the Boston deployment from the ServiceManager page, or connect directly via the browser to http://<hostname>:17004, then click on the IREP Replicat process, and view the details about it.  

![](images/900/Lab900_image310.PNG)


You have completed lab 900!   **Great Job!**
