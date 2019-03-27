WITH need_to_process AS
  (SELECT order_id,
    /* we're only looking for unprocessed orders */
    customer_id
  FROM orders
  WHERE order_status <= 4
  AND warehouse_id    = 1
  AND rownum          < 10
  )
SELECT o.order_id,
  oi.line_item_id,
  oi.product_id,
  oi.unit_price,
  oi.quantity,
  o.order_mode,
  o.order_status,
  o.order_total,
  o.sales_rep_id,
  o.promotion_id,
  c.customer_id,
  c.cust_first_name,
  c.cust_last_name,
  c.credit_limit,
  c.cust_email,
  o.order_date
FROM orders o,
  need_to_process ntp,
  customers c,
  order_items oi
WHERE ntp.order_id  = o.order_id
AND c.customer_id   = o.customer_id
AND oi.order_id (+) = o.order_id;

UPDATE inventories
SET quantity_on_hand = 1
WHERE product_id     = 1
AND warehouse_id     = 1;


SELECT tt.ORDER_TOTAL,
  tt.SALES_REP_ID,
  tt.ORDER_DATE,
  customers.CUST_FIRST_NAME,
  customers.CUST_LAST_NAME
FROM
  (SELECT orders.ORDER_TOTAL,
    orders.SALES_REP_ID,
    orders.ORDER_DATE,
    orders.customer_id,
    rank() Over (Order By orders.ORDER_TOTAL DESC) sal_rank
  FROM orders
  WHERE orders.SALES_REP_ID = 1
  ) tt,
  customers
WHERE tt.sal_rank        <= 10
AND customers.customer_id = tt.customer_id;


WITH stage1 AS -- get 12 rows of 5mins
  (SELECT
    /*+ materialize CARDINALITY(12) */
    (rownum*(1/288)) offset
  FROM dual
    CONNECT BY rownum <= 12
  ),
  stage2 AS -- get 12 rows with 2 columns, 1 col lagged behind the other
  (SELECT
    /*+ materialize CARDINALITY(12) */
    lag(offset, 1, 0) over (order by rownum) ostart,
    offset oend
  FROM stage1
  ),
  stage3 AS -- transform them to timestamps
  (SELECT
    /*+ materialize CARDINALITY(12) */
    (systimestamp - ostart) date1,
    (systimestamp - oend) date2
  FROM stage2
  )
SELECT warehouse_id,
  date1,
  date2,
  SUM(orders.order_total) "Value of Orders",
  COUNT(1) "Number of Orders"
FROM stage3,
  orders
WHERE order_date BETWEEN date2 AND date1
AND warehouse_id = 1
GROUP BY warehouse_id,
  date1,
  date2
ORDER BY date1,
  date2 DESC;


SELECT quantity_on_hand
FROM product_information p,
  inventories i
WHERE i.product_id = 1
AND i.product_id   = p.product_id
AND i.warehouse_id = 1;


SELECT ORDER_ID,
  LINE_ITEM_ID,
  PRODUCT_ID,
  UNIT_PRICE,
  QUANTITY
FROM order_items
WHERE order_id = 1
AND rownum     < 10;


SELECT ORDER_ID,
  ORDER_MODE,
  CUSTOMER_ID,
  ORDER_STATUS,
  ORDER_TOTAL,
  SALES_REP_ID,
  PROMOTION_ID
FROM orders
WHERE customer_id = 1
AND rownum        < 10;


SELECT ORDER_ID,
  ORDER_MODE,
  CUSTOMER_ID,
  ORDER_STATUS,
  ORDER_TOTAL,
  SALES_REP_ID,
  PROMOTION_ID
FROM orders
WHERE order_id = 1
AND rownum     < 10;


SELECT order_mode,
  orders.warehouse_id,
  SUM(order_total),
  COUNT(1)
FROM orders,
  warehouses
WHERE orders.warehouse_id   = warehouses.warehouse_id
AND warehouses.warehouse_id = 1
GROUP BY cube(orders.order_mode, orders.warehouse_id);
SELECT quantity_on_hand
FROM product_information p,
  inventories i
WHERE i.product_id = 1
AND i.product_id   = p.product_id
AND i.warehouse_id = 1;


SELECT CUSTOMER_ID,
  CUST_FIRST_NAME,
  CUST_LAST_NAME,
  NLS_LANGUAGE,
  NLS_TERRITORY,
  CREDIT_LIMIT,
  CUST_EMAIL,
  ACCOUNT_MGR_ID
FROM customers
WHERE customer_id = 1
AND rownum        < 10;


SELECT products.PRODUCT_ID,
  PRODUCT_NAME,
  PRODUCT_DESCRIPTION,
  CATEGORY_ID,
  WEIGHT_CLASS,
  WARRANTY_PERIOD,
  SUPPLIER_ID,
  PRODUCT_STATUS,
  LIST_PRICE,
  MIN_PRICE,
  CATALOG_URL,
  QUANTITY_ON_HAND
FROM products,
  inventories
WHERE products.category_id   = 1
AND inventories.product_id   = products.product_id
AND inventories.warehouse_id = 1
AND rownum                   < 10;
