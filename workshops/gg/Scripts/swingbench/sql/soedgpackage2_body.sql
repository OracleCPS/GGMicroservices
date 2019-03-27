create or replace
PACKAGE BODY ORDERENTRY AS
  --  
  --  
  -- Package     : Order Entry Package Body
  -- Version     : 2.0
  -- Author      : Dominic Giles
  -- Last Update : 14 June 2011
  -- Description : Used in stress test of Oracle by swingbench test harness
  --
  --
    MAX_BROWSE_CATEGORY integer := 24;
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
    MAX_PRODS_TO_BUY    integer := 8;
    MIN_WAREHOUSE_ID    integer := 1;
    MAX_WAREHOUSE_ID    integer := 1000;
    AWAITING_PROCESSING integer := 4;
    ORDER_PROCESSED     integer := 10;
    MAX_CREDITLIMIT     integer := 5000;
    MIN_CREDITLIMIT     integer := 100;
    MIN_SALESID         integer := 145;
    MAX_SALESID         integer := 171;
    MIN_COST_DELIVERY   integer := 1;
    MAX_COST_DELIVERY   integer := 5;
    ROW_RETURNS         integer := 15;
    HOUSE_NO_RANGE      integer := 200;
    PLSQLCOMMIT         boolean := false;
    CUSTOMER_CLASS      customers.customer_class%type := 'Occasional';
    SUGGESTIONS         customers.suggestions%type := 'Books';
    MAILSHOT            customers.mailshot%type := 'Y';
    PARTNER_MAILSHOT    customers.partner_mailshot%type := 'Y';
    INST_ID             integer := sys_context('userenv','instance');
    INFO_ARRAY          integer_return_array := integer_return_array();
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
        if (min_sleep != 0) AND (max_sleep != 0) then
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
       else
         sleepTime := 0;
       end if;
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
        select   products.PRODUCT_ID,
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
         SELECT   CUSTOMER_ID,
            CUST_FIRST_NAME,
            CUST_LAST_NAME,
            NLS_LANGUAGE,
            NLS_TERRITORY,
            CREDIT_LIMIT,
            CUST_EMAIL,
            ACCOUNT_MGR_ID,
            CUSTOMER_SINCE,
            CUSTOMER_CLASS,
            SUGGESTIONS,
            DOB,
            MAILSHOT,
            PARTNER_MAILSHOT,
            PREFERRED_ADDRESS,
            PREFERRED_CARD bulk collect
          INTO my_customer_tab
          FROM CUSTOMERS
          WHERE customer_id = cust_id
          AND rownum        < ROW_RETURNS;
        dbms_application_info.set_action(null);
        return my_customer_tab;
    end getCustomerDetails;
    procedure logon(cust_id customers.customer_id%type) is
      current_time date;
      customerArray customer_tab;
      begin
        dbms_application_info.set_action('logon');
        customerArray := getCustomerDetails(cust_id);
        if trunc(dbms_random.value(1,4)) = 2 then
          select  sysdate into current_time from dual;
          insert into logon (logon_id,customer_id, logon_date) values
          (logon_seq.nextval, cust_id, current_time);
          oecommit;
        end if;
        dbms_application_info.set_action(null);
    end logon;
    Function getAddressDetails(cust_id addresses.customer_id%type) return address_tab is
      my_address_tab address_tab;
      begin
         dbms_application_info.set_action('getAddressDetails');
          SELECT   ADDRESS_ID,
            CUSTOMER_ID,
            DATE_CREATED,
            HOUSE_NO_OR_NAME,
            STREET_NAME,
            TOWN,
            COUNTY,
            COUNTRY,
            POST_CODE,
            ZIP_CODE bulk collect
          INTO my_address_tab
          FROM ADDRESSES
          WHERE customer_id = cust_id
          AND rownum        < ROW_RETURNS;
        dbms_application_info.set_action(null);
        return my_address_tab;
    end getAddressDetails;
    Function getCardDetailsByCustomerID(cust_id addresses.customer_id%type) return card_details_tab is
      my_card_tab card_details_tab;
      begin
         dbms_application_info.set_action('getCardDetailsByCustomerID');
          SELECT CARD_ID,
            CUSTOMER_ID,
            CARD_TYPE,
            CARD_NUMBER,
            EXPIRY_DATE,
            IS_VALID,
            SECURITY_CODE
            bulk collect
          INTO my_card_tab
          FROM card_details
          WHERE CUSTOMER_ID = cust_id
          AND rownum        < ROW_RETURNS;
        dbms_application_info.set_action(null);
        return my_card_tab;
    end getCardDetailsByCustomerID;
    Function getProductDetails(prod_id product_information.product_id%type) return prod_tab is
      my_product_tab prod_tab;
      begin
         dbms_application_info.set_action('getProductDetails');
         SELECT   products.PRODUCT_ID,
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
        SELECT ORDER_ID,
          ORDER_DATE,
          ORDER_MODE,
          CUSTOMER_ID,
          ORDER_STATUS,
          ORDER_TOTAL,
          SALES_REP_ID,
          PROMOTION_ID,
          WAREHOUSE_ID,
          DELIVERY_TYPE,
          COST_OF_DELIVERY,
          WAIT_TILL_ALL_AVAILABLE,
          DELIVERY_ADDRESS_ID,
          CUSTOMER_CLASS,
          CARD_ID,
          INVOICE_ADDRESS_ID
          bulk collect
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
        SELECT ORDER_ID,
          ORDER_DATE,
          ORDER_MODE,
          CUSTOMER_ID,
          ORDER_STATUS,
          ORDER_TOTAL,
          SALES_REP_ID,
          PROMOTION_ID,
          WAREHOUSE_ID,
          DELIVERY_TYPE,
          COST_OF_DELIVERY,
          WAIT_TILL_ALL_AVAILABLE,
          DELIVERY_ADDRESS_ID,
          CUSTOMER_CLASS,
          CARD_ID,
          INVOICE_ADDRESS_ID
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
        select   ORDER_ID,
          LINE_ITEM_ID,
          PRODUCT_ID,
          UNIT_PRICE,
          QUANTITY,DISPATCH_DATE,
          RETURN_DATE,
          GIFT_WRAP,
          CONDITION,
          SUPPLIER_ID,
          ESTIMATED_DELIVERY
          bulk collect
        into my_order_Item_tab
        from order_items
        where order_id = ord_id
        and rownum < ROW_RETURNS;
        dbms_application_info.set_action(null);
      return my_order_Item_tab;
    END getOrderItemsById;
    function getProductQuantity(prodId product_information.PRODUCT_ID%type, wareId inventories.WAREHOUSE_ID%type) return integer is
      cursor product_cursor is select    quantity_on_hand
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
        increment_inserts(1);increment_selects(1);increment_commits(1);
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
      addressesArray address_tab;
      cardArray card_details_tab;
      numOfBrowses  integer := 1;
      catId         integer := 1;
      prodId        integer := 1;
      prodsToBuy    integer := 1;
      orderId       orders.order_id%type;
      warehouse     inventories.warehouse_id%type;
      cardId        card_details.card_id%type;
      addressId     addresses.address_id%type;
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
        addressesArray := getAddressDetails(cust_id);
        increment_selects(1);
        cardArray := getcarddetailsbycustomerid(cust_id);
        increment_selects(1);
        sleep(min_sleep, max_sleep);
        logon(cust_id);
        increment_inserts(1);increment_selects(1);increment_commits(1);
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
        INSERT INTO orders
          (
            order_id,
            order_date,
            order_mode,
            customer_id,
            order_status,
            warehouse_id,
            delivery_type,
            delivery_address_id,
            cost_of_delivery,
            wait_till_all_available,
            customer_class,
            card_id,
            invoice_address_id
          )
          VALUES
          (
            orders_seq.NEXTVAL + inst_id,
            systimestamp ,
            'online',
            cust_id,
            1,
            warehouse,
            'Standard',
            customerArray(1).preferred_address,
            dbms_random.value(MIN_COST_DELIVERY, MAX_COST_DELIVERY),
            'ship_asap',
            customerArray(1).customer_class,
            customerArray(1).preferred_card,
            customerArray(1).preferred_address
          ) returning order_id into orderId;
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
            INSERT INTO order_items
              (
                order_id,
                line_item_id,
                product_id,
                unit_price,
                quantity,
                gift_wrap,
                condition,
                estimated_delivery
              )
              VALUES
              (
                orderId,
                i,
                prodId,
                price,
                1,
                'None',
                'New',
                (sysdate + 3)
              );
            increment_inserts(1);
            prodList.extend;prodList(prodList.count) := prodID;
            warehouseList.extend;warehouseList(warehouseList.count) := warehouse;
            noOrderedList.extend;noOrderedList(noOrderedList.count) := 1;
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
          DBMS_OUTPUT.PUT_LINE
             ('Error code ' || SQLCODE || ': ' || SUBSTR(SQLERRM, 1 , 64));
          rollback;
          increment_rollbacks(1);
          dbms_application_info.set_module(null,null);
          return getdmlarrayasstring(info_array);
    end newOrder;
    FUNCTION findCustomerByName
    ( p_cust_first_name customers.cust_first_name%type,
      p_cust_last_name customers.cust_last_name%type)
    return customer_tab is
    my_customer_tab customer_tab;
      begin
         dbms_application_info.set_action('findCustomer');
         SELECT   CUSTOMER_ID,
            CUST_FIRST_NAME,
            CUST_LAST_NAME,
            NLS_LANGUAGE,
            NLS_TERRITORY,
            CREDIT_LIMIT,
            CUST_EMAIL,
            ACCOUNT_MGR_ID,
            CUSTOMER_SINCE,
            CUSTOMER_CLASS,
            SUGGESTIONS,
            DOB,
            MAILSHOT,
            PARTNER_MAILSHOT,
            PREFERRED_ADDRESS,
            PREFERRED_CARD
            bulk collect
          INTO my_customer_tab
          FROM CUSTOMERS
          WHERE lower(cust_last_name) = lower(p_cust_last_name)
          AND lower(cust_first_name) = lower(p_cust_first_name)
          AND rownum        < ROW_RETURNS;
        dbms_application_info.set_action(null);
        return my_customer_tab;
    end findCustomerByName;
    FUNCTION getAddressesByCustomerID(
      custid addresses.customer_id%type)
    RETURN address_tab
    IS
      my_address_tab address_tab;
    BEGIN
      dbms_application_info.set_action('getAddressesByCustomerID');
      SELECT ADDRESS_ID,
        CUSTOMER_ID,
        HOUSE_NO_OR_NAME,
        STREET_NAME,
        TOWN,
        COUNTY,
        COUNTRY,
        POST_CODE,
        ZIP_CODE,
        DATE_CREATED bulk collect
      INTO my_address_tab
      FROM ADDRESSES
      WHERE CUSTOMER_ID = custid
      AND rownum        < ROW_RETURNS;
      dbms_application_info.set_action(NULL);
      RETURN my_address_tab;
  END getAddressesByCustomerID;
    FUNCTION updateCustomerDetails
    ( p_fname customers.cust_first_name%type,
      p_lname customers.cust_last_name%type,
      p_town addresses.town%type,
      p_county addresses.county%type,
      p_country addresses.country%type,
      min_sleep INTEGER,
      max_sleep INTEGER)
    RETURN varchar is
    l_customer_array customer_tab;
    l_customer_id customers.customer_id%type;
    l_address_id addresses.address_id%type;
    begin
      dbms_application_info.set_module('Update Customer Details',null);
      init_info_array();
      l_customer_array := findCustomerByName(p_fname, p_lname);
      increment_selects(1);
      sleep(min_sleep, max_sleep);
      if l_customer_array.count > 1 then
        select address_seq.nextval into l_address_id from dual;
        l_customer_id := l_customer_array(1).customer_id;
        increment_selects(1);
        INSERT INTO ADDRESSES
          (
            address_id,
            customer_id,
            date_created,
            house_no_or_name,
            street_name,
            town,
            county,
            country,
            post_code,
            zip_code
          )
          VALUES
          (
            l_address_Id,
            l_customer_Id,
            TRUNC(SYSDATE,'MI'),
            floor(DBMS_RANDOM.value(1, HOUSE_NO_RANGE)),
            'Street Name',
            p_town,
            p_county,
            p_country,
            'Postcode',
            NULL
          );
        increment_inserts(1);
        UPDATE CUSTOMERS
        SET PREFERRED_ADDRESS = l_address_id
        WHERE customer_id = l_customer_id;
        oecommit;
        increment_updates(1);
        increment_commits(1);
      end if;
      return getdmlarrayasstring(info_array);
      exception when others then
          DBMS_OUTPUT.PUT_LINE('Error code ' || SQLCODE || ': ' || SUBSTR(SQLERRM, 1 , 64));
          rollback;
          increment_rollbacks(1);
          dbms_application_info.set_module(null,null);
          return getdmlarrayasstring(info_array);
    end updateCustomerDetails;
    function newCustomer(p_fname customers.cust_first_name%type,
                      p_lname customers.cust_last_name%type,
                      p_nls_lang customers.nls_language%type,
                      p_nls_terr customers.nls_territory%type,
                      p_town addresses.town%type,
                      p_county addresses.county%type,
                      p_country addresses.country%type,
                      p_min_sleep integer,
                      p_max_sleep integer) return varchar is
      l_customer_id customers.customer_id%type;
      l_address_id addresses.address_id%type;
      l_card_id card_details.card_id%type;
      l_customerArray customer_tab;
      begin
        dbms_application_info.set_module('Update Customer Details',null);
        init_info_array();
        select   customer_seq.nextval into l_customer_id from dual;-- this could be returned more efficently using returns clause on insert
        select   address_seq.nextval into l_address_id from dual;
        select   card_details_seq.nextval into l_card_id from dual;
        increment_selects(3);
        INSERT
        INTO customers
          (
            customer_id ,
            cust_first_name ,
            cust_last_name ,
            nls_language ,
            nls_territory ,
            credit_limit ,
            cust_email ,
            account_mgr_id,
            customer_since,
            customer_class,
            suggestions,
            dob,
            mailshot,
            partner_mailshot,
            preferred_address,
            preferred_card
          )
          VALUES
          (
            l_customer_id,
            p_fname,
            p_lname,
            p_nls_lang,
            p_nls_terr,
            FLOOR(DBMS_RANDOM.value(MIN_CREDITLIMIT, MAX_CREDITLIMIT)),
            p_fname
            ||'.'
            ||p_lname
            ||'@'
            ||'oracle.com',
            FLOOR(DBMS_RANDOM.value(MIN_SALESID, MAX_SALESID)),
            TRUNC(SYSDATE),
            'Occasional',
            'Music',
            trunc(SYSDATE - (365*DBMS_RANDOM.value(20, 60))),
            'Y',
            'N',
            l_address_id,
            l_card_id
          );
        increment_inserts(1);
        INSERT INTO ADDRESSES
          (
            address_id,
            customer_id,
            date_created,
            house_no_or_name,
            street_name,
            town,
            county,
            country,
            post_code,
            zip_code
          )
          VALUES
          (
            l_address_Id,
            l_customer_Id,
            TRUNC(SYSDATE,'MI'),
            floor(DBMS_RANDOM.value(1, HOUSE_NO_RANGE)),
            'Street Name',
            p_town,
            p_county,
            p_country,
            'Postcode',
            NULL
          );
        increment_inserts(1);
        INSERT INTO CARD_DETAILS
          (
            CARD_ID,
            CUSTOMER_ID,
            CARD_TYPE,
            CARD_NUMBER,
            EXPIRY_DATE,
            IS_VALID,
            SECURITY_CODE
          )
          VALUES
          (
            l_card_id,
            l_customer_Id,
            'Visa(Debit)',
            floor(DBMS_RANDOM.value(1111111111, 9999999999)),
            trunc(SYSDATE + (DBMS_RANDOM.value(365, 1460))),
            'Y',
            floor(DBMS_RANDOM.value(1111, 9999))
          );
        oecommit;
        increment_inserts(1);increment_commits(1);
        sleep(p_min_sleep, p_max_sleep);
        logon(l_customer_id);
        increment_inserts(1);increment_selects(1);increment_commits(1);
        l_customerArray := getCustomerDetails(l_customer_id);
        increment_selects(1);
        dbms_application_info.set_module(null,null);
        return getdmlarrayasstring(info_array);
        exception when others then
          DBMS_OUTPUT.PUT_LINE('Error code ' || SQLCODE || ': ' || SUBSTR(SQLERRM, 1 , 64));
          rollback;
          increment_rollbacks(1);
          dbms_application_info.set_module(null,null);
          return getdmlarrayasstring(info_array);
    end newcustomer;
    function processorders (
                            warehouse warehouses.warehouse_id%type,
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
    function processOrders (
                            min_sleep integer,
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
      selectedAddress integer := 1;
      customerArray customer_tab;
      addressArray address_tab;
      orderArray order_tab;
      orderItemsArray order_item_tab;
      begin
        dbms_application_info.set_module('Browse and Update Orders',null);
        init_info_array();
        customerArray := getCustomerDetails(cust_id);
        addressArray := getAddressDetails(cust_id);
        increment_selects(2);
        sleep(min_sleep, max_sleep);
        logon(cust_id);
        increment_inserts(1);increment_selects(1);increment_commits(1);
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
      cursor c1 is SELECT   tt.ORDER_TOTAL,
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
        SELECT   warehouse_id,
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
      cursor c1 is SELECT   order_mode,
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

--End;

