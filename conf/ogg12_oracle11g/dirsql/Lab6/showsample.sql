set trim on
set linesize 1500
set echo off

prompt _________________________________________________________________________________
prompt
prompt   Source 11g Tables
prompt _________________________________________________________________________________
prompt  
prompt  
prompt CUSTOMER TABLE 

select CUSTOMERID, CONTACTNAME, COUNTRY from customers where region in ('OR','RJ') order by region;

prompt  
prompt  
prompt ORDERS TABLE
select orderid, customerid, shipvia  from orders where orderid in (10612, 10443);

prompt  
prompt  
prompt ORDER_DETAILS TABLE
select orderid, productid, unitprice, quantity, discount from order_details where orderid = 10612;

prompt  
prompt  
prompt PRODUCT TABLE
select productid, productname, unitprice, discontinued from products where productid in (10,36,49,60,76);
prompt -------------------------------------------------------------------------------- 

EXIT;


