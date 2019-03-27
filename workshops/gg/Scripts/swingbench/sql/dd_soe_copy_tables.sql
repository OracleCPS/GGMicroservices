
-- Create SOE Temp Tables

-- Suppress Warnings

DROP TABLE CUSTOMERS_C PURGE;

DROP TABLE ADDRESSES_C PURGE;

DROP TABLE CARD_DETAILS_C PURGE;

DROP TABLE ORDER_ITEMS_C PURGE;

DROP TABLE ORDERS_C PURGE;

-- End Suppress Warnings

CREATE TABLE CUSTOMERS_C
  ( customer_id           NUMBER(12),
    cust_first_name       VARCHAR2(40),
    cust_last_name        VARCHAR2(40),
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
    ) TABLESPACE &tablespace &usecompression initrans 32
    STORAGE (INITIAL 64M NEXT 64M);


CREATE TABLE ADDRESSES_C
  ( address_id            NUMBER(12) ,
    customer_id           NUMBER(12),
    date_created          DATE,
    house_no_or_name      VARCHAR2(60),
    street_name           VARCHAR2(60),
    town                  VARCHAR2(60),
    county                VARCHAR2(60),
    country               VARCHAR2(60),
    post_code             VARCHAR(12),
    zip_code              VARCHAR(12)
    ) TABLESPACE &tablespace &usecompression initrans 32
    STORAGE (INITIAL 64M NEXT 64M);


CREATE TABLE CARD_DETAILS_C
  ( card_id       NUMBER(12),
    customer_id   NUMBER(12),
    card_type     VARCHAR2(30),
    card_number   NUMBER(12),
    expiry_date   DATE,
    is_valid      VARCHAR2(1),
    security_code NUMBER(6)
  ) TABLESPACE &tablespace &usecompression initrans 32
  STORAGE (INITIAL 64M NEXT 64M);

CREATE TABLE ORDER_ITEMS_C
  (
    order_id                NUMBER(12),
    line_item_id            NUMBER(3),
    product_id              NUMBER(6),
    unit_price              NUMBER(8,2),
    quantity                NUMBER(8),
    dispatch_date           DATE,
    return_date             DATE,
    gift_wrap               VARCHAR(20),
    condition               VARCHAR(20),
    supplier_id             NUMBER(6),
    estimated_delivery      DATE 
    ) TABLESPACE &tablespace &usecompression initrans 32
    STORAGE (INITIAL 64M NEXT 64M);

CREATE TABLE ORDERS_C
  ( order_id                NUMBER(12),
    order_date              TIMESTAMP WITH LOCAL TIME ZONE,
    order_mode              VARCHAR2(8) ,
    customer_id             NUMBER(12),
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
    ) TABLESPACE &tablespace &usecompression initrans 32
    STORAGE (INITIAL 64M NEXT 64M);


-- End Script;
