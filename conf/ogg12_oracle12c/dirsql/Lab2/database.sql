DROP TABLE orders_history;
DROP TABLE ordered_products_report;

DROP TABLE categories;
CREATE TABLE categories  (
  categories_id number(11) NOT NULL,
  categories_image varchar2(64),
  parent_id number(11) NOT NULL,
  sort_order number(3),
  date_added timestamp,
  last_modified timestamp,
  PRIMARY KEY (categories_id)
  using index
);

COMMIT;

DROP TABLE categories_description;
CREATE TABLE categories_description  (
  categories_id number(11) NOT NULL,
  language_id number(11) NOT NULL,
  categories_name varchar2(32) NOT NULL,
  PRIMARY KEY (categories_id,language_id)
  using index
);

COMMIT;

DROP TABLE products;
CREATE TABLE products (
  products_id number(11) NOT NULL,
  products_quantity number(4) NOT NULL,
  products_model varchar2(12),
  products_image varchar2(64),
  products_price number(15,4) NOT NULL,
  products_date_added timestamp NOT NULL,
  products_last_modified timestamp,
  products_date_available timestamp,
  products_weight number(5,2) NOT NULL,
  products_status number(1) NOT NULL,
  products_tax_class_id number(11) NOT NULL,
  manufacturers_id number(11),
  products_ordered number(11) NOT NULL,
  PRIMARY KEY (products_id)
  using index
);

COMMIT;

DROP TABLE products_description;
CREATE TABLE products_description  (
  products_id number(11) NOT NULL,
  language_id number(11) NOT NULL,
  products_name varchar2(64) NOT NULL,
  products_description varchar2(4000),
  products_url varchar2(255),
  products_viewed number(5),
  PRIMARY KEY (products_id,language_id)
  using index
);

COMMIT;

DROP TABLE products_to_categories;
CREATE TABLE products_to_categories (
  products_id number(11) NOT NULL,
  categories_id number(11) NOT NULL
);

COMMIT;

DROP TABLE customers;
CREATE TABLE customers  (
  customers_id number(11) NOT NULL,
  customers_gender char(1),
  customers_firstname varchar2(255) NOT NULL,
  customers_lastname varchar2(255) NOT NULL,
  customers_email_address varchar2(255) NOT NULL,
  customers_default_address_id number(11),
  customers_telephone varchar2(255) NOT NULL,
  customers_fax varchar2(255),
  customers_password varchar2(60) NOT NULL,
  customers_newsletter char(1),
  PRIMARY KEY (customers_id)
  using index
);

COMMIT;

DROP TABLE customers_info;
CREATE TABLE customers_info  (
  customers_info_id number(11) NOT NULL,
  customers_info_last_logon timestamp,
  customers_info_number_logons number(5),
  customers_info_created_ts timestamp,
  customers_info_last_modified timestamp,
  global_product_notifications number(1),
  PRIMARY KEY (customers_info_id)
  using index
);

COMMIT;

DROP TABLE orders;
CREATE TABLE orders  (
  orders_id number(11) NOT NULL,
  customers_id number(11) NOT NULL,
  customers_name varchar2(255) NOT NULL,
  customers_company varchar2(255),
  customers_street_address varchar2(255) NOT NULL,
  customers_suburb varchar2(255),
  customers_city varchar2(255) NOT NULL,
  customers_postcode varchar2(255) NOT NULL,
  customers_state varchar2(255),
  customers_country varchar2(255) NOT NULL,
  customers_telephone varchar2(255) NOT NULL,
  customers_email_address varchar2(255) NOT NULL,
  customers_address_format_id number(5) NOT NULL,
  delivery_name varchar2(255) NOT NULL,
  delivery_company varchar2(255),
  delivery_street_address varchar2(255) NOT NULL,
  delivery_suburb varchar2(255),
  delivery_city varchar2(255) NOT NULL,
  delivery_postcode varchar2(255) NOT NULL,
  delivery_state varchar2(255),
  delivery_country varchar2(255) NOT NULL,
  delivery_address_format_id number(5) NOT NULL,
  billing_name varchar2(255) NOT NULL,
  billing_company varchar2(255),
  billing_street_address varchar2(255) NOT NULL,
  billing_suburb varchar2(255),
  billing_city varchar2(255) NOT NULL,
  billing_postcode varchar2(255) NOT NULL,
  billing_state varchar2(255),
  billing_country varchar2(255) NOT NULL,
  billing_address_format_id number(5) NOT NULL,
  payment_method varchar2(255) NOT NULL,
  cc_type varchar2(20),
  cc_owner varchar2(255),
  cc_number varchar2(32),
  cc_expires varchar2(4),
  last_modified timestamp,
  date_purchased timestamp,
  orders_status number(5) NOT NULL,
  orders_date_finished timestamp,
  currency char(3),
  currency_value number(14,6),
  PRIMARY KEY (orders_id)
  using index
);

COMMIT;

DROP TABLE orders_products;
CREATE TABLE orders_products  (
  orders_products_id number(11) NOT NULL,
  orders_id number(11) NOT NULL,
  products_id number(11) NOT NULL,
  products_model varchar2(12),
  products_name varchar2(64) NOT NULL,
  products_price number(15,4) NOT NULL,
  final_price number(15,4) NOT NULL,
  products_tax number(7,4) NOT NULL,
  products_quantity number(2) NOT NULL,
  PRIMARY KEY (orders_products_id)
  using index
);

COMMIT;

DROP TABLE orders_status_history;
CREATE TABLE orders_status_history  (
  orders_status_history_id number(11) NOT NULL,
  orders_id number(11) NOT NULL,
  orders_status number(5) NOT NULL,
  date_added timestamp NOT NULL,
  customer_notified number(1),
  comments varchar2(4000),
  PRIMARY KEY (orders_status_history_id, orders_id, date_added)
  using index
);

COMMIT;

DROP TABLE orders_total;
CREATE TABLE orders_total  (
  orders_total_id number(10) NOT NULL,
  orders_id number(11) NOT NULL,
  title varchar2(255) NOT NULL,
  text varchar2(255) NOT NULL,
  orders_value number(15,4) NOT NULL,
  class varchar2(32) NOT NULL,
  sort_order number(11) NOT NULL,
  PRIMARY KEY (orders_total_id)
  using index
);

COMMIT;

DROP TABLE next_cust;
CREATE TABLE next_cust (
 customers_id number(11) NOT NULL,
  primary key (customers_id)
  using index
);

COMMIT;

DROP TABLE next_order;
CREATE TABLE next_order  (
  orders_id number(11) NOT NULL,
  primary key (orders_id)
  using index
);

COMMIT;

DROP TABLE customers_lkup;
CREATE TABLE customers_lkup  (
  lkup_id number(11),
  customers_gender char(1),
  customers_firstname varchar2(255) NOT NULL,
  customers_lastname varchar2(255) NOT NULL,
  customers_street varchar2(50) NOT NULL,
  customers_city varchar2(50) NOT NULL,
  customers_state char (2) NOT NULL,
  PRIMARY KEY (lkup_id)
  using index
);

COMMIT;

EXIT;
/
