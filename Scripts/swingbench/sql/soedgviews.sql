rem
rem Header: oe_views.sql 09-jan-01
rem
rem Copyright (c) 2001 Oracle Corporation.  All rights reserved.
rem
rem Owner  : ahunold
rem
rem NAME
rem   oe_views.sql - OE Common Schema
rem
rem DESCRIPTON
rem   Create all views
rem
rem MODIFIED   (MM/DD/YY)
rem   ahunold   01/09/01 - checkin ADE
rem   dgiles    18/09/14 - removed syscontext call for swingbench schema
rem
rem

CREATE OR REPLACE VIEW products
AS
SELECT i.product_id
,      d.language_id
,      CASE WHEN d.language_id IS NOT NULL
            THEN d.translated_name
            ELSE TRANSLATE(i.product_name USING NCHAR_CS)
       END    AS product_name
,      i.category_id
,      CASE WHEN d.language_id IS NOT NULL
            THEN d.translated_description
            ELSE TRANSLATE(i.product_description USING NCHAR_CS)
       END    AS product_description
,      i.weight_class
,      i.warranty_period
,      i.supplier_id
,      i.product_status
,      i.list_price
,      i.min_price
,      i.catalog_url
FROM   product_information  i
,      product_descriptions d
WHERE  d.product_id  (+) = i.product_id;


REM =======================================================
REM Create product_prices view of product_information
REM columns to show view with a GROUP BY clause.
REM =======================================================

CREATE OR REPLACE VIEW product_prices
AS
SELECT category_id
,      COUNT(*)        as "#_OF_PRODUCTS"
,      MIN(list_price) as low_price
,      MAX(list_price) as high_price
FROM   product_information
GROUP BY category_id;


