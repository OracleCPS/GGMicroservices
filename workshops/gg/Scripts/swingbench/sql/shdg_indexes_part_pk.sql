CREATE UNIQUE INDEX customers_pk ON customers (cust_id) LOCAL tablespace &indextablespace &parallelclause &logging compute statistics;

ALTER TABLE customers
ADD ( CONSTRAINT customers_pk PRIMARY KEY (cust_id) novalidate);

CREATE UNIQUE INDEX countries_pk ON COUNTRIES (country_id) tablespace &indextablespace &parallelclause &logging compute statistics;

ALTER TABLE countries
ADD ( CONSTRAINT countries_pk PRIMARY KEY (country_id) novalidate);

CREATE UNIQUE INDEX promotions_pk ON PROMOTIONS (PROMO_ID) tablespace &indextablespace &parallelclause &logging compute statistics;

ALTER TABLE PROMOTIONS
ADD ( CONSTRAINT promotions_pk PRIMARY KEY (PROMO_ID) novalidate);

CREATE UNIQUE INDEX PRODUCTS_PK ON PRODUCTS (PROD_ID) tablespace &indextablespace &parallelclause &logging compute statistics;

ALTER TABLE PRODUCTS
ADD ( CONSTRAINT products_pk PRIMARY KEY (PROD_ID) novalidate);

CREATE UNIQUE INDEX CHANNELS_PK ON CHANNELS (CHANNEL_ID) tablespace &indextablespace &parallelclause &logging compute statistics;

ALTER TABLE CHANNELS
ADD ( CONSTRAINT CHANNELS_PK PRIMARY KEY (CHANNEL_ID) novalidate);

CREATE UNIQUE INDEX SUPPLEMENTARY_DEMOGRAPHICS_PK ON SUPPLEMENTARY_DEMOGRAPHICS (CUST_ID) LOCAL tablespace &indextablespace &parallelclause &logging compute statistics;

ALTER TABLE SUPPLEMENTARY_DEMOGRAPHICS
ADD ( CONSTRAINT SUPPLEMENTARY_DEMOGRAPHICS_PK PRIMARY KEY (CUST_ID) novalidate);

CREATE UNIQUE INDEX times_pk ON times (time_id) tablespace  &indextablespace &parallelclause &logging compute statistics;

ALTER TABLE TIMES
ADD ( CONSTRAINT TIMES_PK PRIMARY KEY (TIME_ID) novalidate);


-- End of script