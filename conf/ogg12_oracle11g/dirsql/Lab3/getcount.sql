SET SERVEROUTPUT ON
DECLARE
  v_cnt  number(11);


BEGIN
  SELECT count(*) INTO v_cnt FROM CATEGORIES;
  dbms_output.put_line('CATEGORIES => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM CATEGORIES_DESCRIPTION;
  dbms_output.put_line('CATEGORIES_DESCRIPTION => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM CUSTOMERS;
  dbms_output.put_line('CUSTOMERS => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM CUSTOMERS_INFO;
  dbms_output.put_line('CUSTOMERS_INFO => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM CUSTOMERS_LKUP;
  dbms_output.put_line('CUSTOMERS_LKUP => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM NEXT_CUST;
  dbms_output.put_line('NEXT_CUST => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM NEXT_ORDER;
  dbms_output.put_line('NEXT_ORDER => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM ORDERS;
  dbms_output.put_line('ORDERS => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM ORDERS_PRODUCTS;
  dbms_output.put_line('ORDERS_PRODUCTS => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM ORDERS_STATUS_HISTORY;
  dbms_output.put_line('ORDERS_STATUS_HISTORY => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM ORDERS_TOTAL;
  dbms_output.put_line('ORDERS_TOTAL => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM PRODUCTS;
  dbms_output.put_line('PRODUCTS => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM PRODUCTS_DESCRIPTION;
  dbms_output.put_line('PRODUCTS_DESCRIPTION => '|| v_cnt);
  SELECT count(*) INTO v_cnt FROM PRODUCTS_TO_CATEGORIES;
  dbms_output.put_line('PRODUCTS_TO_CATEGORIES => '|| v_cnt);

END;
/
EXIT;





