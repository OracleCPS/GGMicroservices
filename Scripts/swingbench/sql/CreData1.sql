insert into
  cc_params
(
 key
,value
)
values
(
 'customer count'
,'&nocustaccounts'
)
/

insert	into
	dialCodes
(
 dcId
,dcType
,dcValue
,dcValidFrom
,dcValidTo
,dcText
,dcIdParent
)
values
(
 -1
,'INIT'
,'Unused'
,to_date('19700101000000', 'YYYYMMDDHH24MISS')
,to_date('43121231235959', 'YYYYMMDDHH24MISS')
,'Unused'
,-1
)
/

insert	into
	dialCodes
(
 dcId
,dcType
,dcValue
,dcValidFrom
,dcValidTo
,dcText
,dcIdParent
)
values
(
 0
,'INTL'
,'+44'
,to_date('19700101000000', 'YYYYMMDDHH24MISS')
,to_date('43121231235959', 'YYYYMMDDHH24MISS')
,'UK International Dial Code'
,null
)
/

BEGIN
for	i	in	1..1000
loop
insert	into
	dialCodes
(
 dcId
,dcType
,dcValue
,dcValidFrom
,dcValidTo
,dcText
,dcIdParent
)
values
(
 dcSeq.NEXTVAL
,'NATL'
,'01' || ltrim(to_char(dcSeq.CURRVAL - 1, '009'))
,to_date('19700101000000', 'YYYYMMDDHH24MISS')
,to_date('43121231235959', 'YYYYMMDDHH24MISS')
,'UK Dial Code for Id ' || dcSeq.CURRVAL
,0
);
end	loop;
commit;
end;
/

BEGIN
for	i	in	1..&noCallPackages
loop
insert	into
	callPackages
(
 cpId
,cpValidFrom
,cpValidTo
,cpName
,cpPLSQL
)
values
(
 cpSeq.NEXTVAL
,to_date('19700101000000', 'YYYYMMDDHH24MISS')
,to_date('43121231235959', 'YYYYMMDDHH24MISS')
,'Call Package for Id ' || to_char(cpSeq.CURRVAL)
,'cp' || to_char(cpSeq.CURRVAL) 
);
	for	j	in	1..&noSlotsPerPackage
	loop
	insert	into	
		packageSlots
	(
	 cpId
	,psId
	)
	values
	(
	 cpSeq.CURRVAL
	,j
	);
	end	loop;
end	loop;
commit;
END;
/

