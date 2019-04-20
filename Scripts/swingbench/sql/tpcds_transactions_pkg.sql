CREATE OR REPLACE TYPE integer_return_array 
    IS VARRAY(25) OF INTEGER;

CREATE OR REPLACE PACKAGE pkg_tpcds_transactions AS
    --
    -- Package Specification: PKG_TPCDS_TRANSACTIONS
    -- Purpose: Presents public interface for generation of TPC-DS OLTP transactions
    -- Author:  Jim Czuprynski
    -- Maintenance Log:
    -- 2017-01-15   JSC Original version
    FUNCTION NewCatalogSales(
        min_sleep INTEGER
       ,max_sleep INTEGER
    ) RETURN integer_return_array;
    FUNCTION NewStoreSales(
        min_sleep INTEGER
       ,max_sleep INTEGER
    ) RETURN integer_return_array;
    FUNCTION NewWebSales(
        min_sleep INTEGER
       ,max_sleep INTEGER
    ) RETURN integer_return_array;
    FUNCTION UpdateCatalogSales(
        min_sleep INTEGER
       ,max_sleep INTEGER
    ) RETURN integer_return_array;
    FUNCTION UpdateStoreSales(
        min_sleep INTEGER
       ,max_sleep INTEGER
    ) RETURN integer_return_array;
    FUNCTION UpdateWebSales(
        min_sleep INTEGER
       ,max_sleep INTEGER
    ) RETURN integer_return_array;
END;


CREATE OR REPLACE PACKAGE BODY pkg_tpcds_transactions AS
    -- Package Body: PKG_TPCDS_TRANSACTIONS
    -- Purpose: Implements public interface for generation of TPC-DS OLTP transactions
    -- Author:  Jim Czuprynski
    -- Maintenance Log:
    -- 2017-01-15   JSC Original version
  SELECT_STATEMENTS   integer := 1;
  INSERT_STATEMENTS   integer := 2;
  UPDATE_STATEMENTS   integer := 3;
  DELETE_STATEMENTS   integer := 4;
  COMMIT_STATEMENTS   integer := 5;
  ROLLBACK_STATEMENTS integer := 6;
  SLEEP_TIME          integer := 7;
  info_array integer_return_array := integer_return_array();
  -----
  -- Variables added:
  -----
    -- Processing variables:
    SQLERRNUM           INTEGER := 0;
    SQLERRMSG           VARCHAR2(255);
    MIN_ADDR_SK         INTEGER := 1;
    MAX_ADDR_SK         INTEGER := 50000;
    MIN_CCTR_SK         INTEGER := 1;
    MAX_CCTR_SK         INTEGER := 6;
    MIN_CDEMO_SK        INTEGER := 1;
    MAX_CDEMO_SK        INTEGER := 1920800;
    MIN_CPGE_SK         INTEGER := 1;
    MAX_CPGE_SK         INTEGER := 11718;
    MIN_CUST_SK         INTEGER := 1;
    MAX_CUST_SK         INTEGER := 100000;
    MIN_DATE_SK         INTEGER := 2453006;
    MAX_DATE_SK         INTEGER := 2453371;
    MIN_HDEMO_SK        INTEGER := 1;
    MAX_HDEMO_SK        INTEGER := 7200;
    MIN_MODE_SK         INTEGER := 1;
    MAX_MODE_SK         INTEGER := 20;
    MIN_PROMO_SK        INTEGER := 1;
    MAX_PROMO_SK        INTEGER := 300;
    MIN_STORE_SK        INTEGER := 1;
    MAX_STORE_SK        INTEGER := 12;
    MIN_TCKT_SK         INTEGER := 2881400;
    MAX_TCKT_SK         INTEGER := 3881399;
    MIN_TIME_SK         INTEGER := 0;
    MAX_TIME_SK         INTEGER := 86399;
    MIN_WHSE_SK         INTEGER := 1;
    MAX_WHSE_SK         INTEGER := 5;
    MIN_WPGE_SK         INTEGER := 1;
    MAX_WPGE_SK         INTEGER := 60;
    MIN_WSIT_SK         INTEGER := 1;
    MAX_WSIT_SK         INTEGER := 30;
-- TYPEs and RECORDS
----
-- INVENTORY
-----
TYPE inventory_rec IS
    RECORD (
        inv_date_sk                 inventory.inv_date_sk%TYPE
       ,inv_item_sk                 inventory.inv_item_sk%TYPE
       ,inv_warehouse_sk            inventory.inv_warehouse_sk%TYPE
       ,inv_quantity_on_hand        inventory.inv_quantity_on_hand%TYPE
);
TYPE inventory_tab IS
    TABLE OF inventory_rec
    INDEX BY PLS_INTEGER;
-----
-- CATALOG_RETURNS
-----
TYPE catalog_returns_rec IS
    RECORD (
        cr_returned_date_sk         catalog_returns.cr_returned_date_sk%TYPE
       ,cr_returned_time_sk         catalog_returns.cr_returned_time_sk%TYPE
       ,cr_item_sk                  catalog_returns.cr_item_sk%TYPE
       ,cr_refunded_customer_sk     catalog_returns.cr_refunded_customer_sk%TYPE
       ,cr_refunded_cdemo_sk        catalog_returns.cr_refunded_cdemo_sk%TYPE
       ,cr_refunded_hdemo_sk        catalog_returns.cr_refunded_hdemo_sk%TYPE
       ,cr_refunded_addr_sk         catalog_returns.cr_refunded_addr_sk%TYPE
       ,cr_returning_customer_sk    catalog_returns.cr_returning_customer_sk%TYPE
       ,cr_returning_cdemo_sk       catalog_returns.cr_returning_cdemo_sk%TYPE
       ,cr_returning_hdemo_sk       catalog_returns.cr_returning_hdemo_sk%TYPE
       ,cr_returning_addr_sk        catalog_returns.cr_returning_addr_sk%TYPE
       ,cr_call_center_sk           catalog_returns.cr_call_center_sk%TYPE
       ,cr_catalog_page_sk          catalog_returns.cr_catalog_page_sk%TYPE
       ,cr_ship_mode_sk             catalog_returns.cr_ship_mode_sk%TYPE
       ,cr_warehouse_sk             catalog_returns.cr_warehouse_sk%TYPE
       ,cr_reason_sk                catalog_returns.cr_reason_sk%TYPE
       ,cr_order_number             catalog_returns.cr_order_number%TYPE
       ,cr_return_quantity          catalog_returns.cr_return_quantity%TYPE
       ,cr_return_amount            catalog_returns.cr_return_amount%TYPE
       ,cr_return_tax               catalog_returns.cr_return_tax%TYPE
       ,cr_return_amt_inc_tax       catalog_returns.cr_return_amt_inc_tax%TYPE
       ,cr_fee                      catalog_returns.cr_fee%TYPE
       ,cr_return_ship_cost         catalog_returns.cr_return_ship_cost%TYPE
       ,cr_refunded_cash            catalog_returns.cr_refunded_cash%TYPE
       ,cr_reversed_charge          catalog_returns.cr_reversed_charge%TYPE
       ,cr_store_credit             catalog_returns.cr_store_credit%TYPE
       ,cr_net_loss                 catalog_returns.cr_net_loss%TYPE
);
TYPE catalog_returns_tab IS
    TABLE OF catalog_returns_rec
    INDEX BY PLS_INTEGER;
-----
-- CATALOG_SALES
-----
TYPE catalog_sales_rec IS
    RECORD (
        cs_sold_date_sk             catalog_sales.cs_sold_date_sk%TYPE
       ,cs_sold_time_sk             catalog_sales.cs_sold_time_sk%TYPE
       ,cs_ship_date_sk             catalog_sales.cs_ship_date_sk%TYPE
       ,cs_bill_customer_sk         catalog_sales.cs_bill_customer_sk%TYPE
       ,cs_bill_cdemo_sk            catalog_sales.cs_bill_cdemo_sk%TYPE
       ,cs_bill_hdemo_sk            catalog_sales.cs_bill_hdemo_sk%TYPE
       ,cs_bill_addr_sk             catalog_sales.cs_bill_addr_sk%TYPE
       ,cs_ship_customer_sk         catalog_sales.cs_ship_customer_sk%TYPE
       ,cs_ship_cdemo_sk            catalog_sales.cs_ship_cdemo_sk%TYPE
       ,cs_ship_hdemo_sk            catalog_sales.cs_ship_hdemo_sk%TYPE
       ,cs_ship_addr_sk             catalog_sales.cs_ship_addr_sk%TYPE
       ,cs_call_center_sk           catalog_sales.cs_call_center_sk%TYPE
       ,cs_catalog_page_sk          catalog_sales.cs_catalog_page_sk%TYPE
       ,cs_ship_mode_sk             catalog_sales.cs_ship_mode_sk%TYPE
       ,cs_warehouse_sk             catalog_sales.cs_warehouse_sk%TYPE
       ,cs_item_sk                  catalog_sales.cs_item_sk%TYPE
       ,cs_promo_sk                 catalog_sales.cs_promo_sk%TYPE
       ,cs_order_number             catalog_sales.cs_order_number%TYPE
       ,cs_quantity                 catalog_sales.cs_quantity%TYPE
       ,cs_wholesale_cost           catalog_sales.cs_wholesale_cost%TYPE
       ,cs_list_price               catalog_sales.cs_list_price%TYPE
       ,cs_sales_price              catalog_sales.cs_sales_price%TYPE
       ,cs_ext_discount_amt         catalog_sales.cs_ext_discount_amt%TYPE
       ,cs_ext_sales_price          catalog_sales.cs_ext_sales_price%TYPE
       ,cs_ext_wholesale_cost       catalog_sales.cs_ext_wholesale_cost%TYPE
       ,cs_ext_list_price           catalog_sales.cs_ext_list_price%TYPE
       ,cs_ext_tax                  catalog_sales.cs_ext_tax%TYPE
       ,cs_coupon_amt               catalog_sales.cs_coupon_amt%TYPE
       ,cs_ext_ship_cost            catalog_sales.cs_ext_ship_cost%TYPE
       ,cs_net_paid                 catalog_sales.cs_net_paid%TYPE
       ,cs_net_paid_inc_tax         catalog_sales.cs_net_paid_inc_tax%TYPE
       ,cs_net_paid_inc_ship        catalog_sales.cs_net_paid_inc_ship%TYPE
       ,cs_net_paid_inc_ship_tax    catalog_sales.cs_net_paid_inc_ship_tax%TYPE
       ,cs_net_profit               catalog_sales.cs_net_profit%TYPE
);
TYPE catalog_sales_tab IS
    TABLE OF catalog_sales_rec
    INDEX BY PLS_INTEGER;
-----
-- STORE_RETURNS
-----
TYPE store_returns_rec IS
    RECORD (
        sr_returned_date_sk        store_returns.sr_returned_date_sk%TYPE
       ,sr_return_time_sk          store_returns.sr_return_time_sk%TYPE
       ,sr_item_sk                 store_returns.sr_item_sk%TYPE
       ,sr_customer_sk             store_returns.sr_customer_sk%TYPE
       ,sr_cdemo_sk                store_returns.sr_cdemo_sk%TYPE
       ,sr_hdemo_sk                store_returns.sr_hdemo_sk%TYPE
       ,sr_addr_sk                 store_returns.sr_addr_sk%TYPE
       ,sr_store_sk                store_returns.sr_store_sk%TYPE
       ,sr_reason_sk               store_returns.sr_reason_sk%TYPE
       ,sr_ticket_number           store_returns.sr_ticket_number%TYPE
       ,sr_return_quantity         store_returns.sr_return_quantity%TYPE
       ,sr_return_amt              store_returns.sr_return_amt%TYPE
       ,sr_return_tax              store_returns.sr_return_tax%TYPE
       ,sr_return_amt_inc_tax      store_returns.sr_return_amt_inc_tax%TYPE
       ,sr_fee                     store_returns.sr_fee%TYPE
       ,sr_return_ship_cost        store_returns.sr_return_ship_cost%TYPE
       ,sr_refunded_cash           store_returns.sr_refunded_cash%TYPE
       ,sr_reversed_charge         store_returns.sr_reversed_charge%TYPE
       ,sr_store_credit            store_returns.sr_store_credit%TYPE
       ,sr_net_loss                store_returns.sr_net_loss%TYPE
);
TYPE store_returns_tab IS
    TABLE OF store_returns_rec
    INDEX BY PLS_INTEGER;
-----
-- STORE_SALES
-----
TYPE store_sales_rec IS
    RECORD (
        ss_sold_date_sk            store_sales.ss_sold_date_sk%TYPE
       ,ss_sold_time_sk            store_sales.ss_sold_time_sk%TYPE
       ,ss_item_sk                 store_sales.ss_item_sk%TYPE
       ,ss_customer_sk             store_sales.ss_customer_sk%TYPE
       ,ss_cdemo_sk                store_sales.ss_cdemo_sk%TYPE
       ,ss_hdemo_sk                store_sales.ss_hdemo_sk%TYPE
       ,ss_addr_sk                 store_sales.ss_addr_sk%TYPE
       ,ss_store_sk                store_sales.ss_store_sk%TYPE
       ,ss_promo_sk                store_sales.ss_promo_sk%TYPE
       ,ss_ticket_number           store_sales.ss_ticket_number%TYPE
       ,ss_quantity                store_sales.ss_quantity%TYPE
       ,ss_wholesale_cost          store_sales.ss_wholesale_cost%TYPE
       ,ss_list_price              store_sales.ss_list_price%TYPE
       ,ss_sales_price             store_sales.ss_sales_price%TYPE
       ,ss_ext_discount_amt        store_sales.ss_ext_discount_amt%TYPE
       ,ss_ext_sales_price         store_sales.ss_ext_sales_price%TYPE
       ,ss_ext_wholesale_cost      store_sales.ss_ext_wholesale_cost%TYPE
       ,ss_ext_list_price          store_sales.ss_ext_list_price%TYPE
       ,ss_ext_tax                 store_sales.ss_ext_tax%TYPE
       ,ss_coupon_amt              store_sales.ss_coupon_amt%TYPE
       ,ss_net_paid                store_sales.ss_net_paid%TYPE
       ,ss_net_paid_inc_tax        store_sales.ss_net_paid_inc_tax%TYPE
       ,ss_net_profit              store_sales.ss_net_profit%TYPE
);
TYPE store_sales_tab IS
    TABLE OF store_sales_rec
    INDEX BY PLS_INTEGER;
-----
-- WEB_RETURNS
-----
TYPE web_returns_rec IS
    RECORD (
        wr_returned_date_sk        web_returns.wr_returned_date_sk%TYPE
       ,wr_returned_time_sk        web_returns.wr_returned_time_sk%TYPE
       ,wr_item_sk                 web_returns.wr_item_sk%TYPE
       ,wr_refunded_customer_sk    web_returns.wr_refunded_customer_sk%TYPE
       ,wr_refunded_cdemo_sk       web_returns.wr_refunded_cdemo_sk%TYPE
       ,wr_refunded_hdemo_sk       web_returns.wr_refunded_hdemo_sk%TYPE
       ,wr_refunded_addr_sk        web_returns.wr_refunded_addr_sk%TYPE
       ,wr_returning_customer_sk   web_returns.wr_returning_customer_sk%TYPE
       ,wr_returning_cdemo_sk      web_returns.wr_returning_cdemo_sk%TYPE
       ,wr_returning_hdemo_sk      web_returns.wr_returning_hdemo_sk%TYPE
       ,wr_returning_addr_sk       web_returns.wr_returning_addr_sk%TYPE
       ,wr_web_page_sk             web_returns.wr_web_page_sk%TYPE
       ,wr_reason_sk               web_returns.wr_reason_sk%TYPE
       ,wr_order_number            web_returns.wr_order_number%TYPE
       ,wr_return_quantity         web_returns.wr_return_quantity%TYPE
       ,wr_return_amt              web_returns.wr_return_amt%TYPE
       ,wr_return_tax              web_returns.wr_return_tax%TYPE
       ,wr_return_amt_inc_tax      web_returns.wr_return_amt_inc_tax%TYPE
       ,wr_fee                     web_returns.wr_fee%TYPE
       ,wr_return_ship_cost        web_returns.wr_return_ship_cost%TYPE
       ,wr_refunded_cash           web_returns.wr_refunded_cash%TYPE
       ,wr_reversed_charge         web_returns.wr_reversed_charge%TYPE
       ,wr_account_credit          web_returns.wr_account_credit%TYPE
       ,wr_net_loss                web_returns.wr_net_loss%TYPE
);
TYPE web_returns_tab IS
    TABLE OF web_returns_rec
    INDEX BY PLS_INTEGER;
-----
-- WEB_SALES
-----
TYPE web_sales_rec IS
    RECORD (
        ws_sold_date_sk            web_sales.ws_sold_date_sk%TYPE
       ,ws_sold_time_sk            web_sales.ws_sold_time_sk%TYPE
       ,ws_ship_date_sk            web_sales.ws_ship_date_sk%TYPE
       ,ws_item_sk                 web_sales.ws_item_sk%TYPE
       ,ws_bill_customer_sk        web_sales.ws_bill_customer_sk%TYPE
       ,ws_bill_cdemo_sk           web_sales.ws_bill_cdemo_sk%TYPE
       ,ws_bill_hdemo_sk           web_sales.ws_bill_hdemo_sk%TYPE
       ,ws_bill_addr_sk            web_sales.ws_bill_addr_sk%TYPE
       ,ws_ship_customer_sk        web_sales.ws_ship_customer_sk%TYPE
       ,ws_ship_cdemo_sk           web_sales.ws_ship_cdemo_sk%TYPE
       ,ws_ship_hdemo_sk           web_sales.ws_ship_hdemo_sk%TYPE
       ,ws_ship_addr_sk            web_sales.ws_ship_addr_sk%TYPE
       ,ws_web_page_sk             web_sales.ws_web_page_sk%TYPE
       ,ws_web_site_sk             web_sales.ws_web_site_sk%TYPE
       ,ws_ship_mode_sk            web_sales.ws_ship_mode_sk%TYPE
       ,ws_warehouse_sk            web_sales.ws_warehouse_sk%TYPE
       ,ws_promo_sk                web_sales.ws_promo_sk%TYPE
       ,ws_order_number            web_sales.ws_order_number%TYPE
       ,ws_quantity                web_sales.ws_quantity%TYPE
       ,ws_wholesale_cost          web_sales.ws_wholesale_cost%TYPE
       ,ws_list_price              web_sales.ws_list_price%TYPE
       ,ws_sales_price             web_sales.ws_sales_price%TYPE
       ,ws_ext_discount_amt        web_sales.ws_ext_discount_amt%TYPE
       ,ws_ext_sales_price         web_sales.ws_ext_sales_price%TYPE
       ,ws_ext_wholesale_cost      web_sales.ws_ext_wholesale_cost%TYPE
       ,ws_ext_list_price          web_sales.ws_ext_list_price%TYPE
       ,ws_ext_tax                 web_sales.ws_ext_tax%TYPE
       ,ws_coupon_amt              web_sales.ws_coupon_amt%TYPE
       ,ws_ext_ship_cost           web_sales.ws_ext_ship_cost%TYPE
       ,ws_net_paid                web_sales.ws_net_paid%TYPE
       ,ws_net_paid_inc_tax        web_sales.ws_net_paid_inc_tax%TYPE
       ,ws_net_paid_inc_ship       web_sales.ws_net_paid_inc_ship%TYPE
       ,ws_net_paid_inc_ship_tax   web_sales.ws_net_paid_inc_ship_tax%TYPE
       ,ws_net_profit              web_sales.ws_net_profit%TYPE
);
TYPE web_sales_tab IS
    TABLE OF web_sales_rec
    INDEX BY PLS_INTEGER;
   -----
   -- Functions and Procedures
   -----
  function from_mills_to_tens(value integer) return float is
    real_value float := 0;
    begin
      real_value := value/1000;
      return real_value;
      exception
        when zero_divide then
          real_value := 0;
          return real_value;
  END FROM_MILLS_TO_TENS;
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
    begin
      if (max_sleep = min_sleep) then
        sleeptime := from_mills_to_secs(max_sleep);
        dbms_lock.sleep(sleeptime);
      elsif (((max_sleep - min_sleep) > 0) AND (min_sleep < max_sleep)) then
        sleeptime := dbms_random.value(from_mills_to_secs(min_sleep), from_mills_to_secs(max_sleep));
        dbms_lock.sleep(sleeptime);
     end if;
     info_array(SLEEP_TIME) := (sleeptime * 1000) + info_array(SLEEP_TIME);
  end sleep;
  procedure init_dml_array is
    begin
      info_array := integer_return_array();
      for i in 1..7 loop
        info_array.extend;
        info_array(i) := 0;
      end loop;
  end init_dml_array;
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
    -----
    -- Added:
    -----
    -- Transaction Workload Generation Procedures and Functions
    PROCEDURE InitializeAttributeArrays
    IS
    BEGIN
        SELECT
            MIN(ca_address_sk)
           ,MAX(ca_address_sk)
          INTO
            MIN_ADDR_SK
           ,MAX_ADDR_SK
          FROM customer_address;
        SELECT
            MIN(cd_demo_sk)
           ,MAX(cd_demo_sk)
          INTO
            MIN_CDEMO_SK
           ,MAX_CDEMO_SK
          FROM customer_demographics;
        SELECT
            MIN(cc_call_center_sk)
           ,MAX(cc_call_center_sk)
          INTO
            MIN_CCTR_SK
           ,MAX_CCTR_SK
          FROM call_center;
        SELECT
            MIN(cp_catalog_page_sk)
           ,MAX(cp_catalog_page_sk)
          INTO
            MIN_CPGE_SK
           ,MAX_CPGE_SK
          FROM catalog_page;
        SELECT
            MIN(c_customer_sk)
           ,MAX(c_customer_sk)
          INTO
            MIN_CUST_SK
           ,MAX_CUST_SK
          FROM customer;
        SELECT
            MIN(d_date_sk)
           ,MAX(d_date_sk)
          INTO
            MIN_DATE_SK
           ,MAX_DATE_SK
          FROM date_dim
         WHERE d_date BETWEEN TO_DATE('2004-01-01','yyyy-mm-dd')
                          AND TO_DATE('2004-12-31','yyyy-mm-dd');
        SELECT
            MIN(hd_demo_sk)
           ,MAX(hd_demo_sk)
          INTO
            MIN_HDEMO_SK
           ,MAX_HDEMO_SK
          FROM household_demographics;
        SELECT
            MIN(sm_ship_mode_sk)
           ,MAX(sm_ship_mode_sk)
          INTO
            MIN_MODE_SK
           ,MAX_MODE_SK
          FROM ship_mode;
        SELECT
            MIN(p_promo_sk)
           ,MAX(p_promo_sk)
          INTO
            MIN_PROMO_SK
           ,MAX_PROMO_SK
          FROM promotion;
        SELECT
            MAX(ss_ticket_number) + 1000
           ,MAX(ss_ticket_number) + 1000000
          INTO
            MIN_TCKT_SK
           ,MAX_TCKT_SK
          FROM store_sales;
        SELECT
            MIN(t_time_sk)
           ,MAX(t_time_sk)
          INTO
            MIN_TIME_SK
           ,MAX_TIME_SK
          FROM time_dim;
        SELECT
            MIN(w_warehouse_sk)
           ,MAX(w_warehouse_sk)
          INTO
            MIN_WHSE_SK
           ,MAX_WHSE_SK
          FROM warehouse;
        SELECT
            MIN(wp_web_page_sk)
           ,MAX(wp_web_page_sk)
          INTO
            MIN_WPGE_SK
           ,MAX_WPGE_SK
          FROM web_page;
        SELECT
            MIN(web_site_sk)
           ,MAX(web_site_sk)
          INTO
            MIN_WSIT_SK
           ,MAX_WSIT_SK
          FROM web_site;
    EXCEPTION
        WHEN OTHERS THEN
            SQLERRNUM := SQLCODE;
            SQLERRMSG := SQLERRM;
    END InitializeAttributeArrays;
    -- PUBLIC Functions and Procedures
    -----
    -- Function:    NewCatalogSales
    -- Purpose:     Inserts new CATALOG_SALES rows individually
    -----
    FUNCTION NewCatalogSales(
         min_sleep INTEGER
        ,max_sleep INTEGER)
      RETURN integer_return_array
    IS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE('New Catalog Sales',NULL);
        init_dml_array();
        sleep(min_sleep, max_sleep);
        INSERT INTO catalog_sales(
            cs_sold_date_sk
           ,cs_sold_time_sk
           ,cs_ship_date_sk
           ,cs_bill_customer_sk
           ,cs_bill_cdemo_sk
           ,cs_bill_hdemo_sk
           ,cs_bill_addr_sk
           ,cs_ship_customer_sk
           ,cs_ship_cdemo_sk
           ,cs_ship_hdemo_sk
           ,cs_ship_addr_sk
           ,cs_call_center_sk
           ,cs_catalog_page_sk
           ,cs_ship_mode_sk
           ,cs_warehouse_sk
           ,cs_item_sk
           ,cs_promo_sk
           ,cs_order_number
           ,cs_quantity
           ,cs_wholesale_cost
           ,cs_list_price
           ,cs_sales_price
           ,cs_ext_discount_amt
           ,cs_ext_sales_price
           ,cs_ext_wholesale_cost
           ,cs_ext_list_price
           ,cs_ext_tax
           ,cs_coupon_amt
           ,cs_ext_ship_cost
           ,cs_net_paid
           ,cs_net_paid_inc_tax
           ,cs_net_paid_inc_ship
           ,cs_net_paid_inc_ship_tax
           ,cs_net_profit
        )
        VALUES (
            ROUND(DBMS_RANDOM.VALUE(MIN_DATE_SK, MAX_DATE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_TIME_SK, MAX_TIME_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_DATE_SK, MAX_DATE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CUST_SK, MAX_CUST_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CDEMO_SK, MAX_CDEMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_HDEMO_SK, MAX_HDEMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_ADDR_SK, MAX_ADDR_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CUST_SK, MAX_CUST_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CDEMO_SK, MAX_CDEMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_HDEMO_SK, MAX_HDEMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_ADDR_SK, MAX_ADDR_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CCTR_SK, MAX_CCTR_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CPGE_SK, MAX_CPGE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_MODE_SK, MAX_MODE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_WHSE_SK, MAX_WHSE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(1650,16400))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_PROMO_SK ,MAX_PROMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(1441600,1441699))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
        );
        increment_inserts(1);
        sleep(min_sleep, max_sleep);
        COMMIT;
        increment_commits(1);
        DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
        RETURN INFO_ARRAY;
    EXCEPTION
        WHEN OTHERS THEN
            SQLERRNUM := SQLCODE;
            SQLERRMSG := SQLERRM;
            ROLLBACK;
            increment_rollbacks(1);
            DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
            RETURN INFO_ARRAY;
    END NewCatalogSales;
    -----
    -- Function:    NewStoreSales
    -- Purpose:     Inserts new STORE_SALES rows individually
    -----
    FUNCTION NewStoreSales(
         min_sleep INTEGER
        ,max_sleep INTEGER)
      RETURN integer_return_array
    IS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE('New Store Sales',NULL);
        init_dml_array();
        sleep(min_sleep, max_sleep);
        INSERT INTO store_sales(
            ss_sold_date_sk
           ,ss_sold_time_sk
           ,ss_item_sk
           ,ss_customer_sk
           ,ss_cdemo_sk
           ,ss_hdemo_sk
           ,ss_addr_sk
           ,ss_store_sk
           ,ss_promo_sk
           ,ss_ticket_number
           ,ss_quantity
           ,ss_wholesale_cost
           ,ss_list_price
           ,ss_sales_price
           ,ss_ext_discount_amt
           ,ss_ext_sales_price
           ,ss_ext_wholesale_cost
           ,ss_ext_list_price
           ,ss_ext_tax
           ,ss_coupon_amt
           ,ss_net_paid
           ,ss_net_paid_inc_tax
           ,ss_net_profit
        )
        VALUES (
            ROUND(DBMS_RANDOM.VALUE(MIN_DATE_SK, MAX_DATE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_TIME_SK, MAX_TIME_SK))
           ,ROUND(DBMS_RANDOM.VALUE(1650,16400))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CUST_SK, MAX_CUST_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CDEMO_SK, MAX_CDEMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_HDEMO_SK, MAX_HDEMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_ADDR_SK, MAX_ADDR_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_STORE_SK ,MAX_STORE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_PROMO_SK ,MAX_PROMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_TCKT_SK, MAX_TCKT_SK))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
        );
        increment_inserts(1);
        sleep(min_sleep, max_sleep);
        COMMIT;
        increment_commits(1);
        DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
        RETURN INFO_ARRAY;
    EXCEPTION
        WHEN OTHERS THEN
            SQLERRNUM := SQLCODE;
            SQLERRMSG := SQLERRM;
            ROLLBACK;
            increment_rollbacks(1);
            DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
            RETURN INFO_ARRAY;
    END NewStoreSales;
    -----
    -- Function:    NewWebSales
    -- Purpose:     Inserts new WEB_SALES rows individually
    -----
    FUNCTION NewWebSales(
         min_sleep INTEGER
        ,max_sleep INTEGER)
      RETURN integer_return_array
    IS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE('New Web Sales',NULL);
        init_dml_array();
        sleep(min_sleep, max_sleep);
        INSERT INTO web_sales(
            ws_sold_date_sk
           ,ws_sold_time_sk
           ,ws_ship_date_sk
           ,ws_item_sk
           ,ws_bill_customer_sk
           ,ws_bill_cdemo_sk
           ,ws_bill_hdemo_sk
           ,ws_bill_addr_sk
           ,ws_ship_customer_sk
           ,ws_ship_cdemo_sk
           ,ws_ship_hdemo_sk
           ,ws_ship_addr_sk
           ,ws_web_page_sk
           ,ws_web_site_sk
           ,ws_ship_mode_sk
           ,ws_warehouse_sk
           ,ws_promo_sk
           ,ws_order_number
           ,ws_quantity
           ,ws_wholesale_cost
           ,ws_list_price
           ,ws_sales_price
           ,ws_ext_discount_amt
           ,ws_ext_sales_price
           ,ws_ext_wholesale_cost
           ,ws_ext_list_price
           ,ws_ext_tax
           ,ws_coupon_amt
           ,ws_ext_ship_cost
           ,ws_net_paid
           ,ws_net_paid_inc_tax
           ,ws_net_paid_inc_ship
           ,ws_net_paid_inc_ship_tax
           ,ws_net_profit
        )
        VALUES (
            ROUND(DBMS_RANDOM.VALUE(MIN_DATE_SK, MAX_DATE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_TIME_SK, MAX_TIME_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_DATE_SK, MAX_DATE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(1650,16400))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CUST_SK, MAX_CUST_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CDEMO_SK, MAX_CDEMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_HDEMO_SK, MAX_HDEMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_ADDR_SK, MAX_ADDR_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CUST_SK ,MAX_CUST_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_CDEMO_SK, MAX_CDEMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_HDEMO_SK, MAX_HDEMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_ADDR_SK, MAX_ADDR_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_WPGE_SK, MAX_WPGE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_WSIT_SK, MAX_WSIT_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_MODE_SK, MAX_MODE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_WHSE_SK, MAX_WHSE_SK))
           ,ROUND(DBMS_RANDOM.VALUE(MIN_PROMO_SK ,MAX_PROMO_SK))
           ,ROUND(DBMS_RANDOM.VALUE(1441600,1441699))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
           ,ROUND(DBMS_RANDOM.VALUE(1,100))
        );
        increment_inserts(1);
        sleep(min_sleep, max_sleep);
        COMMIT;
        increment_commits(1);
        DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
        RETURN INFO_ARRAY;
    EXCEPTION
        WHEN OTHERS THEN
            SQLERRNUM := SQLCODE;
            SQLERRMSG := SQLERRM;
            ROLLBACK;
            increment_rollbacks(1);
            DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
            RETURN INFO_ARRAY;
    END NewWebSales;
    -----
    -- Function:    UpdateCatalogSales
    -- Purpose:     Updates existing CATALOG_SALES rows individually
    -----
    FUNCTION UpdateCatalogSales(
         min_sleep INTEGER
        ,max_sleep INTEGER)
      RETURN integer_return_array
    IS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE('Update Catalog Sales',NULL);
        init_dml_array();
        sleep(min_sleep, max_sleep);
        UPDATE catalog_sales
           SET
            cs_quantity              = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_wholesale_cost        = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_list_price            = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_sales_price           = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_ext_discount_amt      = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_ext_sales_price       = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_ext_wholesale_cost    = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_ext_list_price        = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_ext_tax               = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_coupon_amt            = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_ext_ship_cost         = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_net_paid              = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_net_paid_inc_tax      = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_net_paid_inc_ship     = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_net_paid_inc_ship_tax = ROUND(DBMS_RANDOM.VALUE(101,200))
           ,cs_net_profit            = ROUND(DBMS_RANDOM.VALUE(101,200))
         WHERE cs_item_sk = ROUND(DBMS_RANDOM.VALUE(1650,16400))
           AND cs_order_number = ROUND(DBMS_RANDOM.VALUE(1441600,1441699))
        ;
        increment_updates(1);
        sleep(min_sleep, max_sleep);
        COMMIT;
        increment_commits(1);
        DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
        RETURN INFO_ARRAY;
    EXCEPTION
        WHEN OTHERS THEN
            SQLERRNUM := SQLCODE;
            SQLERRMSG := SQLERRM;
            ROLLBACK;
            increment_rollbacks(1);
            DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
            RETURN INFO_ARRAY;
    END UpdateCatalogSales;
    -----
    -- Function:    UpdateStoreSales
    -- Purpose:     Updates existing STORE_SALES rows individually
    -----
    FUNCTION UpdateStoreSales(
         min_sleep INTEGER
        ,max_sleep INTEGER)
      RETURN integer_return_array
    IS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE('Update Store Sales',NULL);
        init_dml_array();
        sleep(min_sleep, max_sleep);
        UPDATE store_sales
           SET
            ss_quantity              = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_wholesale_cost        = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_list_price            = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_sales_price           = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_ext_discount_amt      = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_ext_sales_price       = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_ext_wholesale_cost    = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_ext_list_price        = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_ext_tax               = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_coupon_amt            = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_net_paid              = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_net_paid_inc_tax      = ROUND(DBMS_RANDOM.VALUE(201,300))
           ,ss_net_profit            = ROUND(DBMS_RANDOM.VALUE(201,300))
         WHERE ss_item_sk = ROUND(DBMS_RANDOM.VALUE(1650,16400))
           AND ss_ticket_number = ROUND(DBMS_RANDOM.VALUE(MIN_TCKT_SK,MAX_TCKT_SK))
        ;
        increment_updates(1);
        sleep(min_sleep, max_sleep);
        COMMIT;
        increment_commits(1);
        DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
        RETURN INFO_ARRAY;
    EXCEPTION
        WHEN OTHERS THEN
            SQLERRNUM := SQLCODE;
            SQLERRMSG := SQLERRM;
            ROLLBACK;
            increment_rollbacks(1);
            DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
            RETURN INFO_ARRAY;
    END UpdateStoreSales;
    -----
    -- Function:    UpdateWebSales
    -- Purpose:     Updates existing WEB_SALES rows individually
    -----
    FUNCTION UpdateWebSales(
         min_sleep INTEGER
        ,max_sleep INTEGER)
      RETURN integer_return_array
    IS
    BEGIN
        DBMS_APPLICATION_INFO.SET_MODULE('Update Web Sales',NULL);
        init_dml_array();
        sleep(min_sleep, max_sleep);
        UPDATE web_sales
           SET
            ws_quantity               = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_wholesale_cost         = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_list_price             = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_sales_price            = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_ext_discount_amt       = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_ext_sales_price        = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_ext_wholesale_cost     = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_ext_list_price         = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_ext_tax                = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_coupon_amt             = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_ext_ship_cost          = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_net_paid               = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_net_paid_inc_tax       = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_net_paid_inc_ship      = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_net_paid_inc_ship_tax  = ROUND(DBMS_RANDOM.VALUE(301,400))
           ,ws_net_profit             = ROUND(DBMS_RANDOM.VALUE(301,400))
         WHERE ws_item_sk = ROUND(DBMS_RANDOM.VALUE(1650,16400))
           AND ws_order_number = ROUND(DBMS_RANDOM.VALUE(1441600,1441699))
        ;
        increment_updates(1);
        sleep(min_sleep, max_sleep);
        COMMIT;
        increment_commits(1);
        DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
        RETURN INFO_ARRAY;
    EXCEPTION
        WHEN OTHERS THEN
            SQLERRNUM := SQLCODE;
            SQLERRMSG := SQLERRM;
            ROLLBACK;
            increment_rollbacks(1);
            DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
            RETURN INFO_ARRAY;
    END UpdateWebSales;
    BEGIN
        -----
        -- Initialization processing:
        -----
        NULL;
END;


-- End
