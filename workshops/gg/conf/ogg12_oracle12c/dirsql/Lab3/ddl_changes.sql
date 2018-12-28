ALTER TABLE products
  ADD currency_code char(3);

CREATE TABLE currency (
  currency_code char(3) ,
  currency_desc varchar2(12),
  exchange_rate number(15,4) NOT NULL,
  last_modified timestamp,
  PRIMARY KEY (currency_code)
  using index
);

CREATE USER currency_admin
        IDENTIFIED BY currency_admin
        DEFAULT TABLESPACE USERS
        TEMPORARY TABLESPACE TEMP
        ACCOUNT UNLOCK;
GRANT CONNECT TO currency_admin;
EXIT;
