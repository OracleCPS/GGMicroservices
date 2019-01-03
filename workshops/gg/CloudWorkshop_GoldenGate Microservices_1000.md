![](images/500/Lab500_image100.PNG)

## CONNECT AND INTERACT WITH ADMINCLIENT
## Introduction

In this lab, you will take a look at how to connect and interact with the Microservices AdminClient. using Goldengate 12.3 micro services web interface in a Ravello environment.


Steps:
1. Open a command terminal
Right mouse click -> Open Terminal

![](images/500/Lab500_image101.PNG)

![](images/500/Lab500_image102.PNG)

2. Navigate to the Oracle GoldenGate 12.3 binary directory
cd /opt/app/oracle/product/12.3.0.1/oggcore_1/bin

![](images/500/Lab500_image103.PNG)

3. Start the AdminClient
./adminclient

![](images/500/Lab500_image104.PNG)

4. Connect to Oracle GoldenGate without a deployment

OGG 1> connect http://hostname:16000 as oggadmin password welcome1

![](images/500/Lab500_image105.PNG)

Notice that you are not connected and that AdminClient provides you a list of deployment you can attempt to connect to.

5. Connect to an Oracle GoldenGate deployment

OGG 2> connect http://hostname:16000 deployment Atlanta_1 as oggadmin password welcome1

![](images/500/Lab500_image106.PNG)

6. Perform an “info all” command and other GoldenGate commands to see what
AdminClient can do

OGG Atlanta_1 3> info all

![](images/500/Lab500_image107.PNG)

Note: checkout the RLWRAP function as well (arrow up and down while in AdminClient)


At this point, you should have a fully functional Admin Client environment. 


![](images/500/Lab502_image100.PNG)

## Working with REST API
## Introduction

In this lab, you will take a look at how to pull a list of services from Oracle GoldenGate using the REST APIs. Replace <port> with the port number of the service you want to access.

Steps:
1. Open a command window (right mouse click – Open Terminal)

2. Try running the following CURL command

curl -u oggadmin:welcome1 -H "Content-Type: application/json" -H "Accept:
application/json" -X GET http://hostname:<port>/services/v2/deployments/SanFran_1/services/distsrvr/logs |
python -mjson.tool

3. Retrieve Log locations using the following CURL command

curl -u oggadmin:welcome1 -H "Content-Type:application/json" -H
"Accept:application/json" -X GET http://hostname:<port>/services/v2/logs | python - mjson.tool

![](images/502/Lab502_image101.png)

Appendix:

A: Run Swingbench
Steps:
1. Open a command terminal and navigate to the Swingbench bin directory

cd /opt/app/oracle/product/swingbench/bin
![](images/500/Lab502_image102.PNG)

2. Execute the swingbench command

./swingbench
![](images/500/Lab502_image103.PNG)

3. Once Swingbench starts, select the SOE_Server_Side_V2 configuration file.

![](images/500/Lab502_image104.PNG)

4. Once Swingbench is open, update Password, Connect String, Benchmark and Run Time:

Password: welcome1 --
Connect String: //hostname/pdb1 --
Benchmark Run Time: 10 mins

adjust parameters for generating records

![](images/500/Lab502_image105.PNG)

5. Execute Swingbench

![](images/500/Lab502_image106.PNG)


At this point you should see activity on the table by looking at the Extract/Replicats.
Correct any problems that may arise due.

At this point, you should have a fully functional REST Api environment. 


![](images/500/Lab503_image100.PNG)

## Working with mySQL
## Introduction

In this lab, you will take a look at how to pull a list of services from Oracle GoldenGate using mySQL.

Steps:

Set up Goldengate Extract on the source MYSQL DB

1.	Connecting to ravello instance from putty , Once you start the MYSQL instance IP address will appear

![](images/500/Lab503_image101.PNG)

2.	You would need the private key file to connect the instance

![](images/500/Lab503_image102.png)

3.	Load the private key in the putty

![](images/500/Lab503_image103.PNG)

4.	Log in as user ‘ravello’

![](images/500/Lab503_image104.PNG)

5.	Golden gate instance is already installed and set up for the MYSQL DB in /opt/gg4mysql/

![](images/500/Lab503_image105.PNG)

6.	Both extract and pump process is already been set up. You need to add the remote host ip address in the PUMP parameter file. You can find the remote host ip from the EURO instance and the MGRPORT would be target receiver server port

![](images/500/Lab503_image106.PNG)

7.	You can load the test tables with the below scrip in the location /home/ravello/sql


![](images/500/Lab503_image107.PNG)

8.	Once you load the table check the stats of the extract

![](images/500/Lab503_image108.PNG)

9.	On the target EURO instance make sure all the processes are running 

![](images/500/Lab503_image109.PNG)

10. If you check in receiver server there will not be any paths before you start the pump on the source side.

![](images/500/Lab503_image110.png)

11.	Once the pump is started on the source side you will see a path created

![](images/500/Lab503_image111.png)

12.	You can check the trail files on the system as well
![](images/500/Lab503_image112.PNG)

13.	Now go to administrative server CONFIGURATION tab

![](images/500/Lab503_image113.png)

14.	You can add DB credentials there which will be used by Replicat process
![](images/500/Lab503_image114.PNG)

15.	Now connect to DB with the credential created

![](images/500/Lab503_image115.PNG)

16.	Then you can create a checkpoint table in the DB

![](images/500/Lab503_image116.PNG)

17.	Now go to Overview tab to create the replicat

![](images/500/Lab503_image117.PNG)

18.	Select the type of the replicat

![](images/500/Lab503_image118.PNG)

19.	Complete all the details

![](images/500/Lab503_image119.png)

20.	You can manually change the parameter file before creating

![](images/500/Lab503_image120.png)

21.	Once created 

![](images/500/Lab503_image121.png)

22.	You can check the statistic

![](images/500/Lab503_image122.png)

23.	You can log in to Database and check the counts

![](images/500/Lab503_image123.png)

24.	connecting to GG Admin client will require the same private key 

![](images/500/Lab503_image124.png)

25.	you can check the same stats of replicat remotely from the admin client

![](images/500/Lab503_image125.png)

![](images/500/Lab503_image125a.png)