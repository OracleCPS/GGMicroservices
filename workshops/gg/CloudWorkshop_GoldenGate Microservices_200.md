![](images/200/Lab200_image100.PNG)

Update January 02, 2019

## Configuring ServiceManager,Source(Atlanta) and Target(Sanfran)
## Introduction

This lab walk you through configuring ServiceManager,Source(Atlanta) and Target(Sanfran) Deployments using Goldengate 18.1 micro services web interface in a Ravello environment.

## Objectives

-	Configure the initial ServiceManager,Source(Atlanta) and Target(Sanfran) Deployments 
-	Connect to the target environment deployment through a web browser and confirm that the deployment succeeded and that the ServiceManager and core GoldenGate services are running.


## Required Artifacts

-   The following lab can be done simply through a browser-based environment however VNC and the remote desktop client are also supported if you have them already installed on your labtop.
-   A client environment virtual machine that is running within the Ravello Cloud service is also provided with all of the necessary dependencies.


**Retrieve your Ravello details for each of the VMs that are used**

### **STEP 1**: Open up a terminal window and create the ServiceManager and Source(Atlanta) Deployment

In this step you will create the initial ServiceManager. ServiceManager is the bootstrap process that can be configured as a daemon process in Unix and windows so that it can start and stop on system startup and shutdown.   It also is responsible for starting and stopping the other GoldenGate services and presents the initial web user interface and access point for the AdminClient command line interface.

-	Once you login into the ***Remote desktop***,traverse to **applications** and open up the **Terminal**.

-   From the terminal screen, set the environment variable for the  Oracle 18c database.  ***Make sure to follow this step carefully to set up the proper environmental variables for the deployment***

		[oracle@OGG181DB183 ~]$ . oraenv
		[oracle@OGG181DB183 ~]$ ORACLE_SID = [orcl] ? ORCL

-   Then, change to the **/opt/app/oracle/product/18.1.0_RC2/oggcore_1/bin** directory.

		cd /opt/app/oracle/product/18.1.0_RC2/oggcore_1/bin

-   Then, run the **oggca.sh** script:

		[oracle@@OGG181DB183 bin] ./oggca.sh

- The following screen will appear.   Select the option to **"Create New Service Manager"** and click on the **"Browse"** button to help assign the correct deployment home directory for the Service Manager.

![](images/200/1.JPG)

- For the directory selection dialog box navigate to the **"/opt/app/oracle/gg_deployments/ServiceManager/"** directory and click on the **"Select"** button.

![](images/200/2.JPG)

- For the ServiceManager details screen enter the hostname of **"OGG181DB183"** for the listening hostname/address and enter **"16000"** for the listening port value.  Click on the **"Register Service as a system service/daemon"** checkbox. Click on **"Next"** to continue the configuration.   

![](images/200/3.JPG)

- Since this is the **First deployment** on the system, you will only have ***one*** option. Take the default and click **Next**.

![](images/200/4.JPG)

- You will need to provide a **Deployment Name** and the **OGG_HOME** is selected by default. If the wrong OGG_HOME is listed; use the Browse button to correct it.

		This will be your first deployment under the Service Manager. You can name the deployment
		whatever you like. For this lab, it’s suggested to use a city name which will make 
		the deployment name like “Atlanta”.

![](images/200/5.JPG)

- You will be able to provide the **Deployment home** for this deployment. There is also an option to customize the deployment directories. For the purpose of this lab, provide a default directory structure

![](images/200/7.JPG)

- For  the **"Specify Enviroment Variables"** screen, review the settings and click on **"Next"** to continue.  

![](images/200/8.JPG)

- For the **"Specify Administrator Account"** screen, enter **"ggadmin"** for the username field, and enter **"welcome1"** for the password field.  Enter the same value of **"welcome1"** for the confirm password field.   Click on **"Next"** to continue.

![](images/200/9.JPG)

- For the **"Specify Security Options"** screen, make sure all the **"SSL/TLS security"** and **"This nonsecure deployment will be used to send trail data to a secure deployement"** checkboxes are ***unchecked***.  Click on **"Next"** to continue.

![](images/200/10.JPG)

- For the **"Specify Port Settings"** screen, set the following field and checkbox values (you will note that they will autofill based on the first setting which is fine).   Then once confirmed click **"Next"** to continue.

| Field/Checkbox				|		Setting		|
|-------------------------------|-------------------|
|Administration Server Port"	| 	16000			|
|Distribution Server Port"		|	16001			|
|Receiver Server Port"			| 	16002			|
|Enable Monitoring"				| 	Checked			|
|Metrics Server Port			|	16003			|
|Metrics Server UDP Port (data) |   16004			|
|Metrics Server Datastore Type  |   BDB				|
|Metrics Server Datastore home  |User defined location| 

Note : 
For lab purpose,we have choosed **"Metrics Server Datastore home"** to **"/opt/app/oracle/gg_deployment/Atlanta/meteric"**  but you can your own desired path
![](images/200/11.JPG)

- For the "Specify OGG Replication Settings" screen, enter **GGATE** for the "Default Schema" field.  Click on **"Next"** to continue.
 
![](images/200/12.JPG)

- For the **"Summary"** screen review the options carefully and then select the **"Finish"** button.

![](images/200/13.JPG)

- Follow the progress carefully on the **next** screen.

![](images/200/14.JPG)

- For the **"Execute Configuration Scripts"** screen, you will be prompted to manually execute the ***registerServiceManager.sh*** script which will daemonize the SerivceManager executable to enable it to be started and stop on system shutdown and startup.

![](images/200/15.JPG)

- At a terminal prompt login as root using the ***sudo su*** - command and execute the shell script as directed:

		[oracle@OGG181DB183 ~]$ sudo su -
		[root@OGG181DB183 ~]# hostname
		OGG181DB183
		[root@OGG181DB183 ~]# /opt/app/oracle/gg_deployments/ServiceManager/bin/registerServiceManager.sh

- The output should look like the following:

![](images/200/16.JPG)

- When complete go back to the **"Execute Configuration Scripts"** screen and click on the **"Ok"** button

![](images/200/15.JPG)

- For the **"Finish"** screen confirm the ***sucessful deployment status*** and click on the **"Close"** button.   

![](images/200/17.JPG)

- **The GoldenGate ServiceManager** deployment and the **"Source(Atlanta)"** deployment are now complete and ready to start using.   Lets now verify the deployment by connecting through the brower interface.  
- Open up a browser window in your client VM environment in Ravello or on your laptop using a browser (like Chrome or Firefox) and enter the following URL and port: **http://localhost:16000** [make sure to change this URL for the deployed service].  
- You should get a sign on page.   Sign in using the username: **"ggadmin"** and password **"welcome1"**.
login pages needs to be taken
![](images/200/33.JPG)

- You will then be taken to the following page.   Review that the Services for the ***"Source(Atlanta)"*** deployment and the ServiceManager are all in a ***"Running"*** state. 

![](images/200/image18.JPG)

### **STEP 2**: Configuring Target (Sanfran) deployment using Automate script

In this step you will configure the Target (Sanfran) deployment. 

-	Once you login into the ***Remote desktop***,traverse to **applications** and open up the **Terminal**.

-   Then, change current directory to the **Lab2** directory.

		cd ~/OGG181_WHKSHP/Lab2

-   Then, run the **create_deployment.sh** script:

		$  ./create_deployment.sh A1  A2 A3 A4 A5 A6 A6 A7 A8
Example 
        $  ***./create_deployment.sh SanFran Welcome1 16000 17001 17002 17003 17004 17005***

	|    Arguement    | DESCRIPTION	       	        |       VALUES	      |
	|-----------------|-----------------------------|---------------------|
	|      A1         |Deployment Name	            | 	    SanFran	      |
	|      A2         |Admin User Password	        |	    Welcome1      |
	|      A3         |Service Manager Port     	| 	    16000	      |
	|      A4         |Administration Server Port	| 	    17001	      |
	|      A5         |Distribution Server Port 	|	    17002	      |
	|      A6         |Receiver Server Port         |       17003	      |
	|      A7         |Metrics Server Port          |       17004         |
	|      A8         |Metrics Server UDP Port      |       17005         |


Once the script is executed, you will see a statement saying that the ***“Successfully Setup Software.”*** indicates that deployment ***SanFran*** has been the created.
	
![](images/200/34.JPG)



You have completed lab 200!   **Great Job!**