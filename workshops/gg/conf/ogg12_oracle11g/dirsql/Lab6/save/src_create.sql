-- 
-- ggs_demo_src_create.sql
--
-- GoldenGate Demo
--
-- Description:
-- Create the Customers, Orders, Order_Details, and Products tables.
--
-- sqlplus userid/password @ggs_demo_src_create.sql

drop table customers;
drop table orders;
drop table order_details;
drop table products;
drop sequence biginsert_seq;
drop table biginsert_table;

CREATE TABLE Customers (
	CUSTOMERID CHAR(5) NOT NULL, 
	COMPANYNAME VARCHAR2(40) NOT NULL,
 	CONTACTNAME VARCHAR2(30), 
	CONTACTTITLE VARCHAR2(30), 
    	ADDRESS VARCHAR2(60),
	CITY VARCHAR2(15), 	
	REGION VARCHAR2(15),
 	POSTALCODE VARCHAR2(10), 
    	COUNTRY VARCHAR2(15), 
	PHONE VARCHAR2(24), 
	FAX VARCHAR2(24), 
    PRIMARY KEY(CUSTOMERID) USING INDEX  
    );

CREATE TABLE Order_Details (
	ORDERID NUMBER(10) NOT NULL,
    	PRODUCTID NUMBER(10) NOT NULL, 
	UNITPRICE NUMBER(19, 4) NOT NULL, 
	QUANTITY NUMBER(5) NOT NULL, 
	DISCOUNT FLOAT(126) NOT NULL, 
 	PRIMARY KEY(ORDERID, PRODUCTID) USING INDEX  	
	);

CREATE TABLE Orders (
	ORDERID NUMBER(10) NOT NULL, 
    	CUSTOMERID CHAR(5 ), 
	EMPLOYEEID NUMBER(10), 
    	ORDERDATE DATE, 
	REQUIREDDATE DATE, 
	SHIPPEDDATE DATE, 
    	SHIPVIA NUMBER(10), 
	FREIGHT NUMBER(19, 4), 
	SHIPNAME VARCHAR2(40), 
	SHIPADDRESS VARCHAR2(60), 
	SHIPCITY VARCHAR2(15),
	SHIPREGION VARCHAR2(15),
    	SHIPPOSTALCODE VARCHAR2(10),
	SHIPCOUNTRY VARCHAR2(15), 
	PRIMARY KEY(ORDERID) USING INDEX  
	);

CREATE TABLE Products (
	PRODUCTID NUMBER(10) NOT NULL, 
	PRODUCTNAME VARCHAR2(40) NOT NULL, 
	SUPPLIERID NUMBER(10), 	
	CATEGORYID NUMBER(10), 
	QUANTITYPERUNIT VARCHAR2(20), 
	UNITPRICE NUMBER(19, 4), 
	UNITSINSTOCK NUMBER(5), 
	UNITSONORDER NUMBER(5), 
	REORDERLEVEL NUMBER(5),
   	DISCONTINUED NUMBER(1) , 
    PRIMARY KEY(PRODUCTID) USING INDEX  
    );

CREATE SEQUENCE "GGS"."BIGINSERT_SEQ" INCREMENT BY 1 START WITH 1
    MAXVALUE 1.0E28 MINVALUE 1 NOCYCLE 
    CACHE 20 NOORDER;
     
CREATE TABLE BigInsert_Table (
	ID NUMBER(10) NOT NULL, 
	TEXT1 VARCHAR2(40),
	TEXT2 VARCHAR2(40), 
        NUM1 NUMBER (10),
        NUM2 NUMBER (10),
    PRIMARY KEY(ID) USING INDEX  
    );

create or replace procedure biginsert

  (rpc in number, noc in number) as

  loop_var number;

  loop_var2 number;

  begin

  for loop_var2 in 1..noc loop

   for loop_var in 1..rpc loop

    insert into BigInsert_table values (Biginsert_seq.nextval,'sometext','moretext', 10, 20);

   end loop;

  commit;

  end loop;

end;

/

