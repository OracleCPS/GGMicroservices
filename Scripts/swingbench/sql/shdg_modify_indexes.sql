alter index TIMES_PK parallel 1;

alter index SUPPLEMENTARY_DEMOGRAPHICS_PK parallel 1;

alter index CHANNELS_PK parallel 1;

alter index PRODUCTS_PK parallel 1;

alter index PROMOTIONS_PK parallel 1;

alter index COUNTRIES_PK parallel 1;

alter index CUSTOMERS_PK parallel 1;

alter index SALES_PROMO_BIX parallel 1;

alter index SALES_CHANNEL_BIX parallel 1;

alter index SALES_TIME_BIX parallel 1;

alter index SALES_CUST_BIX parallel 1;

alter index SALES_PROD_BIX parallel 1;

alter index PRODUCTS_PROD_CAT_IX parallel 1;

alter index PRODUCTS_PROD_SUBCAT_IX parallel 1;

alter index PRODUCTS_PROD_STATUS_BIX parallel 1;

alter index CUSTOMERS_GENDER_BIX parallel 1;

alter index CUSTOMERS_MARITAL_BIX parallel 1;

alter index CUSTOMERS_YOB_BIX parallel 1;

-- End;