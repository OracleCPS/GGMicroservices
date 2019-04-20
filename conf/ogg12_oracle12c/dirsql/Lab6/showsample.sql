set trim on
set linesize 1500
set echo off

prompt _________________________________________________________________________________ 
prompt
prompt   Target 12c Tables
prompt _________________________________________________________________________________ 
prompt
prompt  
prompt US CUSTOMER TABLE -- note insert filtered by country column  

select CUSTOMERID, CONTACTFIRST, CONTACTLAST, COUNTRY from us_customers where region='OR';

prompt NON US CUSTOMER TABLE  -- note insert filtered by country column

select CUSTOMERID, CONTACTFIRST, CONTACTLAST, COUNTRY from non_us_customers where region='RJ';

prompt  
prompt  
prompt ORDERS TABLE --  note shippername from SQLExec lookup on SHIPPERS TABLE
select orderid, customerid, shipvia, shippername  from orders where orderid in (10612, 10443);

prompt SHIPPERS TABLE 
select * from shippers;

prompt  
prompt  
prompt ORDER_DETAILS TABLE --  note total calculated by SQLExec stored procedure
 
select orderid, productid, unitprice, quantity, discount, total from order_details where orderid = 10612;

prompt  
prompt  
prompt PRODUCT TABLE  -- note discontinued flag converted to text 
select productid, productname, unitprice, discontinued from products where productid in (10,36,49,60,76);
prompt -------------------------------------------------------------------------------- 

prompt  
prompt  
prompt PRODUCTS_HISTORY TABLE -- note commit timestamp, operation type, image type, and user name 
select productid, productname, tran_time, op_type, before_after_ind, user_name from products_history where productid in (10,36,49,60,76);
EXIT;


