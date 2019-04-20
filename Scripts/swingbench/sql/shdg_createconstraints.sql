ALTER TABLE sales ADD CONSTRAINT sales_uk UNIQUE (prod_id, cust_id, promo_id, channel_id, time_id) RELY DISABLE NOVALIDATE;

alter table times add constraint times_pk primary key (time_id) rely DISABLE novalidate;

alter table customers add constraint customers_pk primary key (cust_id) rely DISABLE novalidate;

alter table products add constraint products_pk primary key (prod_id) rely DISABLE novalidate;

alter table channels add constraint channels_pk primary key (channel_id) rely DISABLE novalidate;

alter table countries add constraint countries_pk primary key (country_id) rely DISABLE novalidate;

alter table promotions add constraint promotions_pk primary key (promo_id) rely DISABLE novalidate;

alter table supplementary_demographics add constraint supplementary_demographics_pk primary key (cust_id) rely DISABLE novalidate;

ALTER TABLE sales ADD CONSTRAINT sales_times_fk
FOREIGN KEY (time_id) REFERENCES times (time_id)
RELY DISABLE NOVALIDATE;

ALTER TABLE sales ADD CONSTRAINT sales_customers_fk
FOREIGN KEY (cust_id) REFERENCES customers (cust_id)
RELY DISABLE NOVALIDATE;

ALTER TABLE sales ADD CONSTRAINT sales_products_fk
FOREIGN KEY (prod_id) REFERENCES products (prod_id)
RELY DISABLE NOVALIDATE;

ALTER TABLE sales ADD CONSTRAINT sales_channels_fk
FOREIGN KEY (channel_id) REFERENCES channels (channel_id)
RELY DISABLE NOVALIDATE;

ALTER TABLE sales ADD CONSTRAINT sales_promotions_fk
FOREIGN KEY (promo_id) REFERENCES promotions (promo_id)
RELY DISABLE NOVALIDATE;

ALTER TABLE customers ADD CONSTRAINT cust_countries_fk
FOREIGN KEY (country_id) REFERENCES countries (country_id)
RELY DISABLE NOVALIDATE;

-- End;