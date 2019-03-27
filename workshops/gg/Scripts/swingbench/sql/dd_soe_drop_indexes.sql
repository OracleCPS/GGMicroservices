
-- drop constraints and indexes.

-- Suppress Warnings

ALTER TABLE ORDER_ITEMS drop constraint ORDER_ITEMS_PRODUCT_ID_FK;

ALTER TABLE ORDER_ITEMS drop constraint ORDER_ITEMS_ORDER_ID_FK;

ALTER TABLE INVENTORIES drop constraint INVENTORIES_PRODUCT_ID_FK;

ALTER TABLE INVENTORIES drop constraint INVENTORIES_WAREHOUSES_FK;

ALTER TABLE ORDERS drop constraint ORDERS_CUSTOMER_ID_FK;

ALTER TABLE ADDRESSES drop constraint ADD_CUST_FK;

ALTER TABLE INVENTORIES drop primary key;

ALTER TABLE PRODUCT_DESCRIPTIONS drop primary key;

ALTER TABLE PRODUCT_INFORMATION drop primary key;

ALTER TABLE ORDERS drop primary key;

ALTER TABLE ORDER_ITEMS drop primary key;

ALTER TABLE WAREHOUSES drop primary key;

ALTER TABLE CARD_DETAILS drop primary key;

ALTER TABLE ADDRESSES drop primary key;

ALTER TABLE CUSTOMERS drop primary key;

ALTER TABLE orders DROP CONSTRAINT ORDER_MODE_LOV;

ALTER TABLE orders DROP CONSTRAINT ORDER_TOTAL_MIN;

ALTER TABLE customers DROP CONSTRAINT CUSTOMER_ID_MIN;

ALTER TABLE customers DROP CONSTRAINT CUSTOMER_CREDIT_LIMIT_MAX;

drop index ADDRESS_CUST_IX;

drop index ADDRESS_PK;

drop index CARDDETAILS_CUST_IX;

drop index CARD_DETAILS_PK;

drop index CUSTOMERS_PK;

drop index CUST_ACCOUNT_MANAGER_IX;

drop index CUST_DOB_IX;

drop index CUST_EMAIL_IX;

drop index CUST_FUNC_LOWER_NAME_IX;

drop index INV_PRODUCT_IX;

drop index INV_WAREHOUSE_IX;

drop index ITEM_ORDER_IX;

drop index ITEM_PRODUCT_IX;

drop index ORDER_ITEMS_PK;

drop index ORDER_PK;

drop index ORD_CUSTOMER_IX;

drop index ORD_ORDER_DATE_IX;

drop index ORD_SALES_REP_IX;

drop index ORD_WAREHOUSE_IX;

drop index PRD_DESC_PK;

drop index PROD_CATEGORY_IX;

drop index PROD_NAME_IX;

drop index PROD_SUPPLIER_IX;

drop index WAREHOUSES_PK;

drop index WHS_LOCATION_IX;

-- End Suppress Warnings


-- End of Script;
