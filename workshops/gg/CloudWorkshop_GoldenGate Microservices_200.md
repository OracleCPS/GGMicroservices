Update January 02, 2019

## Configuring ServiceManager,Source(Atlanta) and Target(Sanfran)
## Introduction

This lab walk you through configuring ServiceManager,Source(Atlanta) and Target(Sanfran) Deployments using Goldengate 18.1 micro services web interface in a Ravello environment.

## Objectives

-	Configure the initial ServiceManager,Source(Atlanta) and Target(Sanfran) Deployments 
-	Connect to the target environment deployment through a web browser and confirm that the deployment succeeded and that the ServiceManager and core GoldenGate services are running.


## Required Artifacts

-   The following lab can be done simply through a browser-based environment however VNC and the remote desktop client are also supported if you ahve them already installed on your labtop.
-   A client environment virtual machine that is running within the Ravello Cloud service is also provided with all of the necessary dependencies.


**Retrieve your Ravello details for each of the VMs that are used**

### **STEP 1**: Open up a terminal window and create the ServiceManager

In this step you will create the initial ServiceManager. ServiceManager is the bootstrap process that can be configured as a daemon process in Unix and windows so that it can start and stop on system startup and shutdown.   It also is responsible for starting and stopping the other GoldenGate services and presents the initial web user interface and access point for the AdminClient command line interface.

-	Right click on the desktop environment and pick **"Open Terminal"** from the pop up menu unless you already have a terminal screen opened already.

-   From the terminal screen, set the Oracle environment for the target database.  ***Make sure to follow this step carefully to set up the proper environmental variables for the deployment***

		[oracle@OGG181DB183 ~]$ . oraenv
		[oracle@OGG181DB183 ~]$ ORACLE_SID = [orcl] ? ORCL

-   Then, change to the **/opt/app/oracle/product/18.1.0_RC2/oggcore_1/bin** directory.

		cd /opt/app/oracle/product/18.1.0_RC2/oggcore_1/bin

-   Then, run the **oggca.sh** script:

		[oracle@@OGG181DB183 bin] ./oggca.sh

- The following screen will appear.   Select the option to **"Create New Service Manager"** and click on the **"Browse"** button to help assign the correct deployment home directory for the Service Manager.

![](images/100/1.JPG)

- For the directory selection dialog box navigate to the "/u01/app/gg_deployments/ServiceManager" directory and click on the "Select" button.

![](images/100/2.JPG)

- For the ServiceManager details screen enter the hostname of "@OGG181DB183" for the listening hostname/address and enter "8890" for the listening port value.  Click on the "Register Service as a system service/daemon" checkbox. Click on "Next" to continue the configuration.   

![](images/100/image9.JPG)

- For the "Specify Deployment Directories" screen review the default values to make sure that they will all be deployed within the /u01/app/gg_deployments/euro directory.  Click on "Next" to continue.

![](images/100/image13.JPG)

- For  the "Specify Enviroment Variables" screen, review the settings and click on "Next" to continue.  

![](images/100/image14.JPG)

- For the "Specify Administrator Account" screen, enter "ggadmin" for the username field, and enter "welcome1" for the password field.  Enter the same value of "welcome1" for the confirm password field.   Click on "Next
 to continue.

![](images/100/image15.JPG)

- For the "Specify Security Options" screen, make sure all the "SSL/TLS security" and "This nonsecure deployment will be used to send trail data to a secure deployemnt" checkboxes are ***unchecked***.  Click on "Next" to continue.

![](images/100/image16.JPG)

- For the "Specify Port Settings" screen, set the following field and checkbox values (you will note that they will autofill based on the first setting which is fine).   Then once confirmed click "Next" to continue.

| Field/Checkbox				|		Setting		|
|-------------------------------|-------------------|
|Administration Server Port"	| 	16000			|
|Distribution Server Port"		|	16001			|
|Receiver Server Port"			| 	16002			|
|Enable Monitoring"				| 	Checked			|
|Metrics Server Port			|	16003			|
|Metrics Server UDP Port (data) |   16004			|
|Metrics Server Datastore Type  |   BDB				|


![](images/100/image17.JPG)

- For the "Specify OGG Replication Settings" screen, enter ggadmin for the "Default Schema" field.  Click on "Next" to continue.
 
![](images/100/image18.JPG)

- For the "Summary" screen review the options carefully and then select the "Finish" button.

![](images/100/image19.JPG)

- Follow the progress carefully on the next screen.
- 
![](images/100/image20.JPG)

- For the "Execute Configuration Scripts" screen, you will be prompted to manually execute the registerServiceManager.sh script which will daemonize the SerivceManager executable to enable it to be started and stop on system shutdown and startup.

![](images/100/image21.JPG)

- At a terminal prompt login as root using the sudo su - command and execute the shell script as directed:

`[oracle@OGG181DB183 ~]$ sudo su -`

`[root@@OGG181DB183 ~] /u01/app/gg_deployments/ServiceManager/bin/registerServiceManager.sh`

- The output should look like the following:

![](images/100/image22.JPG)

- When complete go back to the "Execute Configuration Scripts" screen and click on the "Ok" button

![](images/100/image21.JPG)

- For the "Finish" screen confirm the sucessful deployment status and click on the "Close" button.   

![](images/100/image23.JPG)

- The GoldenGate ServiceManager deployment and the "euro" deployment are now complete and ready to start using.   Lets now verify the deployment by connecting through the brower interface.  
- Open up a browser window in your client VM environment in Ravello or on your laptop using a browser (like Chrome or Firefox) and enter the following URL and port: https://emeatargetdb-goldengatemicroser-s7k6yjyo.srv.ravcloud.com:8890 [make sure to change this URL for the deployed service].  
- You should get a sign on page.   Sign in using the username: "ggadmin" and password "welcome1".

![](images/100/image24.JPG)

- You will then be taken to the following page.   Review that the Services for the "euro" deployment and the ServiceManager are all in a "Running" state. 

![](images/100/image25.JPG)

You have completed lab 100!   **Great Job!**