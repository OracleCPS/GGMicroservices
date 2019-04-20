/*
                Script to create the source database tables
  
  This will simulate a banking database used with an OLTP application
  
*/
USE amea;

drop table if exists account;
create table account (
  account_number int,
  account_balance decimal(38,2),
  primary key (account_number))
  ENGINE=InnoDB;

drop table if exists account_trans;
create table account_trans (
  account_number int,
  trans_number bigint,
  account_trans_ts timestamp,
  account_trans_type varchar(3),
  account_trans_loc varchar(50),
  account_trans_amt decimal(18,2),
  primary key (account_number, trans_number, account_trans_ts))
  ENGINE=InnoDB;
  
drop table if exists branch;
create table branch (
  branch_number int,
  branch_zip numeric(5),
  primary key ( branch_number ))
  ENGINE=InnoDB;  

drop table if exists teller;   
create table teller (
  teller_number	int,
  teller_branch	int,
  primary key (teller_number))
  ENGINE=InnoDB;

drop table if exists teller_trans;
create table teller_trans (
  teller_number	int,
  trans_number bigint,
  account_number int,
  teller_trans_ts timestamp,
  teller_trans_type char(2),
  teller_trans_amt decimal(18,2),
  primary key (teller_number, trans_number, teller_trans_ts))
  ENGINE=InnoDB;

drop table if exists branch_atm;
create table branch_atm (
  branch_number	int,
  atm_number smallint,
  trans_number bigint,
  account_number int,
  atm_trans_ts timestamp,
  atm_trans_type char(2),
  atm_trans_amt decimal(18,2),
  primary key (branch_number, atm_number, trans_number, atm_trans_ts))
  ENGINE=InnoDB;

drop table if exists trans_type;
create table trans_type (
  trans_id smallint,
  trans varchar(5),
  primary key (trans_id))
  ENGINE=InnoDB;

EXIT
