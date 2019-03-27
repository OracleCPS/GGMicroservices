All code is provided as seen. Further information is provided at

http://www.dominicgiles.com/swingbench.html

A faq is included in this directory

New in 2.6
^^^^^^^^^^
* Java 8 is now the only supported VM
* New JSON benchmark
* New TPC-DS Like benchmark
* New Declarative approach to creating a user defined benchmark
* New SQL Query Editor to create queriers for the user defined benchmark
* New chart rendering engine
* Starting swingbench without a named config file now shows a "Select Benchmark" dialogue
* Many internal fixes
* Normal stats collection estimates percentiles
* The stats files also contain tps,cpu and io readings where available.
* Support for remote connectivity to Oracle Cloud in connection dialogues
* New "SBUti" (Swingbench Utility) to validate benchmarks and scale them up (SH and OE Only at present)
* New "results2pdf" utility to convert results files into pdfs

New in 2.5
^^^^^^^^^^
* Fixed a bug where the wizards struggled with some time zones.
* Fixed a bug where the init() command wasn't called correctly
* Removed unnecessary stacktrace output when invalid command line parameters are used
* Fixed an integer overflow where some stats were reported incorrectly
* Added normal distribution of data to better model real world data in the OE and SH benchmarks
* Added verbose output (-v) to the wizards when run in command line mode to provide better feedback
* Increased the maximum heap use by oewizard and shwizard to 2GB in size
* Updated launch parameters for java to set min and max to avoid unnecessary memory consumption
* Users can now define their own output date format mask for charbench via a swingbench environment variable (see FAQ)
* Wizards in graphical mode now display a warning before data generation if there isn't enough temporary space to generate indexes
* Wizards in graphical mode now display the reason they can't connect to the database
* Generated data is more representative of real world formats
* Charts in overview now display values when moused over
* Support of backgrounding charbench, Unix/Linux only. requires the use of both the -bg swinbench option and "&" operator
* Fixes and improvements to error suppression
* The maximum number of soft partitions that can be specified is limited to 48. Values larger than this cause severe performance degradation. This is being looked into.
* Version 2.0 of the OE benchmark is included (selectable from the wizard).
* Wizards allow you to specify index, compression and partitioning models where supported (command line and GUI)
* All scripts and variables used by wizards are listed in the configuration file
* Benchmark version can be specified on the command line
* Fixed an issue where specifying max Y values in charts was ignored
* Support for choosing whether commits are executed client or server side in the SOE Benchmark -D CommitClientSide=true
* Wizards recommend a default size for the benchmarks based on the size of the SGA
* The customers and supplementary_demographics table are now range partitioned in the SH schema if the range portioned option is specified
* New overview chart parameter (config file only) <MinimumValue> allows you specify what YValue a chart will start at
* Wizards allow the creation of schemas with or without indexes
* The sh schema now allows a partitioned or non partitioned schema
* Updated XML infrastructure
* Removed unneeded libraries and reduced size of distribution
* Errors in transactions can now be reported via the -v errs command line option
* Tidied up error reporting. Errors should be reported without exception stacks unless running in debug mode
* Fixed a problem where it wasn't possible to restart a benchmark run when using connection pooling
* Improved stats
* Fixed a problem when "full" stats weren't saved to the results file when a collection window was specified (-bs and -be)
* Added new transactions to sh benchmark
* Percentiles now report 10th to 90th percentiles instead of just 25th,50th and 75th percentile
* Added a new command line option to allow users to change stats collection target.
* Added new commands to coordinator to make it simpler to use
   * Changed -stop to -kill to better indicate what it does
   * Changed -halt to -stop to indicate what it does
   * Added -stopall to stop all attached clients
   * Added -runall to start all attached clients
   * Added -stats to enable all display aggregated transaction rates of all attached clients



New in 2.4
^^^^^^^^^^
* New SH wizard
* New highly threaded benchmark builds for the OE and SH benchmarks
* New standard sizings for SOE and SH (1GB,10GB,100GB,1TB)
* Improved scalability of the SOE benchmark
* Oracle UCP connections
* New CPU monitor architecture (uses ssh instead of agent)
* Update look and feel on Overview charts (more coming)
* Configuration free install (Simply ensure Java is your path)


New in 2.3
^^^^^^^^^^^
* Update to frontend of "minibench"
* New simple "Stress Test" benchmark for both Oracle and TimesTen
* New "Sales History" DSS benchmark (requires datagenerator)
* TimesTen support
* User defineable run time 
* Better statistics in report 
* Benchmark comparison tool
* Swingbench can logon/logoff users between transactions (experimental)
* Clusteroverview command line parameters
* Clusteroverview can now run automatically and for a period of time.
* Minor changes to swingconfig.xml
* Collection of system stats
* Timings included on x-axis of cpu and transaction overview
* Transactions per second output for charbench
* All configuration parameters now editable from frontend
* Update overview chart includes disk I/O
* One off or timed "Job" support
* Ability to specify position of minibench and clusteroverview
* 11g support

swingbench Install
^^^^^^^^^^^^^^^^^^
Unizip the swingbench<version number>.zip file

Change into the newly created swingbench directory and then either the "bin" directory
for Linux/Unix or the "winbin" for windows systems.

Ensure java (1.6 or later) is in your executable path.

You should then be able to run swingbench or any of the wizards.
