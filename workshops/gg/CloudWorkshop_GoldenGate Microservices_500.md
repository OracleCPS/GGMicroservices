![](images/400/Lab400_image100.PNG)

Update August 2, 2018

## Bi-Directional and Auto CDR
## Introduction

This lab walk you through bidirectional and auto CDR between two database schemas using Goldengate 12.3 micro services web interface in a Ravello environment.

This lab supports the following use cases:
-	Seting up bidirection goldengate replication between two databases.
-	Setting up auto conflict detection and resolution.

- To log issues and view the Lab Guide source, go to the [github oracle](https://github.com/oracle/learning-library/tree/master/workshops/dbcs) repository.

## Objectives

-   Set up bidirection replication between two databases i.e. AMER DB and EURO DB
-   Set up auto conflict detaction and resolution. And to set up we need to log in to both the databases and run the below PL/SQL
for all the tables - 

    EXEC DBMS_GOLDENGATE_ADM.ADD_AUTO_CDR(schema_name => 'xxxxxx',table_name  => 'xxxxxxx');

## Required Artifacts

Lab A: Configure Uni-Directional Replication from AMER DB to EURO DB (Integrated Extract)

Objective:

This lab is in two parts.  The first part will setup the Integrated Extract for Oracle GoldenGate 12c Service Architecture for a uni-directional configuration using the SOE schema in AMER and EURO. 

Time: 25 minutes

Steps:

1.	Open Firefox and login to the Service Manager using the Administrator account you setup during deployment (Figure A-1). Port number will vary depending on what you used during setup.

For Ravello Environment - 
http://dns url:8890 or
http://localhost:8890 or
http://Private IP:8890


Figure A-1:

![](images/400/Lab400_image110.png) 
 

2.	After logging in, find and open the Administration Server for your deployment.  In this example, the deployment is amer (Figure A-2).  When the page is completely open, you should be at a page where you can see Extracts/Replicats clearly.
Note: You will be required to login again.  Use the same Administrator account that was used with the Service Manager.

Figure A-2:

![](images/400/Lab400_image120.png) 
 

3.	Before you can create an Extract, you need to setup a credential alias for the GoldenGate user (GGADMIN).  This is done from the Configuration menu option in the grey bar on the left of the screen (Figure A-3).

Figure A-3:

![](images/400/Lab400_image130.png) 

![](images/400/Lab400_image140.png) 
 

4.	On the Configuration page, select the plus ( + ) sign to begin adding a credential.  At this point, you will be able to add a Credential Alias (Figure A-4).  You will need to add the alias for a user that will connect to DB.  The DB alias will be used to connect to the database to read the required files for extraction operations, and to add TRANDATA to the schemas used in replication.

Figure A-4:

![](images/400/Lab400_image150.png) 
 

You will notice that a Domain name and Credential Alias were added along with the User ID and Password.  After adding the user to the credential store, you will reference it via its domain name and credential alias.

5.	Verify that the credentials you just created work.  There is a little man icon under Action in the table.  Click on this for each Credential Alias and you should be able to login to the database (Figure A-5).

Figure A-5:

![](images/400/Lab400_image160.png) 
 

6.	Add SCHEMATRANDATA to the SOE schema using the GGADMIN Credential Alias.  
After logging into the database as described in step 5 for the DB, find the Trandata section.  Click on the plus ( + ) sign and make sure that the radio button for Schema is selected (Figure A-6).  At this point, you provide the Schema Name, enable All Columns and Scheduling Columns, and click Submit.

Figure A-6:

![](images/400/Lab400_image170.png) 
 

You will notice that after you click Submit, there is no return message that states the operation was successful.  You can verify that SCHEMATRANDATA has been added by looking searching by Schema (Figure A-7).  To do this, click on the magnifying glass and provide the Schema name.

Figure A-7:

![](images/400/Lab400_image180.png) 
 

7.	Add the Protocol user.
Since we are on the Credential screen, let’s go ahead and add a Protocol user.  A Protocol user is the user that the Distribution Server will use to communicate with the Receiver Server over an unsecure connection.
As you did in Step 4, click the plus sign ( + ) next to the word Credentials.  Then provide the connection information needed (Figure A-8), notice that you will be using the Service Manager login in this credential.

Figure A-8:

![](images/400/Lab400_image190.png) 
 

For now, just leave this login alone.  It will be used in a later step. 

8.	Add the Integrated Extract.
Navigate back to the Overview page of the Administration Server (Figure A-9).  Then click on the plus sign ( + ) in the box for Extracts.

Figure A-9:

![](images/400/Lab400_image200.png) 


After clicking the plus sign ( + ), you are taken to the Add Extract page (Figure A-10).  Here you can choose from three different types of Extracts.  You will be installing an Integrated Extract.  Click Next.

Figure A-10:

![](images/400/Lab400_image210.png) 


The next page of the Add Extract process, is to provide the basic information for the Extract. Items required have a star ( * ) next to them.  Provide the required information and then click Next (Figure A-11).  

Figure A-11:

![](images/400/Lab400_image220.png) 
 

On the last page of the Add Extract process, you are presented with a parameter file (Figure A-12).  The parameter file is partially filled out, but missing the TABLE parameters. Insert the following list of TABLE parameter values into the parameter file.

TRANLOGOPTIONS EXCLUDETAG 123

TABLE AMER.TITLE;                                                                                                              

TABLE AMER.PUBLISHER; 

TABLE AMER.AUTHOR;                                                                                                                

TABLE AMER.ADDRESS;                                                                                                            

TABLE AMER.TITLE_AUTHOR; 

TABLE AMER.SRC_CUSTOMER;

Notes: ~/Desktop/Software/extract.prm has these contents for copying.
Once the TABLE statements are added, click Create and Run at the bottom of the page.

Figure A-12:
 
![](images/400/Lab400_image230.png) 

The Administration Server page will refresh when the process is done registering the Extract with the database, and will show that the Extract is up and running (Figure A-13).

Figure A-13:
 
![](images/400/Lab400_image240.png) 

Lab B: Configure Uni-Directional Replication (Distribution Server)

Objective:
This lab will walk you through how to setup a Path within the Distribution Server.

Time: 10 minutes

Steps:
1.	Start from the Service Manager page (Figure B-1).

Figure B-1:

![](images/400/Lab400_image250.png) 


2.	Open the Distribution Server page for your first deployment (Figure B-2).

Figure B-2:

![](images/400/Lab400_image260.png) 

3.	Click the plus sign ( + ) to add a new Distribution Path (Figure B-3).

Figure B-3:

![](images/400/Lab400_image270.png) 

4.	On the Add Path page, fill in the required information (Figure B-4).  Make note that the default protocol for distribution service is secure websockets (wss).  You will need to change this to websockets (ws).

Figure B-4:

![](images/400/Lab400_image280.png) 

Notice the drop down with the values WS, WSS, UDT and OGG.  These are the protocols you can select to use for transport.  Since you are setting up an unsecure uni-directional replication, make sure you select WS, then provide the following target information:

Hostname: eurosrvr

Port: 16002

Trail File: bb

Domain: WSTARGET

Alias: WSTARGET

After filling out the form, click Create and Run at the bottom of the page.

5.	If everything works as expected, your Distribution Path should be up and running.  You should be able to see clearly the source and target on this page (Figure B-5).

Figure B-5:
 
![](images/400/Lab400_image290.png) 


Lab C: Configure Uni-Directional Replication (Receiver Server)

Objective:
In this lab, you will configure the Receiver Server for the target database, which will receive the trail from the Distribution Path that you created on the source deployment.

Time: 5 minutes

Steps:
1.	Start from the Service Manager page for your second deployment (Figure C-1).

Figure C-1:
 
![](images/400/Lab400_image300.png) 

2.	Click on the Receiver Server link to open the Receiver Server page (Figure C-2).  Verify that everything is configured.

Figure C-2:

![](images/400/Lab400_image310.png) 


Lab D: Configure Uni-Directional Replication (Parallel Replicat)

Object:
In this lab you will configure the Parallel Replicat for the second deployment.

Time: 25 minutes

Steps:
1.	Starting from the Service Manager page (Figure D-1).

Figure D-1:
 
![](images/400/Lab400_image320.png) 
 
2.	Open the Administration Server for the second deployment by clicking on the link (Figure D-2).

Figure D-2:

![](images/400/Lab400_image330.png) 

3.	Open the Configuration option to add your credentials needed to connect to EURO (Figure D-3).  After creating the credential, login and verify that it works.

Figure D-3:
 
![](images/400/Lab400_image340.png) 

4. After Adding the credential you would need to create the checkpoint table 

Figure D-4:
 
![](images/400/Lab400_image390.png) 

5.	Navigate back to the Overview page on the Administration Server.  Here you will begin to create your Integrated Replicat (Figure D-5).  Click the plus sign ( + ) to open the Add Replicat process.

Figure D-5:
 
![](images/400/Lab400_image350.png) 


6.	With the Add Replicat page open, you want to create a Nonintegrated Parallel Replicat.  Make sure the radio button is selected and click Next (Figure D-6).

Figure D-6:
 
![](images/400/Lab400_image360.png) 


7.	Fill in the Replicat options form with the required information (Figure D-7).  Your trail name should match the trail name you saw in the Receiver Server.  Once you are done filling everything out, click the Next button at the bottom of the screen.

Figure D-7:
 
![](images/400/Lab400_image370.png) 

8.	You are next taken to the Parameter File page.  On this page, you will notice that a sample parameter file is provided (Figure D-8).  You will have to remove the MAP statement and replace it with the information below:

DBOPTIONS SETTAG 123

MAPINVISIBLECOLUMNS

MAP AMER.TITLE, TARGET EURO.TITLE;                                                                                                              
MAP AMER.PUBLISHER, TARGET EURO.PUBLISHER; 

MAP AMER.AUTHOR, TARGET EURO.AUTHOR;                                                                                                             
MAP AMER.ADDRESS, TARGET EURO.ADDRESS;                                                                                                            
MAP AMER.TITLE_AUTHOR, TARGET EURO.TITLE_AUTHOR;  

MAP AMER.SRC_CUSTOMER, TARGET EURO.SRC_CUSTOMER;

Notes: ~/Desktop/Software/replicat.prm has these contents for copying.
Once the parameter file has been updated, click the Create and Run button at the bottom.

Figure D-8:
 
![](images/400/Lab400_image380.png) 

At this point, you should have a fully functional uni-directional replication environment. You can start testing.


Lab E: Configure Uni-Directional Replication from EURO DB to AMER DB (Integrated Extract)

Objective:

This is the second part and will setup the Integrated Extract for Oracle GoldenGate 12c Service Architecture for a uni-directional configuration using the SOE schema in EURO and AMER. 

Time: 25 minutes

Steps:

1.	Open Firefox and login to the Service Manager using the Administrator account you setup during deployment (Figure E-1). Port number will vary depending on what you used during setup.

For Ravello Environment - 
http://dns url:8890 or
http://localhost:8890 or
http://Private IP:8890


Figure E-1:

![](images/400/Lab400_image410.png) 
 

2.	After logging in, find and open the Administration Server for your deployment.  In this example, the deployment is euro (Figure E-2).  When the page is completely open, you should be at a page where you can see Extracts/Replicats clearly.
Note: You will be required to login again.  Use the same Administrator account that was used with the Service Manager.

Figure E-2:

![](images/400/Lab400_image420.png) 
 

3.	Before you can create an Extract, you need to setup a credential alias for the GoldenGate user (GGADMIN).  This is done from the Configuration menu option in the grey bar on the left of the screen (Figure E-3).

Figure E-3:

![](images/400/Lab400_image430.png) 

![](images/400/Lab400_image440.png) 
 

4.	On the Configuration page, select the plus ( + ) sign to begin adding a credential.  At this point, you will be able to see a Credential Alias (Figure E-4).  The DB alias will be used to connect to the database to read the required files for extraction operations, and to add TRANDATA to the schemas used in replication.

Figure E-4:

![](images/400/Lab400_image450.png) 
 

5.	Verify that the credentials you just created work.  There is a little man icon under Action in the table.  Click on this for each Credential Alias and you should be able to login to the database (Figure E-5).

Figure E-5:

![](images/400/Lab400_image460.png) 
 

6.	Add SCHEMATRANDATA to the SOE schema using the GGADMIN Credential Alias. After logging into the database as described in step 5 for the DB, find the Trandata section.  Click on the plus ( + ) sign and make sure that the radio button for Schema is selected (Figure E-6).  At this point, you provide the Schema Name, enable All Columns and Scheduling Columns, and click Submit.

Figure E-6:

![](images/400/Lab400_image470.png) 
 

You will notice that after you click Submit, there is no return message that states the operation was successful.  You can verify that SCHEMATRANDATA has been added by looking searching by Schema (Figure E-7).  To do this, click on the magnifying glass and provide the Schema name.

Figure E-7:

![](images/400/Lab400_image480.png) 
 

7.	Add the Protocol user.
Since we are on the Credential screen, let’s go ahead and add a Protocol user.  A Protocol user is the user that the Distribution Server will use to communicate with the Receiver Server over an unsecure connection.
As you did in Step 4, click the plus sign ( + ) next to the word Credentials.  Then provide the connection information needed (Figure E-8), notice that you will be using the Service Manager login in this credential.

Figure E-8:

![](images/400/Lab400_image490.png) 
 

For now, just leave this login alone.  It will be used in a later step. 

8.	Add the Integrated Extract.
Navigate back to the Overview page of the Administration Server (Figure E-9).  Then click on the plus sign ( + ) in the box for Extracts.

Figure E-9:

![](images/400/Lab400_image500.png) 


After clicking the plus sign ( + ), you are taken to the Add Extract page (Figure E-10).  Here you can choose from three different types of Extracts.  You will be installing an Integrated Extract.  Click Next.

Figure E-10:

![](images/400/Lab400_image510.png) 


The next page of the Add Extract process, is to provide the basic information for the Extract. Items required have a star ( * ) next to them.  Provide the required information and then click Next (Figure E-11).  

Figure E-11:

![](images/400/Lab400_image520.png) 
 

On the last page of the Add Extract process, you are presented with a parameter file (Figure E-12).  The parameter file is partially filled out, but missing the TABLE parameters. Insert the following list of TABLE parameter values into the parameter file.

TRANLOGOPTIONS EXCLUDETAG 123

TABLE EURO.TITLE;                                                                                                              

TABLE EURO.PUBLISHER; 
                                                                                                             
TABLE EURO.AUTHOR;                                                                                                                

TABLE EURO.ADDRESS;                                                                                                            

TABLE EURO.TITLE_AUTHOR; 

TABLE EURO.SRC_CUSTOMER; 

Notes: ~/Desktop/Software/extract.prm has these contents for copying.
Once the TABLE statements are added, click Create and Run at the bottom of the page.

Figure E-12:
 
![](images/400/Lab400_image530.png) 

The Administration Server page will refresh when the process is done registering the Extract with the database, and will show that the Extract is up and running (Figure E-13).

Figure E-13:
 
![](images/400/Lab400_image540.png) 

Lab F: Configure Uni-Directional Replication (Distribution Server)

Objective:
This lab will walk you through how to setup a Path within the Distribution Server.

Time: 10 minutes

Steps:
1.	Start from the Service Manager page (Figure F-1).

Figure F-1:

![](images/400/Lab400_image550.png) 


2.	Open the Distribution Server page for your first deployment (Figure F-2).

Figure F-2:

![](images/400/Lab400_image560.png) 

3.	Click the plus sign ( + ) to add a new Distribution Path (Figure F-3).

Figure F-3:

![](images/400/Lab400_image570.png) 

4.	On the Add Path page, fill in the required information (Figure F-4).  Make note that the default protocol for distribution service is secure websockets (wss).  You will need to change this to websockets (ws).

Figure F-4:

![](images/400/Lab400_image580.png) 

Notice the drop down with the values WS, WSS, UDT and OGG.  These are the protocols you can select to use for transport.  Since you are setting up an unsecure uni-directional replication, make sure you select WS, then provide the following target information:

Hostname: amersrvr

Port: 16002

Trail File: dd

Domain: WSTARGET

Alias: WSTARGET

After filling out the form, click Create and Run at the bottom of the page.

5.	If everything works as expected, your Distribution Path should be up and running.  You should be able to see clearly the source and target on this page (Figure F-5).

Figure F-5:
 
![](images/400/Lab400_image590.png) 


Lab G: Configure Uni-Directional Replication (Receiver Server)

Objective:
In this lab, you will configure the Receiver Server for the target database, which will receive the trail from the Distribution Path that you created on the source deployment.

Time: 5 minutes

Steps:

1.	Start from the Service Manager page for your first deployment (Figure G-1).

Figure G-1:
 
![](images/400/Lab400_image600.png) 

2.	Click on the Receiver Server link to open the Receiver Server page (Figure G-2).  Verify that everything is configured.

Figure G-2:

![](images/400/Lab400_image610.png) 


Lab H: Configure Uni-Directional Replication (Parallel Replicat)

Object:
In this lab you will configure the Parallel Replicat for the amer deployment.

Time: 25 minutes

Steps:

1.	Starting from the Service Manager page (Figure H-1).

Figure H-1:
 
![](images/400/Lab400_image620.png) 
 
2.	Open the Administration Server for the second deployment by clicking on the link (Figure H-2).

Figure H-2:

![](images/400/Lab400_image630.png) 

3.	Open the Configuration option (Figure H-3).  

Figure H-3:
 
![](images/400/Lab400_image640.png) 

4. After Adding the credential you would need to create the checkpoint table 

Figure H-4:
 
![](images/400/Lab400_image690.png) 

5.	Navigate back to the Overview page on the Administration Server.  Here you will begin to create your Nonintegrated Parallel Replicat (Figure H-5).  Click the plus sign ( + ) to open the Add Replicat process.

Figure H-5:
 
![](images/400/Lab400_image650.png) 


6.	With the Add Replicat page open, you want to create a Nonintegrated Parallel Replicat.  Make sure the radio button is selected and click Next (Figure H-6).

Figure H-6:
 
![](images/400/Lab400_image360.png) 


7.	Fill in the Replicat options form with the required information (Figure H-7).  Your trail name should match the trail name you saw in the Receiver Server.  Once you are done filling everything out, click the Next button at the bottom of the screen.

Figure H-7:
 
![](images/400/Lab400_image670.png) 

8.	You are next taken to the Parameter File page.  On this page, you will notice that a sample parameter file is provided (Figure H-8).  You will have to remove the MAP statement and replace it with the information below:

DBOPTIONS SETTAG 123

MAPINVISIBLECOLUMNS

MAP EURO.TITLE, TARGET AMER.TITLE;                                                                                                           
MAP EURO.PUBLISHER, TARGET AMER.PUBLISHER; 

MAP EURO.AUTHOR, TARGET AMER.AUTHOR;                                                                                                                
MAP EURO.ADDRESS, TARGET AMER.ADDRESS;                                                                                                            
MAP EURO.TITLE_AUTHOR, TARGET AMER.TITLE_AUTHOR;  

MAP EURO.SRC_CUSTOMER, TARGET AMER.SRC_CUSTOMER; 

Notes: ~/Desktop/Software/replicat.prm has these contents for copying.
Once the parameter file has been updated, click the Create and Run button at the bottom.

Figure H-8:
 
![](images/400/Lab400_image680.png) 

At this point, you should have a fully functional bi-directional replication environment. You can start testing.


Lab I: Testing the Auto CDR with data

Object:
In this lab we will load few records in SRC_CUSTOMER table and test AUTO CDR.

Time: 15 minutes

Steps:

1.	In this lab we inserted 1 record each on SRC_CUSTOMER table from AMER DB and EURO DB. We can see the stats in (Figure I-1) & (Figure I-2)

Figure I-1:
 
![](images/400/Lab400_image700.png) 

Figure I-2:
 
![](images/400/Lab400_image710.png) 


2.	After this we will try to insert the same record on both AMER DB and EURO DB to test the AUTO CDR. Here we are using a DB-Link and a procedure to load same records on both the DB's. 

Figure I-3:

![](images/400/Lab400_image720.png) 

