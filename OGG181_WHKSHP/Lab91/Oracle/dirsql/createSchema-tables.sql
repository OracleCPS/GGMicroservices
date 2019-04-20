create user mysqltarget identified by Welcome1;

Grant DBA to mysqltarget;
drop table mysqltarget.account;
create table mysqltarget.account (
  account_number    	number(10,0),
  account_balance	  	decimal(38,2),
  primary key (account_number)
  using index
);

drop table mysqltarget.account_trans;
create table mysqltarget.account_trans (
  account_number		number(10,0),
  trans_number		number(18,0),
  account_trans_ts		timestamp(6),
  account_trans_type	varchar2(3),
  account_trans_loc		varchar2(50),
  account_trans_amt		decimal(18,2),
  primary key (account_number, trans_number, account_trans_ts)
  using index
);
  
drop table mysqltarget.branch;
create table mysqltarget.branch (
  branch_number   		number(10,0),
  branch_zip      		number(5),
  primary key ( branch_number )
  using index
);  

drop table mysqltarget.teller;   
create table mysqltarget.teller (
  teller_number		number(10,0),
  teller_branch		number(10,0),
  primary key (teller_number)
  using index
);

drop table mysqltarget.teller_trans;
create table mysqltarget.teller_trans (
  teller_number		number(10,0),
  trans_number		number(18,0),
  account_number		number(10,0),
  teller_trans_ts		timestamp(6),
  teller_trans_type		char(2),
  teller_trans_amt		decimal(18,2),
  primary key (teller_number, trans_number, teller_trans_ts)
  using index
);

drop table mysqltarget.branch_atm;
create table mysqltarget.branch_atm (
  branch_number		decimal (10,0),
  atm_number		smallint,
  trans_number		number(18,0),
  account_number		number(10,0),
  atm_trans_ts		timestamp(6),
  atm_trans_type		char(2),
  atm_trans_amt		decimal(18,2),
  primary key (branch_number, atm_number, trans_number, atm_trans_ts)
  using index
);  

drop table mysqltarget.trans_type;
create table mysqltarget.trans_type (
  trans_id smallint,
  trans varchar2(5),
  primary key (trans_id)
  using index
);
