![](images/500/Lab500_1.PNG)

Update January 14, 2019

## Working with REST API
## Introduction

In this lab, you will take a look at how to pull a list of services from Oracle GoldenGate using the REST APIs (Curl Commands). 

Steps:
1. Open a command window (Right mouse click – Open Terminal)

2. Create a json file for building an integrated   extract .

![](images/500/extract_add.PNG)

3. Start the change-capture extract using the Curl Command, which would start the extract with begin-now option.

![](images/500/2.PNG)

4. After the command is executed successfully, the command output looks like this:

![](images/500/3.PNG)

![](images/500/4.PNG)

5. On the Goldengate Microservices Console, under the Admin Server you can see the Extract has been started and running .

![](images/500/4.PNG)

6. A path needs to be  created to send the transaction of data from the Extract to the Replicat. You can create a new path by adding configuration  in JSON file.

![](images/500/5.PNG)

7. You can execute the following curl command to add the PATH to send data from Extract to replicat.

![](images/500/6.PNG)

8. Once the command is executed successfully, you can check on Goldengate Microservices Web Console under Distribution Server for the PATH created  and its Running Status.

![](images/500/7.PNG)

9. Next Step is to configure replicat on target which can be done by specifying the various configuration parameters for the Replicat in a JSON file as shown below:

![](images/500/8.PNG)

10. In this Step, You just need to configure and create the Replicat and do not start it (we will Start it at specific CSN after the export/import Job is done). Using the curl command we can add the replicat.

![](images/500/9.PNG)

11. Now it is time to get the current scn of the source database .So that all the  transactions after this particular CSN are only captured & Replicated (i.e we have to capture only those transactions that occur after the export Job)

SQL> select current_scn from v$database;

12. We need to create a JSON file to alter the Change-Capture Replicat at a particular CSN.

![](images/500/10.PNG)

13. We finally need to start the replicat after the Export/import Job has finished successfully on target.We use the following Curl command to start the replicat, which refers to the JSON file created in last step.

![](images/500/11.PNG)

14. Once the command is executed successfully you can crosscheck the status of the Replicat on Goldengate Microservices Web Console under the Admin Server of the Target.

![](images/500/12.PNG)


You have completed lab 500!   **Great Job!**


 








