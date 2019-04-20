rem
rem Header: oe_idx.sql 09-jan-01
rem
rem Copyright (c) 2001 Oracle Corporation.  All rights reserved.
rem
rem Owner  : ahunold
rem
rem NAME
rem   oe_idx.sql - create indexes for OE Common Schema
rem
rem DESCRIPTON
rem   Re-Creates indexes
rem
rem MODIFIED   (MM/DD/YY)
rem   ahunold   03/02/01 - eliminating DROP INDEX
rem   ahunold   01/30/01 - OE script headers
rem   ahunold   01/09/01 - checkin ADE

alter session enable parallel ddl;

CREATE INDEX whs_location_ix
ON warehouses (location_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX inv_product_ix
ON inventories (product_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX inv_warehouse_ix
ON inventories (warehouse_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX item_order_ix
ON order_items (order_id)
REVERSE tablespace &indextablespace &parallelclause &logging;

CREATE INDEX item_product_ix
ON order_items (product_id)
REVERSE tablespace &indextablespace &parallelclause &logging;

CREATE INDEX ord_sales_rep_ix
ON orders (sales_rep_id)
REVERSE tablespace &indextablespace &parallelclause &logging;

CREATE INDEX ord_customer_ix
ON orders (customer_id)
REVERSE tablespace &indextablespace &parallelclause &logging;

CREATE INDEX ord_order_date_ix
ON orders (order_date)
REVERSE tablespace &indextablespace &parallelclause &logging;

--CREATE INDEX ord_status_ix
--ON orders (order_status) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX ord_warehouse_ix
ON orders (warehouse_id, order_status) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX cust_account_manager_ix
ON customers (account_mgr_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX cust_lname_ix
ON customers (cust_last_name) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX cust_email_ix
ON customers (cust_email) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX prod_name_ix
ON product_descriptions (translated_name) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX prod_supplier_ix
ON product_information (supplier_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX prod_category_ix
ON product_information (category_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX cust_upper_name_ix
ON customers (UPPER(cust_last_name), UPPER(cust_first_name)) tablespace &indextablespace &parallelclause &logging;


