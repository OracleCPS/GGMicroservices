-- Indexes for Order Entry Version 2

alter session enable parallel ddl;

CREATE INDEX whs_location_ix
ON warehouses (location_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX inv_product_ix
ON inventories (product_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX inv_warehouse_ix
ON inventories (warehouse_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX address_cust_ix
ON addresses (customer_id)
REVERSE tablespace &indextablespace &parallelclause &logging;

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

CREATE INDEX cust_dob_ix
ON customers (dob) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX cust_email_ix
ON customers (cust_email) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX prod_name_ix
ON product_descriptions (translated_name) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX prod_supplier_ix
ON product_information (supplier_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX prod_category_ix
ON product_information (category_id) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX cust_func_lower_name_ix
ON customers (lower(cust_last_name), lower(cust_first_name)) tablespace &indextablespace &parallelclause &logging;

CREATE INDEX carddetails_cust_ix
ON card_details(customer_id) tablespace &indextablespace &parallelclause &logging;


--End
