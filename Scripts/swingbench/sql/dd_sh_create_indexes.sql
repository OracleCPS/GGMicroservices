
-- Create Indexes

CREATE UNIQUE INDEX customers_pk ON customers (cust_id) tablespace &indextablespace &parallelclause &logging;

ALTER TABLE customers ADD ( CONSTRAINT customers_pk PRIMARY KEY (cust_id) novalidate);

CREATE UNIQUE INDEX SUPPLEMENTARY_DEMOGRAPHICS_PK ON SUPPLEMENTARY_DEMOGRAPHICS (CUST_ID) tablespace &indextablespace &parallelclause &logging;

-- ALTER TABLE sales ADD CONSTRAINT sales_uk UNIQUE (prod_id, cust_id, promo_id, channel_id, time_id) RELY DISABLE NOVALIDATE;

alter table supplementary_demographics add constraint supplementary_demographics_pk primary key (cust_id) rely DISABLE novalidate;

-- ALTER TABLE sales ADD CONSTRAINT sales_times_fk FOREIGN KEY (time_id) REFERENCES times (time_id) RELY DISABLE NOVALIDATE;

-- ALTER TABLE sales ADD CONSTRAINT sales_customers_fk FOREIGN KEY (cust_id) REFERENCES customers (cust_id) RELY DISABLE NOVALIDATE;

-- ALTER TABLE sales ADD CONSTRAINT sales_products_fk FOREIGN KEY (prod_id) REFERENCES products (prod_id) RELY DISABLE NOVALIDATE;

-- ALTER TABLE sales ADD CONSTRAINT sales_channels_fk FOREIGN KEY (channel_id) REFERENCES channels (channel_id) RELY DISABLE NOVALIDATE;

-- ALTER TABLE sales ADD CONSTRAINT sales_promotions_fk FOREIGN KEY (promo_id) REFERENCES promotions (promo_id) RELY DISABLE NOVALIDATE;

-- ALTER TABLE customers ADD CONSTRAINT cust_countries_fk FOREIGN KEY (country_id) REFERENCES countries (country_id) RELY DISABLE NOVALIDATE;

CREATE BITMAP INDEX CUSTOMERS_MARITAL_BIX ON CUSTOMERS (CUST_MARITAL_STATUS) TABLESPACE &indextablespace &parallelclause &logging compute statistics;

CREATE BITMAP INDEX CUSTOMERS_YOB_BIX ON CUSTOMERS (CUST_YEAR_OF_BIRTH) TABLESPACE &indextablespace &parallelclause &logging compute statistics;

CREATE BITMAP INDEX CUSTOMERS_GENDER_BIX ON CUSTOMERS (CUST_GENDER) TABLESPACE &indextablespace &parallelclause &logging compute statistics;

CREATE BITMAP INDEX SALES_PROD_BIX ON SALES (PROD_ID) TABLESPACE &indextablespace &parallelclause &logging compute statistics;

CREATE BITMAP INDEX SALES_CUST_BIX ON SALES (CUST_ID) TABLESPACE &indextablespace &parallelclause &logging compute statistics;

CREATE BITMAP INDEX SALES_TIME_BIX ON SALES (TIME_ID) TABLESPACE &indextablespace &parallelclause &logging compute statistics;

CREATE BITMAP INDEX SALES_CHANNEL_BIX ON SALES (CHANNEL_ID) TABLESPACE &indextablespace &parallelclause &logging compute statistics;

CREATE BITMAP INDEX SALES_PROMO_BIX ON SALES (PROMO_ID) TABLESPACE &indextablespace &parallelclause &logging compute statistics;


-- End;

