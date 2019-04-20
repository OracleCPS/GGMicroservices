/*
                Script to drop the source database tables
  
  This will simulate a banking database used with an OLTP application
  
*/
USE amea;

drop table if exists account;

drop table if exists account_trans;
  
drop table if exists branch;

drop table if exists teller;   

drop table if exists teller_trans;

drop table if exists branch_atm;

drop table if exists trans_type;

EXIT
