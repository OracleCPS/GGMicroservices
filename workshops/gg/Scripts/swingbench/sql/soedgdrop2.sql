DROP TABLE        customers             CASCADE CONSTRAINTS purge;

DROP TABLE        inventories           CASCADE CONSTRAINTS purge;

DROP TABLE        order_items           CASCADE CONSTRAINTS purge;

DROP TABLE        orders                CASCADE CONSTRAINTS purge;

DROP TABLE        addresses             CASCADE CONSTRAINTS purge;

DROP TABLE        card_details          CASCADE CONSTRAINTS purge;

DROP TABLE        product_descriptions  CASCADE CONSTRAINTS purge;

DROP TABLE        product_information   CASCADE CONSTRAINTS purge;

DROP TABLE        warehouses            CASCADE CONSTRAINTS purge;

DROP TABLE 		  logon                 CASCADE CONSTRAINTS purge;

DROP TABLE 		  orderentry_metadata   CASCADE CONSTRAINTS purge;

DROP SEQUENCE     orders_seq;

DROP SEQUENCE     customer_seq;

DROP SEQUENCE	  card_details_seq;

DROP SEQUENCE     address_seq;

DROP VIEW         product_prices;

DROP VIEW         products;

COMMIT;


