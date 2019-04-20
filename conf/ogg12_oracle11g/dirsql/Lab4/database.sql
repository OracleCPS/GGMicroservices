DROP TABLE address CASCADE CONSTRAINTS;
COMMIT;

DROP TABLE title_author CASCADE CONSTRAINTS;
COMMIT;

DROP TABLE author CASCADE CONSTRAINTS;
COMMIT;

DROP TABLE publisher CASCADE CONSTRAINTS;
COMMIT;

DROP TABLE title CASCADE CONSTRAINTS;
COMMIT;

DROP TABLE title_exceptions CASCADE CONSTRAINTS;
COMMIT;

CREATE TABLE address
(
    id NUMBER(10) NOT NULL,
    street1 VARCHAR2(55) NOT NULL,
    street2 VARCHAR2(55),
    city VARCHAR2(55) NOT NULL,
    state CHAR(2) NOT NULL,
    zip NUMBER(5) NOT NULL,
    country VARCHAR2(30) DEFAULT 'USA',
    phone CHAR(12) DEFAULT 'UNKNOWN' NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE author
(
    id NUMBER(10) NOT NULL,
    lname VARCHAR2(40) NOT NULL,
    fname VARCHAR2(20) NOT NULL,
    address_id NUMBER(10) NOT NULL,
    PRIMARY KEY (id)
);

CREATE INDEX name_index ON author (lname, fname);

CREATE TABLE publisher
(
    id NUMBER(10) NOT NULL,
    pub_name VARCHAR2(40) NOT NULL,
    address_id NUMBER(10),
    PRIMARY KEY (id)
);

CREATE TABLE title
(
    id NUMBER(10) NOT NULL,
    title VARCHAR2(80) NOT NULL,
    genre CHAR(12) DEFAULT 'UNDECIDED' NOT NULL,
    pub_id NUMBER(10),
    price NUMBER(8,2),
    sales NUMBER(11),
    notes VARCHAR2(25),
    pubdate date NOT NULL,
    PRIMARY KEY (id)
);

CREATE INDEX title_index ON title (title);

CREATE TABLE title_exceptions
(
    id NUMBER(10) ,
    title VARCHAR2(80),
    genre CHAR(12) DEFAULT 'UNDECIDED',
    pub_id NUMBER(10),
    price NUMBER(8,2),
    sales NUMBER(11),
    notes VARCHAR2(25),
    pubdate date
);

CREATE TABLE title_author
(
    author_id NUMBER(10) NOT NULL,
    title_id NUMBER(10) NOT NULL,
    author_order NUMBER(5),
    PRIMARY KEY (author_id, title_id)
    using index
);


insert into title values(1, 'Guide to Backpacking', 'Guide', '9','32.12', '0.0', 'All about backpacking.', '1/feb/98');
insert into title values(2, 'Guide to Cooking', 'Guide', '8','34.14', '0.0', 'All about cooking.', '1/feb /98');
insert into title values(3, 'Learning Spanish', 'Language', '7','31.11', '0.0', 'Beginning Spanish.', '1/feb/98');
insert into title values(4, 'Hitchhikers guide to the Universe', 'Guide', '6','32.12', '0.0', 'All about hitching.', '1/mar/96');
insert into title values(5, 'Learning French', 'Language', '4','22.12', '0.0', 'Beginning French.', '1/feb/91');
insert into title values(6, 'French Revolution', 'History', '3','22.14', '0.0', 'European History.', '1/feb/88');


insert into address VALUES(1, 'Dolores St andSan Jose Ave', 'Apt #4', 'San Francisco','CA','94110', 'USA', '41535005555');
insert into address VALUES(2, 'Leavesley Rd andMonterey Rd', '', 'Gilroy','CA','95020', 'USA', '4153501555');
insert into address VALUES(3, 'Palm Dr andArboretum Rd', '', 'Stanford','CA','94305', 'USA', '4153502555');
insert into address VALUES(4, 'Millbrae Ave and Willow Ave', '', 'Millbrae ','CA','94030', 'USA', '4153503555');
insert into address VALUES(5, 'Cesar Chavez St andSanchez', '', 'San Francisco','CA','94131', 'USA', '4153504555');
insert into address VALUES(6, 'University Ave andMiddlefield Rd', '', 'Palo Alto','CA','94301', 'USA', '4153505555');
insert into address VALUES(7, 'Bay Street and Columbus Ave ', '', 'San Francisco','CA','94133', 'USA', '4153506555');
insert into address VALUES(8, 'Telegraph Ave andBancroft Way', '', 'Berkeley','CA','94704', 'USA', '4153507555');
insert into address VALUES(9, '1st St andMarket St ', '', 'San Francisco','CA','94105', 'USA', '4153508555');
insert into address VALUES(10, 'San Antonio Rd andMiddlefield Rd', '', 'Palo Alto','CA','94303', 'USA', '4153509555');
insert into address VALUES(11, '4440 John Deere Drive', 'Suite 2100', 'Lincoln','NE','69156', 'USA', '4025551234');

insert into author values(1, 'Brydon', 'Sean', '31');
insert into author values(2, 'Singh', 'Inderjeet', '32');
insert into author values(3, 'Basler', 'Mark', '33');
insert into author values(4, 'Yoshida', 'Yutaka', '34');
insert into author values(5, 'Kangath', 'Smitha', '35');
insert into author values(6, 'Freeman', 'Larry', '36');
insert into author values(7, 'Kaul', 'Jeet', '37');
insert into author values(8, 'Burns', 'Ed', '38');
insert into author values(9, 'McClanahan', 'Craig', '39');

insert into publisher values(1, 'Brydon Inc.', '31');
insert into publisher values(2, 'Singh Inc.', '32');
insert into publisher values(3, 'Basler Inc.', '33');
insert into publisher values(4, 'Yoshida Inc.', '34');
insert into publisher values(5, 'Kangath Inc.', '35');
insert into publisher values(6, 'Freeman Inc.', '36');
insert into publisher values(7, 'Kaul Inc.', '37');
insert into publisher values(8, 'Burns Inc.', '38');
insert into publisher values(9, 'McClanahan Inc.', '39');


-- author_id (fk), title_id (fk), order_author
insert into title_author values('1', '1', '1');
insert into title_author values('2', '2', '1');
insert into title_author values('3', '3', '1');
insert into title_author values('4', '4', '1');
insert into title_author values('4', '5', '1');

COMMIT;

ALTER TABLE title
 ADD last_change_ts TIMESTAMP;
ALTER TABLE title
 ADD source VARCHAR2 (8);

update title set last_change_ts = current_timestamp;
commit;


ALTER TABLE title_exceptions
 ADD last_change_ts TIMESTAMP;
ALTER TABLE title_exceptions
 ADD source VARCHAR2 (8) DEFAULT 'Amer';
ALTER TABLE title_exceptions
 add conflict_reason VARCHAR2(20);


EXIT;
