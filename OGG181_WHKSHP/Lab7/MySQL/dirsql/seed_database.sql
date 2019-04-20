/*
     Seed the branch and teller lookup tables with these values
       ATM Transaction types: 'ATMCR', 'ATMDB', 'POS', 'IHCR', 'IHDB'
       Number of accounts: 1000
       Starting account balance: Random up to $10000
       Number of branches: 40
       Tellers per branch: 20
*/

USE amea;

START TRANSACTION;
TRUNCATE TABLE account;
TRUNCATE TABLE account_trans;
TRUNCATE TABLE branch;
TRUNCATE TABLE teller;
TRUNCATE TABLE teller_trans;
TRUNCATE TABLE branch_atm;
TRUNCATE TABLE trans_type;
INSERT INTO trans_type values(1,'ATMCR');
INSERT INTO trans_type values(2,'ATMDB');
INSERT INTO trans_type values(3,'POS');
INSERT INTO trans_type values(4,'IHCR');
INSERT INTO trans_type values(5,'IHDB');
COMMIT;

DROP PROCEDURE if exists seed_dev;

delimiter $$

CREATE PROCEDURE seed_dev()

BEGIN

  DECLARE v_LowBal   decimal(3,2);
  DECLARE v_HiBal    decimal(7,2);
  DECLARE v_RetBal   decimal(7,2);
  DECLARE v_Zip      int;
  DECLARE v_LastTell int;   
  DECLARE v_Counter  int;
  DECLARE v_CounterB int;
  DECLARE v_CounterT int;

  set v_LowBal = 1.00;
  set v_HiBal = 10000.00;
  
  set v_Counter = 1;
  WHILE (v_Counter <= 10000) DO
     SELECT floor(1 + (rand() * 9999)) INTO v_RetBal;
     START TRANSACTION;
        INSERT INTO account values(v_Counter, v_RetBal);
     COMMIT;
     SET v_Counter = v_Counter + 1;
  END WHILE;
  
  set v_CounterB = 1;
  set v_LastTell = 1;
  
  WHILE (v_CounterB <= 40) DO  
     SELECT floor(80000 + (rand() * 9999)) INTO v_Zip;
     START TRANSACTION;
        INSERT INTO branch values(v_CounterB, v_Zip);
     COMMIT;
         
     set v_CounterT = 1;
  
     WHILE (v_CounterT <= 20) DO
        START TRANSACTION;
           INSERT INTO teller values(v_LastTell, v_CounterB);
        COMMIT;
        SET v_CounterT = v_CounterT + 1;
        SET v_LastTell = v_LastTell + 1;
     END WHILE;

     SET v_CounterB = v_CounterB + 1;
  END WHILE;
  
END$$

delimiter ;

call seed_dev();

EXIT
  
