SET SERVEROUTPUT ON
DECLARE
  v_cnt  number(11);


BEGIN
  SELECT count(*) INTO v_cnt FROM AMER.ACCOUNT;
  dbms_output.put_line('ACCOUNT => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM AMER.ACCOUNT_TRANS;
  dbms_output.put_line('ACCOUNT_TRANS => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM AMER.TELLER_TRANS;
  dbms_output.put_line('TELLER_TRANS => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM AMER.BRANCH_ATM;
  dbms_output.put_line('BRANCH_ATM => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM AMER.BRANCH;
  dbms_output.put_line('BRANCH => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM AMER.TELLER;
  dbms_output.put_line('TELLER => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM AMER.TRANS_TYPE;
  dbms_output.put_line('TRANS_TYPE => '|| v_cnt);
END;
/
EXIT;

