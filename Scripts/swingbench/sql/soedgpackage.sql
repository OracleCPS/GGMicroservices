drop package ORDERENTRY;


create or replace
PACKAGE ORDERENTRY   
AS   
  /*   
  * Package     : Order Entry Package Spec  
  * Version     : 1.2  
  * Author      : Dominic Giles   
  * Last Update : 12 June 2011   
  * Description : Used in stress test of Oracle by swingbench test harness;   
  *   
  */
PROCEDURE setPLSQLCOMMIT(commitInPLSQL varchar2);  
FUNCTION browseProducts   
  (   
    cust_id customers.customer_id%type,   
    min_sleep INTEGER,   
    max_sleep INTEGER)   
  RETURN varchar;   
FUNCTION newOrder   
  (   
    cust_id customers.customer_id%type,   
    min_sleep INTEGER,   
    max_sleep INTEGER)   
  RETURN varchar;   
FUNCTION newCustomer   
  (   
    fname customers.cust_first_name%type,   
    lname customers.cust_last_name%type,   
    nls_lang customers.nls_language%type,   
    nls_terr customers.nls_territory%type,   
    min_sleep INTEGER,   
    max_sleep INTEGER)   
  RETURN varchar;   
FUNCTION processOrders   
  (   
    min_sleep INTEGER,   
    max_sleep INTEGER)   
  return varchar;  
function processOrders   
  ( warehouse orders.warehouse_id%type,  
    min_sleep integer,   
    max_sleep integer  
    )   
  RETURN varchar;   
FUNCTION browseAndUpdateOrders   
  (   
    cust_id customers.customer_id%type,   
    min_sleep INTEGER,   
    max_sleep INTEGER)   
  RETURN varchar;
FUNCTION SalesRepsQuery   
  (   
    salesRep orders.sales_rep_id%type,    
    min_sleep integer,    
    max_sleep integer
    )   
  RETURN varchar;
FUNCTION WarehouseActivityQuery   
  (   
    warehouseid orders.warehouse_id%type,    
    min_sleep integer,    
    max_sleep integer
    )   
  RETURN varchar;
FUNCTION WarehouseOrdersQuery   
  (   
    warehouseid orders.warehouse_id%type,    
    min_sleep integer,    
    max_sleep integer
    )   
  RETURN varchar;
TYPE prod_rec   
IS   
  RECORD   
  (   
    PRODUCT_ID products.PRODUCT_ID%TYPE,   
    product_name products.product_NAME%TYPE,   
    PRODUCT_DESCRIPTION products.PRODUCT_DESCRIPTION%TYPE,   
    CATEGORY_ID products.CATEGORY_ID%TYPE,   
    WEIGHT_CLASS products.WEIGHT_CLASS%TYPE,   
    WARRANTY_PERIOD products.WARRANTY_PERIOD%TYPE,   
    SUPPLIER_ID products.SUPPLIER_ID%TYPE,   
    PRODUCT_STATUS products.PRODUCT_STATUS%TYPE,   
    LIST_PRICE products.LIST_PRICE%TYPE,   
    MIN_PRICE products.MIN_PRICE%TYPE,   
    CATALOG_URL products.CATALOG_URL%TYPE,   
    QUANTITY_ON_HAND inventories.QUANTITY_ON_HAND%TYPE);   
TYPE prod_tab   
IS   
  TABLE OF prod_rec INDEX BY PLS_INTEGER;   
TYPE order_rec   
IS   
  RECORD   
  (   
    ORDER_ID orders.ORDER_ID%TYPE,   
    ORDER_MODE orders.ORDER_MODE%TYPE,   
    CUSTOMER_ID orders.CUSTOMER_ID%TYPE,   
    ORDER_STATUS orders.ORDER_STATUS%TYPE,   
    ORDER_TOTAL orders.ORDER_TOTAL%TYPE,   
    SALES_REP_ID orders.SALES_REP_ID%TYPE,   
    PROMOTION_ID orders.PROMOTION_ID%TYPE);   
TYPE order_tab   
IS   
  TABLE OF order_rec INDEX BY PLS_integer;   
type ORDER_ITEM_REC   
IS   
  record   
  (   
    ORDER_ID order_items.ORDER_ID%TYPE,   
    LINE_ITEM_ID order_items.LINE_ITEM_ID%TYPE,   
    PRODUCT_ID order_items.PRODUCT_ID%TYPE,   
    UNIT_PRICE order_items.UNIT_PRICE%TYPE,   
    QUANTITY order_items.QUANTITY%TYPE);   
type order_item_tab   
IS   
  TABLE OF ORDER_ITEM_REC INDEX BY pls_integer;   
type customer_rec   
IS   
  record   
  (   
    CUSTOMER_ID customers.CUSTOMER_ID%TYPE,   
    CUST_FIRST_NAME customers.CUST_FIRST_NAME%TYPE,   
    CUST_LAST_NAME customers.CUST_LAST_NAME%TYPE,   
    NLS_LANGUAGE customers.NLS_LANGUAGE%TYPE,   
    NLS_TERRITORY customers.NLS_TERRITORY%TYPE,   
    CREDIT_LIMIT customers.CREDIT_LIMIT%TYPE,   
    CUST_EMAIL customers.CUST_EMAIL%TYPE,   
    ACCOUNT_MGR_ID customers.ACCOUNT_MGR_ID%TYPE);   
type customer_tab   
IS   
  TABLE OF customer_rec INDEX BY pls_integer; 
type integer_return_array 
is  
  varray(25) of integer;
END; 
/


create or replace
PACKAGE BODY ORDERENTRY AS    
  /*    
  * Package     : Order Entry Package Body    
  * Version     : 1.2   
  * Author      : Dominic Giles    
  * Last Update : 14 June 2011    
  * Description : Used in stress test of Oracle by swingbench test harness;    
  *    
  */    
  MAX_BROWSE_CATEGORY integer := 6;    
  MIN_PROD_ID         integer := 1;    
  MAX_PROD_ID         integer := 1000;    
  SELECT_STATEMENTS   integer := 1;    
  INSERT_STATEMENTS   integer := 2;    
  UPDATE_STATEMENTS   integer := 3;    
  DELETE_STATEMENTS   integer := 4;    
  COMMIT_STATEMENTS   integer := 5;    
  ROLLBACK_STATEMENTS integer := 6;    
  SLEEP_TIME          integer := 7;    
  MIN_CATEGORY        integer := 1;    
  MAX_CATEGORY        integer := 199;    
  MIN_PRODS_TO_BUY    integer := 2;    
  MAX_PRODS_TO_BUY    integer := 6;    
  MIN_WAREHOUSE_ID    integer := 1;    
  MAX_WAREHOUSE_ID    integer := 1000;    
  AWAITING_PROCESSING integer := 4;    
  ORDER_PROCESSED     integer := 10;    
  MAX_CREDITLIMIT     integer := 5000;    
  MIN_CREDITLIMIT     integer := 100;    
  MIN_SALESID         integer := 145;    
  MAX_SALESID         integer := 171;    
  ROW_RETURNS         integer := 15;  
  INST_ID             integer := sys_context('userenv','instance');  
  INFO_ARRAY          integer_return_array := integer_return_array();
  PLSQLCOMMIT         boolean := false;
  procedure setPLSQLCOMMIT(commitInPLSQL varchar2) is
   begin
    if (commitInPLSQL = 'true') then
        PLSQLCOMMIT := true;
    else 
        PLSQLCOMMIT := false;
    end if;
  end setPLSQLCOMMIT;
  procedure oecommit is 
  begin
    if (PLSQLCOMMIT) then
        commit;
    end if;
  end oecommit;
  procedure logon(cust_id customers.customer_id%type) is    
    current_time date;    
    begin    
      dbms_application_info.set_action('logon');    
      select sysdate into current_time from dual;    
      insert into logon values    
      (cust_id, current_time);    
      oecommit;    
      dbms_application_info.set_action(null);    
  end logon;    
  function from_mills_to_secs(value integer) return float is    
    real_value float := 0;    
    begin    
      real_value := value/1000;    
      return real_value;    
      exception    
        when zero_divide then    
          real_value := 0;    
          return real_value;    
  end from_mills_to_secs;    
  procedure sleep(min_sleep integer, max_sleep integer) is    
    sleeptime number := 0; 
    beginSleep timestamp; 
    endSleep timestamp; 
    myseconds number :=0; 
    myminutes number := 0;    
    begin 
      beginSleep := systimestamp; 
      if (max_sleep = min_sleep) then 
        sleeptime := from_mills_to_secs(max_sleep);  
        dbms_lock.sleep(sleeptime); 
      elsif (((max_sleep - min_sleep) > 0) AND (min_sleep < max_sleep)) then     
        sleeptime := dbms_random.value(from_mills_to_secs(min_sleep), from_mills_to_secs(max_sleep));     
        dbms_lock.sleep(sleeptime);     
     end if; 
     endSleep  := systimestamp; 
     myseconds := extract(second from (endSleep-beginSleep)); 
     myminutes := extract(minute from (endSleep-beginSleep)); 
     sleepTime := (myseconds + (myminutes*60))*1000; 
     info_array(SLEEP_TIME) := sleeptime + info_array(SLEEP_TIME);     
  end sleep;    
  procedure init_info_array is    
    begin    
      info_array := integer_return_array();    
      for i in 1..8 loop    
        info_array.extend;    
        info_array(i) := 0;    
      end loop;    
  end init_info_array; 
  function getdmlarrayasstring(info_array integer_return_array) return varchar is  
  result varchar(200) := ''; 
  begin 
    result := info_array(SELECT_STATEMENTS) ||','|| info_array(INSERT_STATEMENTS)||','||info_array(UPDATE_STATEMENTS)||','||info_array(DELETE_STATEMENTS)||','||info_array(COMMIT_STATEMENTS)||','||info_array(ROLLBACK_STATEMENTS)||','||info_array(SLEEP_TIME); 
    return result; 
  end getdmlarrayasstring; 
  procedure increment_selects(num_selects integer) is    
    begin    
      info_array(SELECT_STATEMENTS) := info_array(SELECT_STATEMENTS) + num_selects;    
  end increment_selects;    
  procedure increment_inserts(num_inserts integer) is    
    begin    
      info_array(INSERT_STATEMENTS) := info_array(INSERT_STATEMENTS) + num_inserts;    
  end increment_inserts;    
  procedure increment_updates(num_updates integer) is    
    begin    
      info_array(UPDATE_STATEMENTS) := info_array(UPDATE_STATEMENTS) + num_updates;    
  end increment_updates;    
  procedure increment_deletes(num_deletes integer) is    
    begin    
      info_array(DELETE_STATEMENTS) := info_array(DELETE_STATEMENTS) + num_deletes;    
  end increment_deletes;    
  procedure increment_commits(num_commits integer) is    
    begin    
      info_array(COMMIT_STATEMENTS) := info_array(COMMIT_STATEMENTS) + num_commits;    
  end increment_commits;    
  procedure increment_rollbacks(num_rollbacks integer) is    
    begin    
      info_array(ROLLBACK_STATEMENTS) := info_array(ROLLBACK_STATEMENTS) + num_rollbacks;    
  end increment_rollbacks;    
  Function getProductDetailsByCategory(cat_id in out product_information.category_id%type) return prod_tab is    
    my_product_tab prod_tab;    
    warehouse integer :=  floor(dbms_random.value(MIN_WAREHOUSE_ID, MAX_WAREHOUSE_ID));    
    begin    
      dbms_application_info.set_action('getProductDetailsByCategory');    
      select products.PRODUCT_ID,    
              PRODUCT_NAME,    
              PRODUCT_DESCRIPTION,    
              CATEGORY_ID,    
              WEIGHT_CLASS,    
              WARRANTY_PERIOD,    
              SUPPLIER_ID,    
              PRODUCT_STATUS,    
              LIST_PRICE,    
              MIN_PRICE,    
              CATALOG_URL,    
              QUANTITY_ON_HAND bulk collect    
      INTO my_product_tab    
      from products,    
      inventories    
      where products.category_id = cat_id    
      and inventories.product_id = products.product_id    
      and inventories.warehouse_id = warehouse    
      and rownum < ROW_RETURNS;    
      dbms_application_info.set_action(null);    
      return my_product_tab;    
  end getProductDetailsByCategory;    
  Function getCustomerDetails(cust_id customers.customer_id%type) return customer_tab is    
    my_customer_tab customer_tab;    
    begin    
       dbms_application_info.set_action('getCustomerDetails');    
       select CUSTOMER_ID,    
        CUST_FIRST_NAME,    
        CUST_LAST_NAME,    
        NLS_LANGUAGE,    
        NLS_TERRITORY,    
        CREDIT_LIMIT,    
        CUST_EMAIL,    
        ACCOUNT_MGR_ID bulk collect    
       INTO my_customer_tab    
        from customers    
        where customer_id = cust_id    
        and rownum < ROW_RETURNS;    
      dbms_application_info.set_action(null);    
      return my_customer_tab;    
  end getCustomerDetails;    
  Function getProductDetails(prod_id product_information.product_id%type) return prod_tab is    
    my_product_tab prod_tab;    
    begin    
       dbms_application_info.set_action('getProductDetails');    
       SELECT products.PRODUCT_ID,    
          PRODUCT_NAME,    
          PRODUCT_DESCRIPTION,    
          CATEGORY_ID,    
          WEIGHT_CLASS,    
          WARRANTY_PERIOD,    
          SUPPLIER_ID,    
          PRODUCT_STATUS,    
          LIST_PRICE,    
          MIN_PRICE,    
          CATALOG_URL,    
          QUANTITY_ON_HAND bulk collect    
        INTO my_product_tab    
        FROM products,    
          inventories    
        WHERE products.product_id  = prod_id    
        AND inventories.product_id = products.product_id    
        AND rownum < ROW_RETURNS;    
      dbms_application_info.set_action(null);    
      return my_product_tab;    
  end getProductDetails;    
  Function getOrdersById(ord_id orders.order_id%type) return order_tab is    
    my_orders_tab order_tab;    
    begin    
      dbms_application_info.set_action('getOrdersById');    
      select ORDER_ID,    
            ORDER_MODE,    
            CUSTOMER_ID,    
            ORDER_STATUS,    
            ORDER_TOTAL,    
            SALES_REP_ID,    
            PROMOTION_ID bulk collect    
      into my_orders_tab    
      from orders    
      where order_id = ord_id    
      and rownum < ROW_RETURNS;    
      dbms_application_info.set_action(null);    
      return my_orders_tab;    
  END getOrdersById;    
  Function getOrdersByCustomer(cust_id customers.customer_id%type) return order_tab is    
    my_orders_tab order_tab;    
    begin    
      dbms_application_info.set_action('getOrdersByCustomer');    
      select ORDER_ID,    
            ORDER_MODE,    
            CUSTOMER_ID,    
            ORDER_STATUS,    
            ORDER_TOTAL,    
            SALES_REP_ID,    
            PROMOTION_ID    
      bulk collect    
      into my_orders_tab    
      from orders    
      where customer_id = cust_id    
      and rownum < ROW_RETURNS;    
      dbms_application_info.set_action(null);    
      return my_orders_tab;    
  END getOrdersByCustomer;    
  Function getOrderItemsById(ord_id orders.order_id%type) return order_item_tab is    
    my_order_Item_tab order_item_tab;    
    begin    
      dbms_application_info.set_action('getOrderItemsById');    
      select ORDER_ID,    
        LINE_ITEM_ID,    
        PRODUCT_ID,    
        UNIT_PRICE,    
        QUANTITY    
        bulk collect    
      into my_order_Item_tab    
      from order_items    
      where order_id = ord_id    
      and rownum < ROW_RETURNS;    
      dbms_application_info.set_action(null);    
    return my_order_Item_tab;    
  END getOrderItemsById;    
  function getProductQuantity(prodId product_information.PRODUCT_ID%type, wareId inventories.WAREHOUSE_ID%type) return integer is    
    cursor product_cursor is select  quantity_on_hand    
                             from product_information p, inventories i    
                             where i.product_id = prodId    
                             and i.product_id = p.product_id    
                             and i.warehouse_id = wareId;    
    quantity integer := 0;    
    begin    
      dbms_application_info.set_action('getProductQuantity');    
      open product_cursor;    
      fetch product_cursor into quantity;    
      close product_cursor;    
      dbms_application_info.set_action(null);    
      return quantity;    
  end getProductQuantity;    
  function browseProducts(cust_id customers.customer_id%type,    
                           min_sleep integer,    
                           max_sleep integer) return varchar is    
    customerArray customer_tab;    
    productsArray prod_tab;    
    prodId integer;    
    numOfBrowses integer := 1;    
    begin    
      dbms_application_info.set_module('Browse Products',null);    
      init_info_array();    
      customerArray := getCustomerDetails(cust_id);    
      increment_selects(1);    
      sleep(min_sleep, max_sleep);    
      logon(cust_id);    
      increment_inserts(1); increment_selects(1); increment_commits(1);    
      sleep(min_sleep, max_sleep);    
      numOfBrowses := floor(dbms_random.value(1,MAX_BROWSE_CATEGORY));    
      for i in 1..numOfBrowses    
      loop    
        prodId := floor(dbms_random.value(MIN_PROD_ID, MAX_PROD_ID));    
        productsArray := getProductDetails(prodId);    
        increment_selects(1);    
        sleep(min_sleep, max_sleep);    
      end loop;    
      dbms_application_info.set_module(null,null);    
      return getdmlarrayasstring(info_array);    
      exception when others then    
        rollback;    
        increment_rollbacks(1);    
        dbms_application_info.set_module(null,null);    
        return getdmlarrayasstring(info_array);    
  end browseProducts;    
  function newOrder(cust_id customers.customer_id%type,    
                    min_sleep integer,    
                    max_sleep integer) return varchar is    
    customerArray customer_tab;    
    productsArray prod_tab;    
    numOfBrowses  integer := 1;    
    catId         integer := 1;    
    prodId        integer := 1;    
    prodsToBuy    integer := 1;    
    orderId       orders.order_id%type;    
    warehouse     inventories.warehouse_id%type;    
    quantity      integer := 1;    
    price         float := 1.0;    
    totalPrice    float := 0.0;    
    type prodListType is table of inventories.PRODUCT_ID%type;    
    type warehouseListType is table of inventories.WAREHOUSE_ID%type;    
    type noOrderedListType is table of inventories.QUANTITY_ON_HAND%type;    
    prodList prodListType := prodListType();    
    warehouseList warehouseListType := warehouseListType();    
    noOrderedList noOrderedListType := noOrderedListType();    
    begin    
      dbms_application_info.set_module('New Order',null);    
      init_info_array();    
      customerArray := getCustomerDetails(cust_id);    
      increment_selects(1);    
      sleep(min_sleep, max_sleep);    
      logon(cust_id);    
      increment_inserts(1); increment_selects(1); increment_commits(1);    
      sleep(min_sleep, max_sleep);    
      numOfBrowses := floor(dbms_random.value(1,MAX_BROWSE_CATEGORY));    
      for i in 1..numOfBrowses    
      loop    
        catId := floor(dbms_random.value(MIN_CATEGORY, MAX_CATEGORY));    
        productsArray := getProductDetailsByCategory(catId);    
        increment_selects(1);    
        sleep(min_sleep, max_sleep);    
      end loop;    
      sleep(min_sleep, max_sleep);  
      warehouse := floor(dbms_random.value(min_warehouse_id, max_warehouse_id));  
      insert into orders(order_id, order_date, customer_id, warehouse_id)   
      values (orders_seq.NEXTVAL + inst_id, systimestamp , cust_id, warehouse)  
      returning order_id into orderId;    
      increment_inserts(1);    
      sleep(min_sleep, max_sleep);    
      prodsToBuy := floor(dbms_random.value(MIN_PRODS_TO_BUY, MAX_PRODS_TO_BUY));    
      if (prodsToBuy > productsArray.count) then     
        prodsToBuy := productsArray.count;    
      end if;    
      for i in 1..prodsToBuy    
      loop    
        prodId := productsArray(i).product_id;    
        price := productsArray(i).list_price;    
        sleep(min_sleep, max_sleep);    
        warehouse := floor(dbms_random.value(MIN_WAREHOUSE_ID, MAX_WAREHOUSE_ID));    
        quantity := getProductQuantity(prodId, warehouse);    
        if quantity > 0 then    
          insert into order_items(ORDER_ID, LINE_ITEM_ID, PRODUCT_ID, UNIT_PRICE, QUANTITY)    
          values (orderId, i, prodId, price, 1);    
          increment_inserts(1);    
          prodList.extend; prodList(prodList.count) := prodID;    
          warehouseList.extend; warehouseList(warehouseList.count) := warehouse;    
          noOrderedList.extend; noOrderedList(noOrderedList.count) := 1;    
          totalPrice := totalPrice + price;    
        end if;    
        sleep(min_sleep, max_sleep);    
      end loop;    
      update orders    
      set order_mode = 'online',    
          order_status = floor(dbms_random.value(0, AWAITING_PROCESSING)),    
          order_total = totalPrice    
          where order_id = orderId;    
      increment_updates(1);    
      forall i in prodList.first..prodList.last    
        update inventories    
          set quantity_on_hand = quantity_on_hand - noOrderedList(i)    
          where product_id = prodList(i)    
          and warehouse_id = warehouseList(i);    
      increment_updates(prodList.count);    
      oecommit;    
      increment_commits(1);    
      dbms_application_info.set_module(null,null);    
      return getdmlarrayasstring(info_array);   
      exception when others then    
        rollback;    
        increment_rollbacks(1);    
        dbms_application_info.set_module(null,null);    
        return getdmlarrayasstring(info_array);    
  end newOrder;    
  function newCustomer(fname customers.cust_first_name%type,    
                    lname customers.cust_last_name%type,    
                    nls_lang customers.nls_language%type,    
                    nls_terr customers.nls_territory%type,    
                    min_sleep integer,    
                    max_sleep integer) return varchar is    
    custId integer;    
    customerArray customer_tab;    
    begin    
      dbms_application_info.set_module('New Customer',null);    
      init_info_array();    
      select customer_seq.nextval into custID from dual; -- this could be returned more efficently using returns clause on insert    
      increment_selects(1);    
      insert into customers(customer_id ,cust_first_name ,cust_last_name ,nls_language ,nls_territory ,credit_limit ,cust_email ,account_mgr_id )    
      values (custId,    
              fname,    
              lname,    
              nls_lang,    
              nls_terr,    
              floor(dbms_random.value(MIN_CREDITLIMIT, MAX_CREDITLIMIT)),    
              fname||'.'||lname||'@'||'oracle.com',    
              floor(dbms_random.value(MIN_SALESID, MAX_SALESID)));    
      oecommit;    
      increment_inserts(1); increment_commits(1); 
      sleep(min_sleep, max_sleep);  
      logon(custId);    
      increment_inserts(1); increment_selects(1); increment_commits(1);    
      customerArray := getCustomerDetails(custId);    
      increment_selects(1);    
      dbms_application_info.set_module(null,null);    
      return getdmlarrayasstring(info_array);  
      exception when others then    
        rollback;    
        increment_rollbacks(1);    
        dbms_application_info.set_module(null,null);    
        return getdmlarrayasstring(info_array);  
  end newcustomer;    
  function processorders (warehouse orders.warehouse_id%type,   
                          min_sleep integer,    
                          max_sleep integer   
                          ) return varchar is    
    cursor order_cursor is WITH need_to_process AS    
                          (SELECT order_id,    
                            /* we're only looking for unprocessed orders */    
                            customer_id    
                          FROM orders    
                          where order_status <= 4   
                          and warehouse_id = warehouse  
                          AND rownum         <  10  
                          )    
                        SELECT o.order_id,       
                          oi.line_item_id,       
                          oi.product_id,       
                          oi.unit_price,       
                          oi.quantity,       
                          o.order_mode,       
                          o.order_status,       
                          o.order_total,       
                          o.sales_rep_id,       
                          o.promotion_id,       
                          c.customer_id,       
                          c.cust_first_name,       
                          c.cust_last_name,       
                          c.credit_limit,       
                          c.cust_email,       
                          o.order_date    
                        FROM orders o,    
                          need_to_process ntp,    
                          customers c,    
                          order_items oi    
                        WHERE ntp.order_id = o.order_id    
                        AND c.customer_id  = o.customer_id    
                        and oi.order_id (+) = o.order_id;    
    order_proc_rec order_cursor%rowtype;    
    begin    
    dbms_application_info.set_module('Process Orders',null);    
    init_info_array();    
    open order_cursor;    
    fetch order_cursor into order_proc_rec;    
    increment_selects(1);    
    sleep(min_sleep, max_sleep);    
    update /*+ index(orders, order_pk) */    
    orders    
    set order_status = floor(dbms_random.value(AWAITING_PROCESSING + 1, ORDER_PROCESSED))    
    where order_id = order_proc_rec.order_id;    
    increment_updates(1);    
    oecommit;    
    increment_commits(1);    
    dbms_application_info.set_module(null,null);    
    return getdmlarrayasstring(info_array);   
    exception when others then    
      rollback;    
      increment_rollbacks(1);    
      close order_cursor;    
      dbms_application_info.set_module(null,null);    
      return getdmlarrayasstring(info_array);    
  end processorders;    
  function processOrders (min_sleep integer,    
                          max_sleep integer) return varchar is    
    cursor order_cursor is WITH need_to_process AS    
                          (SELECT order_id,    
                            /* we're only looking for unprocessed orders */    
                            customer_id    
                          FROM orders    
                          WHERE order_status <= 4    
                          AND rownum         <  10    
                          )    
                        SELECT o.order_id,       
                          oi.line_item_id,       
                          oi.product_id,       
                          oi.unit_price,       
                          oi.quantity,       
                          o.order_mode,       
                          o.order_status,       
                          o.order_total,       
                          o.sales_rep_id,       
                          o.promotion_id,       
                          c.customer_id,       
                          c.cust_first_name,       
                          c.cust_last_name,       
                          c.credit_limit,       
                          c.cust_email,       
                          o.order_date    
                        FROM orders o,    
                          need_to_process ntp,    
                          customers c,    
                          order_items oi    
                        WHERE ntp.order_id = o.order_id    
                        AND c.customer_id  = o.customer_id    
                        and oi.order_id (+) = o.order_id;    
    order_proc_rec order_cursor%rowtype;    
    begin    
    dbms_application_info.set_module('Process Orders',null);    
    init_info_array();    
    open order_cursor;    
    fetch order_cursor into order_proc_rec;    
    increment_selects(1);    
    sleep(min_sleep, max_sleep);    
    update /*+ index(orders, order_pk) */    
    orders    
    set order_status = floor(dbms_random.value(AWAITING_PROCESSING + 1, ORDER_PROCESSED))    
    where order_id = order_proc_rec.order_id;    
    increment_updates(1);    
    oecommit;    
    increment_commits(1);    
    dbms_application_info.set_module(null,null);    
    return getdmlarrayasstring(info_array);    
    exception when others then    
      rollback;    
      increment_rollbacks(1);    
      close order_cursor;    
      dbms_application_info.set_module(null,null);    
      return getdmlarrayasstring(info_array);    
  end processOrders;    
  function browseAndUpdateOrders (cust_id customers.customer_id%type,    
                                  min_sleep integer,    
                                  max_sleep integer) return varchar is    
    ordId orders.order_id%type;    
    lineId order_items.line_item_id%type;    
    unitPrice order_items.unit_price%type;    
    selectedLine integer := 1;    
    selectedOrder integer := 1;    
    customerArray customer_tab;    
    orderArray order_tab;    
    orderItemsArray order_item_tab;    
    begin    
      dbms_application_info.set_module('Browse and Update Orders',null);    
      init_info_array();    
      customerArray := getCustomerDetails(cust_id);    
      increment_selects(1);    
      sleep(min_sleep, max_sleep);    
      logon(cust_id);    
      increment_inserts(1); increment_selects(1); increment_commits(1);    
      sleep(min_sleep, max_sleep);    
      orderArray := getOrdersByCustomer(cust_id);    
      increment_selects(1);    
      if orderArray.count > 1 then    
        selectedOrder := floor(dbms_random.value(1, orderArray.count));    
        ordId := orderArray(selectedOrder).order_id;    
        orderItemsArray := getOrderItemsById(ordId);    
        increment_selects(1);    
        selectedLine := floor(dbms_random.value(1, orderItemsArray.count));    
        lineId := orderItemsArray(selectedLine).line_item_id;    
        unitPrice := orderItemsArray(selectedLine).unit_price;    
        update order_items    
        set quantity = quantity + 1    
        where order_items.ORDER_Id = ordId    
        and order_items.LINE_ITEM_ID = lineId;    
        update orders    
        set order_total = order_total + unitPrice    
        where order_Id = ordId;    
        increment_updates(2);    
        oecommit;    
        increment_commits(1);    
      end if;    
      dbms_application_info.set_module(null,null);    
      return getdmlarrayasstring(info_array);    
    exception when others then    
      rollback;    
      increment_rollbacks(1);    
      dbms_application_info.set_module(null,null);    
      return getdmlarrayasstring(info_array);   
  end browseAndUpdateOrders;
  function SalesRepsQuery(salesRep orders.sales_rep_id%type,    
                           min_sleep integer,    
                           max_sleep integer) return varchar is    
    cursor c1 is SELECT tt.ORDER_TOTAL,
          tt.SALES_REP_ID,
          tt.ORDER_DATE,
          customers.CUST_FIRST_NAME,
          customers.CUST_LAST_NAME
        FROM
          (SELECT orders.ORDER_TOTAL,
            orders.SALES_REP_ID,
            orders.ORDER_DATE,
            orders.customer_id,
            rank() Over (Order By orders.ORDER_TOTAL DESC) sal_rank
          FROM orders
          WHERE orders.SALES_REP_ID = salesRep
          ) tt,
          customers
        WHERE tt.sal_rank        <= 10
        AND customers.customer_id = tt.customer_id;
        order_total orders.order_total%type;
        sales_rep_id orders.sales_rep_id%type;
        order_date orders.order_date%type;
        cust_first_name customers.cust_first_name%type;
        cust_last_name customers.cust_last_name%type;        
    begin    
      dbms_application_info.set_module('Sales Rep Query',null);    
      init_info_array();    
      open c1;
      loop
        fetch c1 into order_total,sales_rep_id,order_date,cust_first_name,cust_last_name;
        exit when c1%notfound;
      end loop;
      increment_selects(1);    
      sleep(min_sleep, max_sleep);    
      dbms_application_info.set_module(null,null);    
      return getdmlarrayasstring(info_array);    
      exception when others then       
        dbms_application_info.set_module(null,null);    
        return getdmlarrayasstring(info_array);    
  end SalesRepsQuery;
  FUNCTION WarehouseActivityQuery (warehouseid orders.warehouse_id%type,    
                                    min_sleep integer,    
                                    max_sleep integer
                                  ) return varchar is
    cursor c1 is WITH stage1 AS -- get 12 rows of 5mins
      (SELECT
        /*+ materialize CARDINALITY(12) */
        (rownum*(1/288)) offset
      FROM dual
        CONNECT BY rownum <= 12
      ),
      stage2 AS -- get 12 rows with 2 columns, 1 col lagged behind the other
      (SELECT
        /*+ materialize CARDINALITY(12) */
        lag(offset, 1, 0) over (order by rownum) ostart,
        offset oend
      FROM stage1
      ),
      stage3 AS -- transform them to timestamps
      (SELECT
        /*+ materialize CARDINALITY(12) */
        (systimestamp - ostart) date1,
        (systimestamp - oend) date2
      FROM stage2
      )
      SELECT warehouse_id,
        date1,
        date2,
        SUM(orders.order_total) "Value of Orders",
        COUNT(1) "Number of Orders"
      FROM stage3,
        orders
      WHERE order_date BETWEEN date2 AND date1
      AND warehouse_id = warehouseid
      GROUP BY warehouse_id,
        date1,
        date2
      ORDER BY date1,
        date2 DESC;
    warehouse_id orders.warehouse_id%type;
    date1 orders.order_date%type;
    date2 orders.order_date%type;
    sumoforders orders.order_total%type;
    numberoforders integer;
    begin
      dbms_application_info.set_module('Warehouse Activity Query',null);    
      init_info_array();    
      open c1;
      loop
        fetch c1 into warehouse_id,date1,date2,sumoforders,numberoforders;
        exit when c1%notfound;
      end loop;
      increment_selects(1);    
      sleep(min_sleep, max_sleep);    
      dbms_application_info.set_module(null,null);    
      return getdmlarrayasstring(info_array);    
      exception when others then       
        dbms_application_info.set_module(null,null);    
        return getdmlarrayasstring(info_array);  
  end WarehouseActivityQuery;
  FUNCTION WarehouseOrdersQuery (warehouseid orders.warehouse_id%type,    
                                 min_sleep integer,    
                                 max_sleep integer
                                ) return varchar is
    cursor c1 is SELECT order_mode,
        orders.warehouse_id,
        SUM(order_total),
        COUNT(1)
      FROM orders,
        warehouses
      WHERE orders.warehouse_id   = warehouses.warehouse_id
      AND warehouses.warehouse_id = warehouseid
      GROUP BY cube(orders.order_mode, orders.warehouse_id);
    order_mode orders.order_mode%type;
    warehouse_id orders.warehouse_id%type;
    sumoforders orders.order_total%type;
    numberoforders integer;
    begin
      dbms_application_info.set_module('Warehouse Orders Query',null);    
      init_info_array();    
      open c1;
      loop
        fetch c1 into order_mode,warehouse_id,sumoforders,numberoforders;
        exit when c1%notfound;
      end loop;
      increment_selects(1);    
      sleep(min_sleep, max_sleep);    
      dbms_application_info.set_module(null,null);    
      return getdmlarrayasstring(info_array);    
      exception when others then       
        dbms_application_info.set_module(null,null);    
        return getdmlarrayasstring(info_array);
  end WarehouseOrdersQuery;
END;

--END;

