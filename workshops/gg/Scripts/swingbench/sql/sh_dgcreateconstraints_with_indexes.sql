alter table sales add CONSTRAINT sales_uk unique (prod_id, cust_id, promo_id, channel_id, time_id) RELY DISABLE NOVALIDATE;

-- alter table times add constraint times_pk primary key (time_id) rely DISABLE novalidate;

ALTER TABLE sales ADD CONSTRAINT sales_times_fk
FOREIGN KEY (time_id) REFERENCES times (time_id)
 DISABLE NOVALIDATE;

ALTER TABLE sales ADD CONSTRAINT sales_customers_fk
FOREIGN KEY (cust_id) REFERENCES customers (cust_id)
 DISABLE NOVALIDATE;

ALTER TABLE sales ADD CONSTRAINT sales_products_fk
FOREIGN KEY (prod_id) REFERENCES products (prod_id)
 DISABLE NOVALIDATE;

ALTER TABLE sales ADD CONSTRAINT sales_channels_fk
FOREIGN KEY (channel_id) REFERENCES channels (channel_id)
 DISABLE NOVALIDATE;

ALTER TABLE sales ADD CONSTRAINT sales_promotions_fk
FOREIGN KEY (promo_id) REFERENCES promotions (promo_id)
 DISABLE NOVALIDATE;

ALTER TABLE customers ADD CONSTRAINT cust_countries_fk
FOREIGN KEY (country_id) REFERENCES countries (country_id)
 DISABLE NOVALIDATE;

-- End;