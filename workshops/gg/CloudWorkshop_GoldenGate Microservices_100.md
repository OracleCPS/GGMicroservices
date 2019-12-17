![](images/100/Lab100_image100.jpg)

Update Dec 17, 2019

#### Introduction

This is the first of a series of labs to introduce you to the capabilities of GoldenGate Microservices for Oracle Database.   It is a significant release that changes the underlying architecture of GoldenGate to enable it to be administered, monitored, managed and configured through a series of common services.   Each service supports a standard web-based user interface, REST (Representational State Transfer) APIs and a command line client, that allow all configuration to be done remotely in an agile manner. 

In this first lab you will walk through the process of installing this new version of GoldenGate and configuring a deployment for the target environment.

## Objectives

-	Install the GoldenGate Microservces for Oracle edition for the target environment using the Oracle Universal Installer (OUI) tool



## Required Artifacts

-   SSH keys for source and target servers


### **STEP 1**: Access Cloud Server via Putty

For this lab, Oracle GoldenGate and the Oracle Database sources and targets are contained within one Ravello Cloud image that you will be assigned to. All user interactions will be through a browser (Firefox or Chrome) and Putty) that is installed on your laptop, which was a prerequisite for this workshop. 

**Your instructor will provide the Ravello DNS and IP address for your image**

In this step you will use VNC client to connect with Oracle 18c database environment(Ravello image), to get started with the installation of Oracle GoldenGate Mircoservices Architecture.

-	Log in to the Ravello image of your assigned host, using TigerVNC.
-	In the VNC server field, enter the hostname assigned to you by the hands-on lab staff and port 5901 e.g. {hostname or IP}:5901 , then press Connect.

![](images/100/vnc_login.jpg)

-	Sign on with the following password: Welcome1

![](images/100/vnc_password.jpg)

-	Once the VNC client has connected, you should see a console that looks similar to this:

![](images/100/vnc_screen.jpg)

### **STEP 2**: From the same terminal window, install the GoldenGate Microservices Edition

In this step you will install **the GoldenGate Microservices edition package** in new **"GoldenGate Home"** directory.

-	From the terminal screen change to the **Downloads** directory and unzip the **GoldenGate Microservices software package**:
 
		[oracle@ggma Lab1]$ cd /u01/software/gg/ggma
		[oracle@ggma ggma]$ ll
		total 627756
		-rw-r--r--. 1 oracle oinstall 575594529 Dec 19 17:40 181000_fbo_ggs_Linux_x64_services_shiphome.zip
		[oracle@ggma ggma]$ unzip 181000_fbo_ggs_Linux_x64_services_shiphome.zip -d .

-	Go to the unzipped folder (fbo_ggs_Linux_x64_services_shiphome/Disk1) and execute the **runInstaller** executable:

		oracle@ggma ggma]$ cd fbo_ggs_Linux_x64_services_shiphome/Disk1
		[oracle@ggma Disk1]$ ./runInstaller 

- The following screen should appear:

	![](images/100/Lab001_1.jpg)

- Keep the first option for **"Oracle GoldenGate for Oracle Database 19c (822.0MB)"** and click the **"Next >"** button.

- The path **"/u01/gghome"** entered into the **"Software Location"** field.  Then click on the **"Next"** button.

    ![](images/100/Lab001_2.jpg)

- You will see the installation summary screen.   Review the summary and click on the **"Install"** button.

    ![](images/100/4Lab001_3.jpg)

- Once the installation is complete, you will end up on the Finish page. At this point, you
can click the Close button to exit the installation wizard.

	![](images/100/Lab001_4.JPG)
	

- You should now be complete with **the GoldenGate Microservices for Oracle software installation**.

Testing done.

You have completed lab 100! Great Job!

