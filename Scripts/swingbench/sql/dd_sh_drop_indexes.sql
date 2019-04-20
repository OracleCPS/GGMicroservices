
-- drop constraints and indexes.

-- Suppress Warnings

alter table SALES drop constraint SALES_CUSTOMERS_FK;

alter table SALES drop constraint SALES_PRODUCTS_FK;

alter table SALES drop constraint SALES_CHANNELS_FK;

alter table SALES drop constraint SALES_PROMOTIONS_FK;

alter table SALES drop constraint SALES_UK;

alter table SALES drop constraint SALES_TIMES_FK;

alter table CUSTOMERS drop constraint CUST_COUNTRIES_FK;

alter table CUSTOMERS drop primary key;

alter table COUNTRIES drop primary key;

alter table PROMOTIONS drop primary key;

alter table PRODUCTS drop primary key;

alter table CHANNELS drop primary key;

alter table SUPPLEMENTARY_DEMOGRAPHICS drop primary key;

alter table TIMES drop primary key;

drop index CHANNELS_PK;

drop index COUNTRIES_PK;

drop index CUSTOMERS_GENDER_BIX;

drop index CUSTOMERS_MARITAL_BIX;

drop index CUSTOMERS_PK;

drop index CUSTOMERS_YOB_BIX;

drop index PRODUCTS_PK;

drop index PRODUCTS_PROD_CAT_IX;

drop index PRODUCTS_PROD_STATUS_BIX;

drop index PRODUCTS_PROD_SUBCAT_IX;

drop index PROMOTIONS_PK;

drop index SALES_CHANNEL_BIX;

drop index SALES_CUST_BIX;

drop index SALES_PROD_BIX;

drop index SALES_PROMO_BIX;

drop index SALES_TIME_BIX;

drop index SUPPLEMENTARY_DEMOGRAPHICS_PK;

drop index TIMES_PK;

-- End Suppress Warnings

-- End of Script
