CREATE TABLE customers
    ( customer_id        NUMBER(12)     
    , cust_first_name    VARCHAR2(30) CONSTRAINT cust_fname_nn NOT NULL
    , cust_last_name     VARCHAR2(30) CONSTRAINT cust_lname_nn NOT NULL
    , nls_language       VARCHAR2(3)
    , nls_territory      VARCHAR2(30)
    , credit_limit       NUMBER(9,2)
    , cust_email         VARCHAR2(100)
    , account_mgr_id     NUMBER(6)
    ) &compress initrans 16;



CREATE TABLE warehouses
    ( warehouse_id       NUMBER(6) 
    , warehouse_name     VARCHAR2(35)
    , location_id        NUMBER(4)
    ) &compress;



CREATE TABLE order_items
    ( order_id           NUMBER(12) 
    , line_item_id       NUMBER(3)  NOT NULL
    , product_id         NUMBER(6)  NOT NULL
    , unit_price         NUMBER(8,2)
    , quantity           NUMBER(8)
    ) &compress initrans 16;


CREATE TABLE orders
    ( order_id           NUMBER(12)
    , order_date         TIMESTAMP WITH LOCAL TIME ZONE CONSTRAINT order_date_nn NOT NULL
    , order_mode         VARCHAR2(8)
    , customer_id        NUMBER(12) CONSTRAINT order_customer_id_nn NOT NULL
    , order_status       NUMBER(2)
    , order_total        NUMBER(8,2)
    , sales_rep_id       NUMBER(6)
    , promotion_id       NUMBER(6)
    , warehouse_id       NUMBER(6)
    ) &compress initrans 16;



CREATE TABLE inventories
   ( product_id         NUMBER(6)
   , warehouse_id       NUMBER(6) CONSTRAINT inventory_warehouse_id_nn NOT NULL
   , quantity_on_hand   NUMBER(8) CONSTRAINT inventory_qoh_nn NOT NULL
   ) &compress initrans 16 pctfree 90 pctused 5;


CREATE TABLE product_information
    ( product_id          NUMBER(6)
    , product_name        VARCHAR2(50)
    , product_description VARCHAR2(2000)
    , category_id         NUMBER(4)
    , weight_class        NUMBER(1)
    , warranty_period     INTERVAL YEAR TO MONTH
    , supplier_id         NUMBER(6)
    , product_status      VARCHAR2(20)
    , list_price          NUMBER(8,2)
    , min_price           NUMBER(8,2)
    , catalog_url         VARCHAR2(50)
    , CONSTRAINT          product_status_lov
                          CHECK (product_status in ('orderable'
                                                  ,'planned'
                                                  ,'under development'
                                                  ,'obsolete')
                               )
    ) &compress;


create table logon
    (CUSTOMER_ID	      NUMBER,
    LOGON_DATE            DATE) &compress initrans 16;
    

CREATE TABLE product_descriptions
    ( product_id             NUMBER(6)
    , language_id            VARCHAR2(3)
    , translated_name        NVARCHAR2(50) CONSTRAINT translated_name_nn NOT NULL
    , translated_description NVARCHAR2(2000) CONSTRAINT translated_desc_nn NOT NULL
    ) &compress;


CREATE TABLE orderentry_metadata
    ( metadata_key         varchar2(30),
      metadata_value       varchar2(30)
    );



-- End;


