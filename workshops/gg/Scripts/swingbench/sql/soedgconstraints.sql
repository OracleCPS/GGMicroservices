CREATE UNIQUE INDEX customers_pk ON customers (customer_id) reverse tablespace &indextablespace &parallelclause &logging;

ALTER TABLE customers
ADD ( CONSTRAINT customers_pk PRIMARY KEY (customer_id) novalidate);

ALTER TABLE CUSTOMERS
ADD ( CONSTRAINT customer_credit_limit_max CHECK (credit_limit <= 50000) DEFERRABLE NOVALIDATE );

ALTER TABLE CUSTOMERS
ADD ( CONSTRAINT customer_id_min CHECK (customer_id > 0) DEFERRABLE NOVALIDATE );

CREATE UNIQUE INDEX warehouses_pk ON warehouses (warehouse_id) tablespace &indextablespace &parallelclause &logging;

ALTER TABLE warehouses
ADD (CONSTRAINT warehouses_pk PRIMARY KEY (warehouse_id) novalidate);

CREATE UNIQUE INDEX order_items_pk ON order_items (order_id, line_item_id) reverse tablespace &indextablespace &parallelclause &logging;

-- CREATE UNIQUE INDEX order_items_uk ON order_items (order_id, product_id) tablespace &indextablespace nologging;

ALTER TABLE order_items
ADD ( CONSTRAINT order_items_pk PRIMARY KEY (order_id, line_item_id) novalidate);

CREATE UNIQUE INDEX order_pk ON orders (order_id) reverse tablespace &indextablespace &parallelclause &logging;

ALTER TABLE orders 
ADD ( CONSTRAINT order_pk PRIMARY KEY (order_id) novalidate);

ALTER TABLE product_information
ADD ( CONSTRAINT product_information_pk PRIMARY KEY (product_id));

CREATE UNIQUE INDEX prd_desc_pk ON product_descriptions(product_id,language_id) tablespace &indextablespace &parallelclause &logging;

ALTER TABLE ORDERS
ADD (constraint order_mode_lov CHECK(order_mode in ('direct','online')) DEFERRABLE NOVALIDATE );

ALTER TABLE ORDERS
ADD (constraint order_total_min CHECK(order_total >= 0) DEFERRABLE NOVALIDATE );

ALTER TABLE product_descriptions
ADD ( CONSTRAINT product_descriptions_pk PRIMARY KEY (product_id, language_id) novalidate);

ALTER TABLE orders ADD ( CONSTRAINT orders_customer_id_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE SET NULL novalidate) ;

ALTER TABLE inventories
ADD (CONSTRAINT inventory_pk PRIMARY KEY (product_id, warehouse_id) novalidate);

ALTER TABLE inventories
ADD ( CONSTRAINT inventories_warehouses_fk FOREIGN KEY (warehouse_id) REFERENCES warehouses (warehouse_id) ENABLE NOVALIDATE ) ;

ALTER TABLE inventories
ADD ( CONSTRAINT inventories_product_id_fk FOREIGN KEY (product_id) REFERENCES product_information (product_id) novalidate);

ALTER TABLE order_items
ADD ( CONSTRAINT order_items_order_id_fk FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE enable novalidate );

ALTER TABLE order_items
ADD ( CONSTRAINT order_items_product_id_fk FOREIGN KEY (product_id) REFERENCES product_information(product_id) novalidate);

ALTER TABLE product_descriptions
ADD ( CONSTRAINT pd_product_id_fk FOREIGN KEY (product_id) REFERENCES product_information(product_id));
