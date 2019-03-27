
-- Data Duplicate

alter session force parallel DML &parallelclause;

alter session force parallel query &parallelclause;

commit;

INSERT /*+ APPEND */ 
INTO &customer_target(
    CUSTOMER_ID,
    CUST_FIRST_NAME,
    CUST_LAST_NAME,
    NLS_LANGUAGE,
    NLS_TERRITORY,
    CREDIT_LIMIT,
    CUST_EMAIL,
    ACCOUNT_MGR_ID,
    CUSTOMER_SINCE,
    CUSTOMER_CLASS,
    SUGGESTIONS,
    DOB,
    MAILSHOT,
    PARTNER_MAILSHOT,
    PREFERRED_ADDRESS,
    PREFERRED_CARD
)
SELECT CUSTOMER_ID + &customeroffset,
    CUST_FIRST_NAME,
    CUST_LAST_NAME,
    NLS_LANGUAGE,
    NLS_TERRITORY,
    CREDIT_LIMIT,
    CUST_EMAIL,
    ACCOUNT_MGR_ID,
    CUSTOMER_SINCE,
    CUSTOMER_CLASS,
    SUGGESTIONS,
    DOB,
    MAILSHOT,
    PARTNER_MAILSHOT,
    PREFERRED_ADDRESS,
    PREFERRED_CARD
FROM CUSTOMERS &whereclause;

commit;


INSERT /*+ APPEND */
INTO &address_target
(
    ADDRESS_ID,
    CUSTOMER_ID,
    DATE_CREATED,
    HOUSE_NO_OR_NAME,
    STREET_NAME,
    TOWN,
    COUNTY,
    COUNTRY,
    POST_CODE,
    ZIP_CODE
)
SELECT ADDRESS_SEQ.NEXTVAL,
    CUSTOMER_ID + &customeroffset,
    DATE_CREATED,
    HOUSE_NO_OR_NAME,
    STREET_NAME,
    TOWN,
    COUNTY,
    COUNTRY,
    POST_CODE,
    ZIP_CODE
FROM ADDRESSES &whereclause;

commit;

INSERT /*+ APPEND */
    INTO &card_details_target
    (CARD_ID,
    CUSTOMER_ID,
    CARD_TYPE,
    CARD_NUMBER,
    EXPIRY_DATE,
    IS_VALID,
    SECURITY_CODE
    )
SELECT
    CARD_DETAILS_SEQ.NEXTVAL,
    CUSTOMER_ID + &customeroffset,
    CARD_TYPE,
    CARD_NUMBER,
    EXPIRY_DATE,
    IS_VALID,
    SECURITY_CODE
FROM CARD_DETAILS &whereclause;

commit;

INSERT /*+ APPEND */
INTO &order_target
(
    ORDER_ID,
    ORDER_DATE,
    ORDER_MODE,
    CUSTOMER_ID,
    ORDER_STATUS,
    ORDER_TOTAL,
    SALES_REP_ID,
    PROMOTION_ID,
    WAREHOUSE_ID,
    DELIVERY_TYPE,
    COST_OF_DELIVERY,
    WAIT_TILL_ALL_AVAILABLE,
    DELIVERY_ADDRESS_ID,
    CUSTOMER_CLASS,
    CARD_ID,
    INVOICE_ADDRESS_ID
)
SELECT
    ORDER_ID + &orderoffset,
    ORDER_DATE,
    ORDER_MODE,
    CUSTOMER_ID + &customeroffset,
    ORDER_STATUS,
    ORDER_TOTAL,
    SALES_REP_ID,
    PROMOTION_ID,
    WAREHOUSE_ID,
    DELIVERY_TYPE,
    COST_OF_DELIVERY,
    WAIT_TILL_ALL_AVAILABLE,
    DELIVERY_ADDRESS_ID,
    CUSTOMER_CLASS,
    CARD_ID,
    INVOICE_ADDRESS_ID
FROM ORDERS &whereclause;

commit;

insert /*+ APPEND */
into &oi_target
(
    ORDER_ID,       
    LINE_ITEM_ID,       
    PRODUCT_ID,       
    UNIT_PRICE,       
    QUANTITY,  
    DISPATCH_DATE,  
    RETURN_DATE,  
    GIFT_WRAP,  
    CONDITION,  
    SUPPLIER_ID,  
    ESTIMATED_DELIVERY
)
select ORDER_ID + &orderoffset,       
    LINE_ITEM_ID,       
    PRODUCT_ID,       
    UNIT_PRICE,       
    QUANTITY,  
    DISPATCH_DATE,  
    RETURN_DATE,  
    GIFT_WRAP,  
    CONDITION,  
    SUPPLIER_ID,  
    ESTIMATED_DELIVERY
from order_items &whereclause;

commit;

-- End of script
