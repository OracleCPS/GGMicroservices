select Productid, discontinued, CAST (TRAN_TIME AS TIMESTAMP), CAST (POST_TIME AS TIMESTAMP), SOURCE_NODE, OP_TYPE, BEFORE_AFTER_IND, USER_NAME
 from products_audit where productid > 70;
