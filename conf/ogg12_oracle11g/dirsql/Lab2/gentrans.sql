/*
   Simulate an online order entry (web store) application
*/

SET VERIFY OFF;
SET DEFINE '&';
PROMPT How many orders?(Default = 500) ;
ACCEPT lpctr DEFAULT '500';
 
DECLARE
  v_MainLoop    NUMBER(4);
  v_ProdLoop    NUMBER(4);
  v_RdmCust     NUMBER(11);
  v_CustId      NUMBER(11);
  v_NumProds 	NUMBER(4);
  v_ProdId      NUMBER(11);
  v_ProdCost    NUMBER(15,4);
  v_ProdQty     NUMBER(4);
  v_ProdName    VARCHAR2(64);
  v_ProdModl    VARCHAR2(12);
  v_NumProd     NUMBER(4);
  v_OrdId       NUMBER(11);
  v_OrdProdId   NUMBER(11);
  v_OrdNm       VARCHAR2(255);
  v_CustFnm     VARCHAR2(255);
  v_CustLnm     VARCHAR2(255);
  v_CustEm      VARCHAR2(255);
  v_CustCom     VARCHAR2(255);
  v_CustTel     VARCHAR2(255);
  v_CustSx      CHAR(1);
  v_CustStNum   NUMBER(4);
  v_CustSt      VARCHAR2(255);
  v_CustCity    VARCHAR2(255);
  v_CustState   CHAR(2);
  v_CustZip     NUMBER(5);
  v_Payment     VARCHAR2(255);
  v_CCType      VARCHAR2(20);
  v_CCNum       VARCHAR2(32);
  v_CCExpr      VARCHAR2(4);
  v_Ctr         NUMBER(2) DEFAULT 1;


BEGIN

  FOR v_MainLoop IN 1 .. &lpctr LOOP
  
    /* Generate a random customer number */
         SELECT round(dbms_random.value(100001, 110000)) INTO v_RdmCust FROM dual;
    
        
        /* Check if existing customer */
        SELECT COUNT(*) INTO v_CustId FROM CUSTOMERs WHERE customers_id = v_RdmCust;
    
        CASE v_CustId
         WHEN '0' THEN
             /* Not a current customer, generate new customer info */
             v_CustId := v_RdmCust;
    
             SELECT round(dbms_random.value(1, 36)) INTO v_RdmCust FROM dual;
             SELECT customers_firstname INTO v_CustFnm from customers_lkup where lkup_id = v_RdmCust;
    
             SELECT round(dbms_random.value(1, 36)) INTO v_RdmCust FROM dual;
             SELECT customers_lastname INTO v_CustLnm from customers_lkup where lkup_id = v_RdmCust;
    
             SELECT round(dbms_random.value(1, 36)) INTO v_RdmCust FROM dual;
             SELECT customers_gender INTO v_CustSx from customers_lkup where lkup_id = v_RdmCust;
    
             /* Build an email address */
             v_CustEm := CONCAT (v_CustFnm, v_CustLnm);
             v_CustCom := CONCAT ('@', v_CustLnm);
             v_CustCom := CONCAT (v_CustCom, '.com');
             v_CustEm := CONCAT (v_CustEm, v_CustCom);
            
             /* Generate a telephone number */
             SELECT SUBSTR (dbms_random.value(1111111111, 9999999999), 1, 10) INTO v_CustTel FROM dual;
    
             /* Insert the new customer */
             INSERT INTO customers values (v_CustId,v_CustSx,v_CustFnm,v_CustLnm,v_CustEm,1,v_CustTel,'','Password','0');
             INSERT INTO customers_info VALUES (v_CustId,CURRENT_TIMESTAMP,1,CURRENT_TIMESTAMP,NULL,0);
             COMMIT;
    
         WHEN '1' THEN
             /* Get customer info from database */
             v_CustId := v_RdmCust;
             
             SELECT customers_firstname into v_CustFnm FROM customers WHERE customers_id = v_CustId;
             SELECT customers_lastname into v_CustLnm FROM customers WHERE customers_id = v_CustId;
             SELECT customers_email_address into v_CustEm FROM customers WHERE customers_id = v_CustId;
             SELECT customers_telephone into v_CustTel FROM customers WHERE customers_id = v_CustId;
    
             UPDATE customers_info SET customers_info_last_logon = CURRENT_TIMESTAMP, customers_info_number_logons = customers_info_number_logons + 1 WHERE customers_info_id = v_CustId;
             COMMIT;
    END CASE;

    /* Order some stuff */

    /* Build the customer info */
    v_OrdNm := CONCAT (v_CustFnm, ' ');
    v_OrdNm := CONCAT (v_OrdNm, v_CustLnm);
    SELECT dbms_random.value(1, 9999) INTO v_CustStNum FROM dual;
    SELECT dbms_random.value(10000, 99999) INTO v_CustZip FROM dual;
    SELECT dbms_random.value(1, 36) INTO v_RdmCust FROM dual;
    SELECT customers_street INTO v_CustSt from customers_lkup where lkup_id = v_RdmCust;
    SELECT dbms_random.value(1, 36) INTO v_RdmCust FROM dual;
    SELECT customers_city INTO v_CustCity from customers_lkup where lkup_id = v_RdmCust;
    SELECT dbms_random.value(1, 36) INTO v_RdmCust FROM dual;
    SELECT customers_state INTO v_CustState from customers_lkup where lkup_id = v_RdmCust;

    v_CustStNum := CONCAT (v_CustStNum, ' ');
    v_CustSt := CONCAT (v_CustStNum, v_CustSt);

    /* Determine payment method */

    SELECT dbms_random.value(1, 3) INTO v_Ctr FROM dual;
    CASE v_Ctr
     WHEN '1' THEN
      v_Payment := 'Cash on Delivery';
      v_CCType := '';
      v_CCNum := '';
      v_CCExpr := '';
     WHEN '2' THEN
      v_Payment := 'Credit Card';
      SELECT dbms_random.value(1, 3) INTO v_Ctr FROM dual;
      CASE v_Ctr
       WHEN '1' THEN v_CCType := 'VISA';
       WHEN '2' THEN v_CCType := 'MasterCard';
       WHEN '3' THEN v_CCType := 'American Express';
       WHEN '4' THEN v_CCType := 'Discover';
      END CASE;
      SELECT SUBSTR (dbms_random.value(1000000000000000, 9999999999999999), 1, 16) INTO v_CCNum FROM dual;  
      SELECT SUBSTR (dbms_random.value(01, 12), 1, 2) INTO v_CCExpr FROM dual;  
      SELECT SUBSTR (dbms_random.value(12, 25), 1, 2) INTO v_Ctr FROM dual; 
      v_CCExpr := CONCAT (v_CCExpr, v_Ctr);
     WHEN '3' THEN
      v_Payment := 'EPay';
      v_CCType := '';
      v_CCNum := '';
      v_CCExpr := '';
    END CASE;
    /* Get the order number */
    SELECT orders_id INTO v_OrdId from next_order;
    UPDATE next_order SET orders_id = orders_id + 1;
    COMMIT;

    /* Record the order */
    INSERT INTO orders VALUES (v_OrdId,v_CustId,v_OrdNm,'',v_CustSt,'',v_CustCity,v_CustZip,v_CustState,'United States',v_CustTel, v_CustEm,2,v_OrdNm,'',v_CustSt,'',v_CustCity,v_CustZip,v_CustState,'United States',2,v_OrdNm,'',v_CustSt,'', v_CustCity,v_CustZip,v_CustState,'United States',2,v_Payment,v_CCType,v_OrdNm,v_CCNum,v_CCExpr,NULL, current_timestamp,1,NULL,'USD','1.000000');
COMMIT;

    /*Generate a random number of products per order */
    SELECT dbms_random.value(1, 25) INTO v_NumProd FROM dual;
    SELECT MAX(orders_products_id) INTO v_OrdProdId from orders_products where orders_id >= 100000000;
    FOR v_ProdLoop IN 1 .. v_NumProd LOOP
      SELECT products_id INTO v_ProdId FROM ( SELECT products_id FROM products ORDER BY dbms_random.value ) WHERE rownum = 1;
      SELECT products_quantity, products_price, products_model INTO v_ProdQty, v_ProdCost, v_ProdModl from products where products_id = v_ProdId;
      SELECT products_name INTO v_ProdName from products_description where products_id = v_ProdId;

      /* Generate a random number of quantity ordered for this product */
      SELECT dbms_random.value(1, 99) INTO v_NumProds FROM dual;
      
      /* Record the order line item */
      v_OrdProdId := v_OrdProdId + 1;
      INSERT INTO orders_products VALUES (v_OrdProdId,v_OrdId,v_ProdId,v_ProdModl,v_ProdName,v_ProdCost,v_ProdCost*v_NumProds,0,v_NumProds);
      COMMIT;

      /* Reduce the number of quantity on hand */
      IF v_ProdQTY - v_NumProds < 1 THEN
       UPDATE products SET products_quantity = 0, products_date_available = (SELECT add_months(SYSDATE, 1) FROM dual) where products_id = v_ProdId;
       COMMIT;
      ELSE
        UPDATE products SET products_quantity = products_quantity - v_NumProds, products_last_modified = current_timestamp where products_id = v_ProdId;
      END IF;
    END LOOP;
    SELECT MAX(orders_status_history_id) INTO v_OrdProdId from orders_status_history;
    INSERT INTO orders_status_history VALUES (v_OrdProdId,v_OrdId,1,current_timestamp,1,'Order received, customer notified');
    COMMIT;
  END LOOP; 
END;
/
EXIT;

