create	unique	index
	dc_PK
on
	dialCodes
(
 dcId
,dcValidTo
)
tablespace	&tablespace
/

create	unique	index
	dc_U1
on
	dialCodes
(
 dcType
,dcValue
,dcValidTo
)
tablespace	&tablespace
/

create		index
	dc_N1
on
	dialCodes
(
 dcIdParent
)
tablespace	&tablespace
/

create	unique	index
	cp_PK
on
	callPackages
(
 cpId
,cpValidTo
)
tablespace	&tablespace
/

create	unique	index
	ps_PK
on
	packageSlots
(
 cpId
,psId
)
tablespace	&tablespace
/

create	unique	index
	ca_PK
on
	custAccounts
(
 caId
,caValidTo
)
tablespace	&tablespace
/

create	unique	index
	ca_U1
on
	custAccounts
(
 caName
,caValidTo
)
tablespace	&tablespace
/

create	unique	index
	cc_PK
on
	custCLIs
(
 ccId
,ccValidTo
)
tablespace	&tablespace
/

create	unique	index
	cc_U1
on
	custCLIs
(
 caId
,dcId
,ccCLI
,ccValidTo
)
tablespace	&tablespace
/

create	unique	index
	pc_PK
on
	packageCLIs
(
 ccId
,psId
,pcValidTo
)
local
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
unusable
/

