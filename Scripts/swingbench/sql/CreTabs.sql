create	synonym	ck
for	custKeys
/

create	table
	custKeys
(
 key				number		not null
 primary key
)
organization	index
tablespace		&tablespace
/

create	synonym	dc
for	dialCodes
/

create	table
	dialCodes
(
 dcId				number(9)		not null
,dcValidFrom		date			not null
,dcValidTo			date			not null
,dcType			varchar2(8)		not null
,dcValue			varchar2(8)		not null
,dcText			varchar2(32)	not null
,dcIdParent			number(9)		null
)
tablespace	&tablespace
/

create	sequence
	dcSeq
/

create	synonym	cp
for	callPackages
/

create	table
	callPackages
(
 cpId				number(9)		not null
,cpValidFrom		date			not null
,cpValidTo			date			not null
,cpName			varchar2(32)	not null
,cpPLSQL			varchar2(32)	not null
)
tablespace	&tablespace
/

create	sequence
	cpSeq
/

create	synonym	ps
for	packageSlots
/

create	table
	packageSlots
(
 cpId				number(9)		not null
,psId				number(9)		not null
)
tablespace	&tablespace
/

create	synonym	ca
for	custAccounts
/

create	table
	custAccounts
(
 caId				number(9)		not null
,caValidFrom		date			not null
,caValidTo			date			not null
,caName			varchar2(32)	not null
,caPIN			varchar2(32)	not null
,caLastLogin		date			not null
,caFailedLogins		number(5)		not null
,caLastFailedLogin	date			not null
)
pctfree		20
pctused		20
tablespace	&tablespace
/

create	sequence
	caSeq
start	with	100000000
nomaxvalue
cache		256
/

create	sequence
	caSeq0
minvalue	0
start	with	00000000
maxvalue	09999999
cache		256
/

create	sequence
	caSeq1
start	with	10000000
maxvalue	19999999
cache		256
/

create	sequence
	caSeq2
start	with	20000000
maxvalue	29999999
cache		256
/

create	sequence
	caSeq3
start	with	30000000
maxvalue	39999999
cache		256
/

create	sequence
	caSeq4
start	with	40000000
maxvalue	49999999
cache		256
/

create	sequence
	caSeq5
start	with	50000000
maxvalue	59999999
cache		256
/

create	sequence
	caSeq6
start	with	60000000
maxvalue	69999999
cache		256
/

create	sequence
	caSeq7
start	with	70000000
maxvalue	79999999
cache		256
/

create	sequence
	caSeq8
start	with	80000000
maxvalue	89999999
cache		256
/

create	sequence
	caSeq9
start	with	90000000
maxvalue	99999999
cache		256
/

create	synonym	cc
for	custCLIs
/

create	table
	custCLIs
(
 ccId				number(9)		not null
,ccValidFrom		date			not null
,ccValidTo			date			not null
,dcId				number(9)		not null
,ccCLI			varchar2(32)	not null
,ccUpdates			number(5)		not null
,ccUpdatesAllowed		number(5)		not null
,cpId				number(9)		not null
,caId				number(9)		not null
)
pctfree		20
pctused		20
tablespace	&tablespace
/

create	sequence
	ccSeq
start	with	100000000
nomaxvalue
cache		256
/

create	sequence
	ccSeq0
minvalue	0
start	with	00000000
maxvalue	09999999
cache		256
/

create	sequence
	ccSeq1
start	with	10000000
maxvalue	19999999
cache		256
/

create	sequence
	ccSeq2
start	with	20000000
maxvalue	29999999
cache		256
/

create	sequence
	ccSeq3
start	with	30000000
maxvalue	39999999
cache		256
/

create	sequence
	ccSeq4
start	with	40000000
maxvalue	49999999
cache		256
/

create	sequence
	ccSeq5
start	with	50000000
maxvalue	59999999
cache		256
/

create	sequence
	ccSeq6
start	with	60000000
maxvalue	69999999
cache		256
/

create	sequence
	ccSeq7
start	with	70000000
maxvalue	79999999
cache		256
/

create	sequence
	ccSeq8
start	with	80000000
maxvalue	89999999
cache		256
/

create	sequence
	ccSeq9
start	with	90000000
maxvalue	99999999
cache		256
/

create	synonym	pc
for	packageCLIs
/

create	table
	packageCLIs
(
 ccId				number(9)		not null
,psId				number(9)		not null
,pcValidFrom		date			not null
,pcValidTo			date			not null
,dcId				number(9)		not null
,pcCLI			varchar2(32)	not null
)
pctfree		40
pctused		20
partition by hash
(
 ccId
)
(
 partition	pc01
,partition	pc02
,partition	pc03
,partition	pc04
,partition	pc05
,partition	pc06
,partition	pc07
,partition	pc08
,partition	pc09
,partition	pc10
,partition	pc11
,partition	pc12
,partition	pc13
,partition	pc14
,partition	pc15
,partition	pc16
)
tablespace	&tablespace
/

create	table
cc_params
(
 key varchar2(50) not null
,value varchar2(50) not null
,primary key (key) enable
)
tablespace &tablespace
/

