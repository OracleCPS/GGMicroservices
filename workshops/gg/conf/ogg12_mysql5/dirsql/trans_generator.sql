/*
   Simulate an online banking application
*/

USE amea;

DROP PROCEDURE if exists trans_generator_dev;

delimiter $$ 

CREATE PROCEDURE trans_generator_dev()

BEGIN

  DECLARE v_MainLoop        MEDIUMINT;
  DECLARE v_Acct            INT;
  DECLARE v_Branch          INT;
  DECLARE v_Teller          INT;
  DECLARE v_BranchATM       NUMERIC(1);
  DECLARE v_TransId         BIGINT;
  DECLARE v_TransAmt        DECIMAL(18,2);
  DECLARE v_Trans           VARCHAR(5);
  DECLARE v_Ctr             NUMERIC(2);

  SET v_MainLoop = 1;
  SET v_Ctr = 1;
  WHILE (v_MainLoop <= 5000) DO
    /* Select a random account number */ 
    SELECT x.ACCOUNT_NUMBER INTO v_Acct FROM ( SELECT ACCOUNT_NUMBER FROM account ORDER BY RAND()) AS x LIMIT 1;
    
    /* Generate a transaction id number */
    SELECT floor(1000 + (rand() * 99998999)) INTO v_TransId FROM dual;
    
    /* Randomly get the transaction type */
    SELECT x.TRANS INTO v_Trans FROM ( SELECT TRANS FROM trans_type ORDER BY RAND()) AS x LIMIT 1;
    
    START TRANSACTION;   
    CASE v_Trans
      WHEN  'ATMCR'  THEN      /* ATM Deposit */
          /* Randomly select a branch */
          SELECT x.BRANCH_NUMBER INTO v_Branch FROM ( SELECT BRANCH_NUMBER FROM branch ORDER BY RAND()) AS x LIMIT 1;
          
          /* Randomly select an ATM */
          SELECT floor(1 + (rand() * 2)) INTO v_BranchATM FROM dual;
          
          /* Generate a deposit amount */
          SELECT floor(50 + (rand() * 49950)) INTO v_TransAmt FROM dual;
          
          /* Insert into the account_trans and branch_atm tables, then update the account table current balance */
          INSERT INTO account_trans values (v_Acct, v_TransId, CURRENT_TIMESTAMP, 'CR', CONCAT('Branch ',v_Branch,' ATM Deposit'), v_TransAmt);
          INSERT INTO branch_atm values (v_Branch, v_BranchATM, v_TransId, v_Acct, CURRENT_TIMESTAMP, 'CR', v_TransAmt);
          UPDATE account set ACCOUNT_BALANCE = ACCOUNT_BALANCE + v_TransAmt where ACCOUNT_NUMBER = v_Acct;
          
      WHEN  'ATMDB'  THEN     /* ATM Withdrawal */
          /* Randomly select a branch */
          SELECT x.BRANCH_NUMBER INTO v_Branch FROM ( SELECT BRANCH_NUMBER FROM branch ORDER BY RAND()) AS x LIMIT 1;
          
          /* Randomly select an ATM */
          SELECT floor(1 + (rand() * 2)) INTO v_BranchATM FROM dual;
          
          /* Generate a withdrawal amount */
          SELECT floor(20 + (rand() * 280)) INTO v_TransAmt FROM dual;
          
          /* Insert into the account_trans and branch_atm tables, then update the account table current balance */
          INSERT INTO account_trans values (v_Acct, v_TransId, CURRENT_TIMESTAMP, 'DB', CONCAT('Branch ',v_Branch,' ATM Withdrawal'), v_TransAmt);
          INSERT INTO branch_atm values (v_Branch, v_BranchATM, v_TransId, v_Acct, CURRENT_TIMESTAMP, 'DB', v_TransAmt);
          UPDATE account set ACCOUNT_BALANCE = ACCOUNT_BALANCE - v_TransAmt where ACCOUNT_NUMBER = v_Acct;      
          
      WHEN  'IHCR'  THEN       /* Deposit at Teller */
          /* Randomly select a branch */
          SELECT x.BRANCH_NUMBER INTO v_Branch FROM ( SELECT BRANCH_NUMBER FROM branch ORDER BY RAND()) AS x LIMIT 1;
          
          /* Randomly select a teller assigned to this branch */
          SELECT x.TELLER_NUMBER INTO v_Teller FROM ( SELECT TELLER_NUMBER FROM teller WHERE TELLER_BRANCH = v_Branch ORDER BY RAND()) AS x LIMIT 1;
          
          /* Generate a deposit amount */
          SELECT floor(5 + (rand() * 149995)) INTO v_TransAmt FROM dual;
          
          /* Insert into the account_trans and teller_trans tables, then update the account table current balance */
          INSERT INTO account_trans values (v_Acct, v_TransId, CURRENT_TIMESTAMP, 'CR', CONCAT('Branch ',v_Branch,' Deposit with Teller ',v_Teller), v_TransAmt);
          INSERT INTO teller_trans values (v_Teller,  v_TransId, v_Acct, CURRENT_TIMESTAMP, 'CR', v_TransAmt);
          UPDATE account set ACCOUNT_BALANCE = ACCOUNT_BALANCE + v_TransAmt where ACCOUNT_NUMBER = v_Acct;
                
      WHEN  'IHDB'  THEN      /* Withdrawal at Teller */
           /* Randomly select a branch */
          SELECT x.BRANCH_NUMBER INTO v_Branch FROM ( SELECT BRANCH_NUMBER FROM branch ORDER BY RAND()) AS x LIMIT 1;
          
          /* Randomly select a teller assigned to this branch */
          SELECT x.TELLER_NUMBER INTO v_Teller FROM ( SELECT TELLER_NUMBER FROM teller WHERE TELLER_BRANCH = v_Branch ORDER BY RAND()) AS x LIMIT 1;
          
          /* Generate a withdrawal amount */
          SELECT floor(5 + (rand() * 149995)) INTO v_TransAmt FROM dual;
          
          /* Insert into the account_trans and teller_trans tables, then update the account table current balance */
          INSERT INTO account_trans values (v_Acct, v_TransId, CURRENT_TIMESTAMP, 'DB', CONCAT('Branch ',v_Branch,' Withdrawal with Teller ',v_Teller), v_TransAmt);
          INSERT INTO teller_trans values (v_Teller,  v_TransId, v_Acct, CURRENT_TIMESTAMP, 'DB', v_TransAmt);
          UPDATE account set ACCOUNT_BALANCE = ACCOUNT_BALANCE - v_TransAmt where ACCOUNT_NUMBER = v_Acct;
               
      WHEN  'POS'  THEN       /* Point of Sale purchase */
           /* Generate a purchase amount */
          SELECT floor(1 + (rand() * 1499)) INTO v_TransAmt FROM dual;
          /* Insert into the account_trans, then update the account table current balance */
          INSERT INTO account_trans values (v_Acct, v_TransId, CURRENT_TIMESTAMP, 'POS', 'Point Of Sale card present purchase', v_TransAmt);
          UPDATE account set ACCOUNT_BALANCE = ACCOUNT_BALANCE - v_TransAmt where ACCOUNT_NUMBER = v_Acct;     
    END CASE;
    COMMIT;
    
    /* Every 25 transactions insert a new account */
    IF v_Ctr = 25 THEN
      /* Get the last account number inserted into account */
      SELECT MAX(ACCOUNT_NUMBER) INTO v_Acct from account;
      SET v_Acct = v_Acct + 1;
      
      /* Generate an initial account balance */
      SELECT floor(1 + (rand() * 9999)) INTO v_TransAmt FROM dual;
      IF v_TransAmt < 0 THEN
        SET v_TransAmt = v_TransAmt * -1;
      END IF;
      
      /* Insert a row into the account table */
      START TRANSACTION;
         INSERT INTO account values (v_Acct, v_TransAmt);
      COMMIT;
      /* Reset v_Ctr */
      SET v_Ctr = 1;    
    ELSE
      SET v_Ctr = v_Ctr + 1;
    END IF;

    SET v_MainLoop = v_MainLoop + 1;
    
  END WHILE; /* Main Loop */
END$$

delimiter ;

call trans_generator_dev();

EXIT



