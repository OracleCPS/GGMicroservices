![](images/400/Lab300_image100.PNG)

Update Feburary 12, 2019

## UniDirectional and DDL Replication
## Introduction

This lab walks you through uni-directional and DDL replication between to database schemas using Goldengate 18.1 Micro services web interface in a Ravello environment.

![](images/400/Lab300_image104.PNG)

This lab supports the following use cases:
-	One way replication to target database where both databases are already in sync.
-   Simple DDL replication example.

## Objectives

This lab is in several parts.  The first part will setup the Integrated Extract for Oracle GoldenGate 18c Microservices Architecture for a uni-directional configuration using the SOE schema in the OGGOOW181 and OGGOOW182 PDBs. 

### **STEP 1**: Log into the Service Manager and check credentials.

- 	Open up a browser window in your client VM environment in Ravello or on your laptop using a browser (like Chrome or Firefox) and enter the following URL and port: **http://localhost:16000** .  

- 	If you're using the browser on your laptop, change **localhost** to the **Ravello URL or IP Address** your instructor gave out at the beginning of the workshop (**same one you used for the VNC Session**).

- 	You should get a sign on page.   Sign in using the username: **"oggadmin"** and password **"Welcome1"**.

![](images/400/Lab300_image110.PNG) 
 
-   After logging in, find and open the Administration Server for your first deployment.  In this example, the first deployment is Atlanta.  Click on the link with the port number for the Admin Service for Atlanta.

Note: You will be required to login again.  Use the same Administrator account that was used with the Service Manager.

![](images/400/Lab300_image120.PNG) 
 
-   Before you can create an Extract, you need to setup a credential alias for the GoldenGate user (C##GGATE).  This was done in lab 300.

![](images/300/Lab300_image5.PNG) 

-   Verify that the credentials you just created work.  There is a little database icon under Action in the table.  Click on this for the database Credential Alias and you should be able to login to the database.

![](images/400/Lab300_image160.PNG) 
 
### **STEP 2**: Add SCHEMATRANDATA to the SOE schema using the SGGATE Credential Alias.

-   After logging into the database as described for OGGOOW181, find the Trandata section.  Click on the plus ( + ) sign and make sure that the radio button for Schema is selected .  At this point, you provide the Schema Name(OGGOOW181.SOE), enable All Columns and Scheduling Columns, and click Submit.

![](images/400/Lab300_image170.PNG) 
 
-   You will notice that after you click Submit, there is no return message that states the operation was successful.  You can verify that SCHEMATRANDATA has been added by looking searching by Schema.  To do this, click on the magnifying glass and provide the Schema name.

![](images/400/Lab300_image180.PNG) 
 
### **STEP 3**: Add the Integrated Extract.

-   Navigate back to the Overview page of the Administration Server.  Then click on the plus sign ( + ) in the box for Extracts.

![](images/400/Lab300_image300.PNG) 


-   After clicking the plus sign ( + ), you are taken to the Add Extract page.  Here you can choose from three different types of Extracts.  You will be installing an Integrated Extract.  Click Next.

![](images/400/Lab300_image210.PNG) 


-   The next page of the Add Extract process, is to provide the basic information for the Extract. Items required have a star ( * ) next to them.  Provide the required information and then click Next.  Keep in mind that the credentials needed to register the Extract need to be against the CDB (ORCL). Use the CDB domain and alias that you setup previously.

-   When using the CDB credential, at the bottom of the page, you will be presented with a box where you can select the PDB that will be used. This will only appear when you have a valid credential for the CDB.  Once you see this box, make sure you select OGGOOW181. 

![](images/400/Lab300_image220.PNG) 

![](images/400/Lab300_image225.PNG) 
 

On the last page of the Add Extract process, you are presented with a parameter file.  The parameter file is partially filled out, but missing the TABLE parameters. Insert the following list of TABLE parameter values into the parameter file.
   
    DDL INCLUDE ALL;
    SOURCECATALOG OGGOOW181
    TABLE SOE.*;

[Optional - For your information] You can also include specific table names for capturing the data changes, but extract will skip the create table DDLs. Sample TABLE parameter vales are given below.

    DDL INCLUDE ALL;
    SOURCECATALOG OGGOOW181
    TABLE SOE.ADDRESSES;
    TABLE SOE.CUSTOMERS;
    TABLE SOE.ORDERS;
    TABLE SOE.ORDER_ITEMS;
    TABLE SOE.CARD_DETAILS;
    TABLE SOE.LOGON;
    TABLE SOE.PRODUCT_INFORMATION;
    TABLE SOE.INVENTORIES;
    TABLE SOE.PRODUCT_DESCRIPTIONS;
    TABLE SOE.WAREHOUSES;
    TABLE SOE.ORDERENTRY_METADATA;

Once the TABLE statements are added, click Create and Run at the bottom of the page.
 
![](images/400/Lab300_image230.PNG) 

The Administration Server page will refresh when the process is done registering the Extract with the database, and will show that the Extract is up and running

![](images/400/Lab300_image240.PNG) 

### **STEP 4**: Configure Uni-Directional Replication (Distribution Server).

This step will walk you through how to setup a Path within the Distribution Server.

-   Start from the Service Manager page.

![](images/400/Lab300_image250.PNG) 


-   Open the Distribution Server page for your first deployment (Atlanta).

![](images/400/Lab300_image260.PNG) 

-   Click the plus sign ( + ) to add a new Distribution Path.

![](images/400/Lab300_image270.PNG) 

-   On the Add Path page, fill in the required information.  Make note that the default protocol for distribution service is secure websockets **wss**.  You will need to change this to websockets **ws**.

![](images/400/Lab300_image280.PNG) 

Notice the drop down with the values WS, WSS, UDT and OGG.  These are the protocols you can select to use for transport.  Since you are setting up an unsecure uni-directional replication, make sure you select **WS**, then provide the following target information:
Hostname: localhost
Port: 17003
Trail File: bb
Domain: WSTARGET
Alias: WSTARGET

-   After filling out the form, click Create and Run at the bottom of the page.

![](images/400/Lab300_image285.PNG) 

-   Review the Distribution Service to see that the distribution path is created and running.
 
![](images/400/Lab300_image290.PNG) 

### **STEP 5**: Check Receiver Service.

## Objectives
Check the Receiver Server for the target database, which will receive the trail from the Distribution Path that you created on the source deployment.

-   Start from the Service Manager page for your second deployment.
 
![](images/400/Lab300_image305.PNG) 

-   Click on the Receiver Server link to open the Receiver Server page.  Verify that everything is configured.

![](images/400/Lab300_image310.PNG) 

### **STEP 6**: Configure Uni-Directional Replication (Parallel Replicat).

## Objectives
In this lab you will configure the Parallel Replicat for the second deployment.

-   Starting from the Service Manager page.
 
![](images/400/Lab300_image320.PNG) 
 
-   Open the Administration Server for the second deployment by clicking on the link.

![](images/400/Lab300_image330.PNG) 

-   This step requires a credential store for replicat to connect to target database. Use the TGGATE created in Lab300. 


-   Navigate back to the Overview page on the Administration Server.  Here you will begin to create your Parallel Replicat -   Click the plus sign ( + ) to open the Add Replicat process.
 
![](images/400/Lab300_image350.PNG) 

-   With the Add Replicat page open, you want to create a Parallel Replicat.  Make sure the radio button is selected and click Next.

![](images/400/Lab300_image360.PNG) 


-   Fill in the Replicat options form with the required information.  Your trail name should match the trail name you saw in the Receiver Server.  Once you are done filling everything out, click the Next button at the bottom of the screen.
 
![](images/400/Lab300_image370.PNG) 

-   You are next taken to the Parameter File page.  On this page, you will notice that a sample parameter file is provided -   You will have to remove the MAP statement and replace it with the information below:

    **MAP OGGOOW181.SOE.\*, TARGET SOE.\*;**
 
![](images/400/Lab300_image380.PNG) 

[Optional - For your information] You can also specify individual table name as given below. <br />

    replicat REP1
    useridalias TGGATE domain OracleGoldenGate
    --MAP OGGOOW181.SOE.*, TARGET SOE.*;
    MAP OGGOOW181.SOE.CUSTOMERS, TARGET SOE.CUSTOMERS;
    MAP OGGOOW181.SOE.ADDRESSES, TARGET SOE.ADDRESSES;
    MAP OGGOOW181.SOE.ORDERS, TARGET SOE.ORDERS, KEYCOLS(ORDER_ID);
    MAP OGGOOW181.SOE.ORDER_ITEMS, TARGET SOE.ORDER_ITEMS, KEYCOLS(ORDER_ID,LINE_ITEM_ID);
    MAP OGGOOW181.SOE.CARD_DETAILS, TARGET SOE.CARD_DETAILS;
    MAP OGGOOW181.SOE.LOGON, TARGET SOE.LOGON;
    MAP OGGOOW181.SOE.PRODUCT_INFORMATION, TARGET SOE.PRODUCT_INFORMATION;
    MAP OGGOOW181.SOE.INVENTORIES, TARGET SOE.INVENTORIES, KEYCOLS(PRODUCT_ID,WAREHOUSE_ID);
    MAP OGGOOW181.SOE.PRODUCT_DESCRIPTIONS, TARGET SOE.PRODUCT_DESCRIPTIONS;
    MAP OGGOOW181.SOE.WAREHOUSES, TARGET SOE.WAREHOUSES;
    MAP OGGOOW181.SOE.ORDERENTRY_METADATA, TARGET SOE.ORDERENTRY_METADATA;
    --MAP OGGOOW181.SOE.CUSTOMERS, TARGET SOE.CUSTOMERS;
    --MAP OGGOOW181.SOE.ADDRESSES, TARGET SOE.ADDRESSES;
    --MAP OGGOOW181.SOE.ORDERS, TARGET SOE.ORDERS;
    --MAP OGGOOW181.SOE.ORDER_ITEMS, TARGET SOE.ORDER_ITEMS;
    --MAP OGGOOW181.SOE.CARD_DETAILS, TARGET SOE.CARD_DETAILS;
    --MAP OGGOOW181.SOE.LOGON, TARGET SOE.LOGON;
    --MAP OGGOOW181.SOE.PRODUCT_INFORMATION, TARGET SOE.PRODUCT_INFORMATION;
    --MAP OGGOOW181.SOE.INVENTORIES, TARGET SOE.INVENTORIES;
    --MAP OGGOOW181.SOE.PRODUCT_DESCRIPTIONS, TARGET SOE.PRODUCT_DESCRIPTIONS;
    --MAP OGGOOW181.SOE.WAREHOUSES, TARGET SOE.WAREHOUSES;
    --MAP OGGOOW181.SOE.ORDERENTRY_METADATA, TARGET SOE.ORDERENTRY_METADATA;
    	

-   Once the parameter file has been updated, click the Create and Run button at the bottom.

-   At this point, you should have a fully functional uni-directional replication environment.

### **STEP 7**: Run Swingbench script to apply data to the source database.

-   Change directory to Lab5 run script **start_swingbench_181.sh**.

        [oracle@OGG181DB183 ~]$ cd ~/OGG181_WHKSHP/Lab4
		[oracle@OGG181DB183 Lab5$ ./start_swingbench_181.sh
        [oracle@OGG181DB183 Lab5]$ Author  :	 Dominic Giles
        Author  :	 Dominic Giles
        Version :	 2.6.0.1046

        Version :	 2.6.0.1046
        Results will be written to results.xml.

        Results will be written to results.xml.
        Hit Return to Terminate Run...
        Hit Return to Terminate Run...

        Time		Users

        Time		Users
        00:10:47	[0/2]
        00:10:47	[0/2]


###########  ADD Check replication status steps #################

### **STEP 8**: DDL Replication.

## Objectives
In this lab we will perform a few DML and DDL operations on source pdb and check if those operations are properly replicated to target database.

Prerequisite: Source and target database should be in sync. Extract, Pump and Replicat should be up and running.

-   Logon to OGGOOW181 and OGGOOW182 pdbs using SOE user.

![](images/400/Lab300_image400.PNG) 

-   Verify whether tables are in sync between source and target databases.

![](images/400/Lab300_image405.PNG) 

![](images/400/Lab300_image410.PNG) 

-   Create a employee table in OGGOOW181.

![](images/400/Lab300_image415.PNG) 

-   Go to target admin server page, click on actions on replicate and select details option.

![](images/400/Lab300_image420.PNG) 

-   Click on statistics tab and check the DDL Mapped count.

![](images/400/Lab300_image425.PNG) 

-   Perform few insert operations on source tables in OGGOOW181 pdb database and check if the inserts are replicated to target tables.

![](images/400/Lab300_image430.PNG) 

![](images/400/Lab300_image435.PNG) 

-   Perform few updates and deletes operations on source table and check if the operations are replicated to target database.

![](images/400/Lab300_image440.PNG) 

-   Execute the below alter commands and verify the statistics on extract and replicat.

![](images/400/Lab300_image445.PNG) 

-   Execute truncate operation on employee table, verify the statistics and count in the target pdb.

![](images/400/Lab300_image455.PNG) 

![](images/400/Lab300_image460.PNG) 

![](images/400/Lab300_image465.PNG)

-   Similarly, execute drop command on the employee table and check the results in the target database.

![](images/400/Lab300_image470.PNG)

![](images/400/Lab300_image475.PNG)

![](images/400/Lab300_image480.PNG)

The above error is because employee table is not present in the target database. Drop command is executed successfully in target database.

### **STEP 8**: Stop delivery process.

- Please log on to Admin process screen of Sanfran (http://localhost:17001) and stop the parallel nonintegrared replicat process.
![](images/400/Lab400_image999.PNG)

- Similart please log on to Admin process screen of Atlanta (http://localhost:16001) and stop the integrared Extract (EXT1) and Distribution path(SOE2SOE) replicat process.

![](images/400/Lab400_image998.PNG)
![](images/400/Lab400_image997.PNG)

You have completed lab 400!   **Great Job!**
