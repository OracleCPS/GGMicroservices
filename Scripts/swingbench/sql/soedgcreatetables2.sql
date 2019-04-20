
-- Version 2 of the swingbench simple order entry benchmark schema
-- Includes additional columns to some tables and a new table addresses

CREATE TABLE customers
  ( customer_id           NUMBER(12) CONSTRAINT cust_custid_nn NOT NULL,
    cust_first_name       VARCHAR2(40) CONSTRAINT cust_fname_nn NOT NULL ,
    cust_last_name        VARCHAR2(40) CONSTRAINT cust_lname_nn NOT NULL ,
    nls_language          VARCHAR2(3) ,
    nls_territory         VARCHAR2(30) ,
    credit_limit          NUMBER(9,2) ,
    cust_email            VARCHAR2(100) ,
    account_mgr_id        NUMBER(12),
    customer_since        DATE,
    customer_class        VARCHAR(40),
    suggestions           VARCHAR(40),
    dob                   DATE,
    mailshot              VARCHAR(1),
    partner_mailshot      VARCHAR(1),
    preferred_address	    NUMBER(12),
    preferred_card        NUMBER(12)
    ) &compress initrans 16
    STORAGE (INITIAL 8M NEXT 8M);


CREATE TABLE addresses
  ( address_id            NUMBER(12)  CONSTRAINT address_id_nn NOT NULL,
  	customer_id           NUMBER(12) CONSTRAINT address_cust_id_nn NOT NULL,
    date_created          DATE CONSTRAINT address_datec_nn NOT NULL,
    house_no_or_name      VARCHAR2(60),
    street_name           VARCHAR2(60),
    town                  VARCHAR2(60),
    county                VARCHAR2(60),
    country               VARCHAR2(60),
    post_code             VARCHAR(12),
    zip_code              VARCHAR(12)
    ) &compress initrans 16
    STORAGE (INITIAL 8M NEXT 8M);



CREATE TABLE card_details
  ( card_id       NUMBER(12) CONSTRAINT card_id_nn NOT NULL,
    customer_id   NUMBER(12) CONSTRAINT card_cust_id_nn NOT NULL,
    card_type     VARCHAR2(30) CONSTRAINT card_type_nn NOT NULL,
    card_number   NUMBER(12) CONSTRAINT card_number_nn NOT NULL,
    expiry_date   DATE CONSTRAINT expiry_date_nn NOT NULL,
    is_valid      VARCHAR2(1) CONSTRAINT is_valid_nn NOT NULL,
    security_code NUMBER(6)
  ) &compress initrans 16
  STORAGE (INITIAL 8M NEXT 8M);



CREATE TABLE warehouses
    ( warehouse_id          NUMBER(6) 
    , warehouse_name        VARCHAR2(35)
    , location_id           NUMBER(4)
    ) &compress;



CREATE TABLE order_items
  (
    order_id                NUMBER(12) CONSTRAINT oi_order_id_nn NOT NULL ,
    line_item_id            NUMBER(3) CONSTRAINT oi_lineitem_id_nn NOT NULL ,
    product_id              NUMBER(6) CONSTRAINT oi_product_id_nn NOT NULL ,
    unit_price              NUMBER(8,2),
    quantity                NUMBER(8),
    dispatch_date           DATE,
    return_date             DATE,
    gift_wrap               VARCHAR(20),
    condition               VARCHAR(20),
    supplier_id             NUMBER(6),
    estimated_delivery      DATE 
    ) &compress initrans 16
    STORAGE (INITIAL 8M NEXT 8M);



CREATE TABLE orders
  ( order_id                NUMBER(12) CONSTRAINT order_order_id_nn NOT NULL ,
    order_date              TIMESTAMP WITH LOCAL TIME ZONE CONSTRAINT order_date_nn NOT NULL ,
    order_mode              VARCHAR2(8) ,
    customer_id             NUMBER(12) CONSTRAINT order_customer_id_nn NOT NULL ,
    order_status            NUMBER(2),
    order_total             NUMBER(8,2),
    sales_rep_id            NUMBER(6),
    promotion_id            NUMBER(6),
    warehouse_id            NUMBER(6), 
    delivery_type           VARCHAR(15),
    cost_of_delivery        NUMBER(6),
    wait_till_all_available VARCHAR(15),
    delivery_address_id     NUMBER(12),
    customer_class          VARCHAR(30),
    card_id                 NUMBER(12),
    invoice_address_id      NUMBER(12)
    ) &compress initrans 16
    STORAGE (INITIAL 8M NEXT 8M);



CREATE TABLE inventories
   ( product_id             NUMBER(6) CONSTRAINT inventory_prooduct_id_nn NOT NULL
   , warehouse_id           NUMBER(6) CONSTRAINT inventory_warehouse_id_nn NOT NULL
   , quantity_on_hand       NUMBER(8) CONSTRAINT inventory_qoh_nn NOT NULL
   ) &compress initrans 16 pctfree 90 pctused 5;



CREATE TABLE product_information
    ( product_id            NUMBER(6) CONSTRAINT product_product_id_nn NOT NULL
    , product_name          VARCHAR2(50) CONSTRAINT product_product_name_nn NOT NULL
    , product_description   VARCHAR2(2000)
    , category_id           NUMBER(4) CONSTRAINT product_category_id_nn NOT NULL
    , weight_class          NUMBER(1)
    , warranty_period       INTERVAL YEAR TO MONTH
    , supplier_id           NUMBER(6)
    , product_status        VARCHAR2(20)
    , list_price            NUMBER(8,2)
    , min_price             NUMBER(8,2)
    , catalog_url           VARCHAR2(50)
    , CONSTRAINT            product_status_lov
                            CHECK (product_status in ('orderable'
                                                  ,'planned'
                                                  ,'under development'
                                                  ,'obsolete')
                               )
    ) &compress;



create table logon
    (logon_id				NUMBER CONSTRAINT logon_logon_id_nn NOT NULL,
    customer_id	          	NUMBER CONSTRAINT logon_customer_id_nn NOT NULL,
    logon_date              DATE
    ) &compress initrans 16
    STORAGE (INITIAL 8M NEXT 8M);



CREATE TABLE product_descriptions
    ( product_id             NUMBER(6)
    , language_id            VARCHAR2(3)
    , translated_name        NVARCHAR2(50) CONSTRAINT translated_name_nn NOT NULL
    , translated_description NVARCHAR2(2000) CONSTRAINT translated_desc_nn NOT NULL
    ) &compress;



CREATE TABLE orderentry_metadata
  (
    metadata_key            VARCHAR2(30),
    metadata_value          VARCHAR2(30)
  );



-- End;


