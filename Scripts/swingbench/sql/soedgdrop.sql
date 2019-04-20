DROP TABLE        customers             CASCADE CONSTRAINTS purge;

DROP TABLE        inventories           CASCADE CONSTRAINTS purge;

DROP TABLE        order_items           CASCADE CONSTRAINTS purge;

DROP TABLE        orders                CASCADE CONSTRAINTS purge;

DROP TABLE        product_descriptions  CASCADE CONSTRAINTS purge;

DROP TABLE        product_information   CASCADE CONSTRAINTS purge;

DROP TABLE        warehouses            CASCADE CONSTRAINTS purge;

DROP TABLE 		  logon                 CASCADE CONSTRAINTS purge;

DROP TABLE 		  orderentry_metadata   CASCADE CONSTRAINTS purge;

DROP SEQUENCE     orders_seq;

DROP SEQUENCE     customer_seq;

DROP VIEW         bombay_inventory;

DROP VIEW         product_prices;

DROP VIEW         products;

DROP VIEW         sydney_inventory;

DROP VIEW         toronto_inventory;

COMMIT;


