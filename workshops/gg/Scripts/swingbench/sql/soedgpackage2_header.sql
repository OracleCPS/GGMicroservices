create or replace PACKAGE ORDERENTRY
AS
  -- 
  -- 
  -- 
  -- Package     : Order Entry Package Spec      
  -- Version     : 2.0      
  -- Author      : Dominic Giles       
  -- Last Update : 15th November 2012       
  -- Description : Used in stress test of Oracle by swingbench test harness       
  --
  --
  --
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
FUNCTION newCustomer( 
    p_fname customers.cust_first_name%type, 
    p_lname customers.cust_last_name%type, 
    p_nls_lang customers.nls_language%type, 
    p_nls_terr customers.nls_territory%type, 
    p_town addresses.town%type, 
    p_county addresses.county%type, 
    p_country addresses.country%type, 
    p_min_sleep INTEGER, 
    p_max_sleep INTEGER) 
  RETURN VARCHAR; 
FUNCTION updateCustomerDetails( 
    p_fname customers.cust_first_name%type,  
    p_lname customers.cust_last_name%type,  
    p_town addresses.town%type,  
    p_county addresses.county%type,  
    p_country addresses.country%type,    
    min_sleep INTEGER,        
    max_sleep INTEGER) 
  RETURN VARCHAR;  
FUNCTION processOrders       
  ( 
    min_sleep INTEGER,       
    max_sleep INTEGER)       
  return varchar;      
FUNCTION processOrders       
  ( warehouse warehouses.warehouse_id%type,      
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
    ORDER_DATE orders.ORDER_DATE%TYPE,  
    ORDER_MODE orders.ORDER_MODE%TYPE,       
    CUSTOMER_ID orders.CUSTOMER_ID%TYPE,       
    ORDER_STATUS orders.ORDER_STATUS%TYPE,       
    ORDER_TOTAL orders.ORDER_TOTAL%TYPE,       
    SALES_REP_ID orders.SALES_REP_ID%TYPE,       
    PROMOTION_ID orders.PROMOTION_ID%TYPE,  
    WAREHOUSE_ID orders.WAREHOUSE_ID%TYPE,  
    DELIVERY_TYPE orders.DELIVERY_TYPE%TYPE,  
    COST_OF_DELIVERY orders.COST_OF_DELIVERY%TYPE,  
    WAIT_TILL_ALL_AVAILABLE orders.WAIT_TILL_ALL_AVAILABLE%TYPE,  
    DELIVERY_ADDRESS_ID orders.DELIVERY_ADDRESS_ID%TYPE,  
    CUSTOMER_CLASS orders.CUSTOMER_CLASS%TYPE,  
    CARD_ID orders.card_id%TYPE,
    INVOICE_ADDRESS_ID orders.INVOICE_ADDRESS_ID%TYPE);       
TYPE order_tab       
IS       
  TABLE OF order_rec INDEX BY PLS_integer;       
TYPE order_item_rec       
IS       
  RECORD       
  (       
    ORDER_ID order_items.ORDER_ID%TYPE,       
    LINE_ITEM_ID order_items.LINE_ITEM_ID%TYPE,       
    PRODUCT_ID order_items.PRODUCT_ID%TYPE,       
    UNIT_PRICE order_items.UNIT_PRICE%TYPE,       
    QUANTITY order_items.QUANTITY%TYPE,  
    DISPATCH_DATE order_items.DISPATCH_DATE%TYPE,  
    RETURN_DATE order_items.RETURN_DATE%TYPE,  
    GIFT_WRAP order_items.GIFT_WRAP%TYPE,  
    CONDITION order_items.CONDITION%TYPE,  
    SUPPLIER_ID order_items.SUPPLIER_ID%TYPE,  
    ESTIMATED_DELIVERY order_items.ESTIMATED_DELIVERY%TYPE);       
TYPE order_item_tab       
IS       
  TABLE OF order_item_rec INDEX BY pls_integer;       
TYPE customer_rec       
IS       
  RECORD       
  (       
    CUSTOMER_ID customers.CUSTOMER_ID%TYPE,       
    CUST_FIRST_NAME customers.CUST_FIRST_NAME%TYPE,       
    CUST_LAST_NAME customers.CUST_LAST_NAME%TYPE,       
    NLS_LANGUAGE customers.NLS_LANGUAGE%TYPE,       
    NLS_TERRITORY customers.NLS_TERRITORY%TYPE,       
    CREDIT_LIMIT customers.CREDIT_LIMIT%TYPE,       
    CUST_EMAIL customers.CUST_EMAIL%TYPE,       
    ACCOUNT_MGR_ID customers.ACCOUNT_MGR_ID%TYPE,   
    CUSTOMER_SINCE customers.CUSTOMER_SINCE%TYPE,   
    CUSTOMER_CLASS customers.CUSTOMER_CLASS%TYPE,   
    SUGGESTIONS customers.SUGGESTIONS%TYPE,   
    DOB customers.DOB%TYPE,   
    MAILSHOT customers.MAILSHOT%TYPE,   
    PARTNER_MAILSHOT customers.PARTNER_MAILSHOT%TYPE,   
    PREFERRED_ADDRESS customers.PREFERRED_ADDRESS%TYPE,
    PREFERRED_CARD customers.PREFERRED_CARD%TYPE
    );      
TYPE customer_tab       
IS       
  TABLE OF customer_rec INDEX BY pls_integer;   
TYPE address_rec   
IS   
  RECORD   
  (ADDRESS_ID addresses.ADDRESS_ID%TYPE,   
  CUSTOMER_ID addresses.CUSTOMER_ID%TYPE,   
  DATE_CREATED addresses.DATE_CREATED%TYPE,   
  HOUSE_NO_OR_NAME addresses.HOUSE_NO_OR_NAME%TYPE,   
  STREET_NAME addresses.STREET_NAME%TYPE,   
  TOWN addresses.TOWN%TYPE,   
  COUNTY addresses.COUNTY%TYPE,   
  COUNTRY addresses.COUNTRY%TYPE,   
  POST_CODE addresses.POST_CODE%TYPE,   
  ZIP_CODE addresses.ZIP_CODE%TYPE);   
TYPE address_tab   
IS   
  TABLE of address_rec INDEX BY pls_integer;
TYPE card_rec
is
  RECORD
  (CARD_ID card_details.CARD_ID%TYPE,
    CUSTOMER_ID card_details.CUSTOMER_ID%TYPE,
    CARD_TYPE card_details.CARD_TYPE%TYPE,
    CARD_NUMBER card_details.CARD_NUMBER%TYPE,
    EXPIRY_DATE card_details.EXPIRY_DATE%TYPE,
    IS_VALID card_details.IS_VALID%TYPE,
    SECURITY_CODE card_details.SECURITY_CODE%TYPE);
TYPE card_details_tab
IS
  TABLE of card_rec INDEX by pls_integer;
TYPE integer_return_array     
is      
  varray(25) of integer;    
END;


-- End

