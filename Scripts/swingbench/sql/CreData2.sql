DECLARE
	cas	ca.caId%TYPE;
	ccs	cc.ccId%TYPE;
BEGIN
for	i	in	1..&nocustaccounts / 10
loop
select	 &caSeq.NEXTVAL
		,&ccSeq.NEXTVAL
into		 cas
		,ccs
from		 dual;
insert	into
	custAccounts
(
 caId
,caValidFrom
,caValidTo
,caName
,caPIN
,caLastLogin
,caFailedLogins
,caLastFailedLogin
)
values
(
 cas
,to_date('19700101000000', 'YYYYMMDDHH24MISS')
,to_date('43121231235959', 'YYYYMMDDHH24MISS')
,ltrim(to_char(cas, '0000000000000009'))
,'1234'
,to_date('19700101000000', 'YYYYMMDDHH24MISS')
,0
,to_date('19700101000000', 'YYYYMMDDHH24MISS')
);
insert	into
	custCLIs
(
 ccId
,ccValidFrom
,ccValidTo
,dcId
,ccCLI
,ccUpdates
,ccUpdatesAllowed
,cpId
,caId
)
values
(
 ccs
,to_date('19700101000000', 'YYYYMMDDHH24MISS')
,to_date('43121231235959', 'YYYYMMDDHH24MISS')
,mod(ccs, 1000) + 1
,ltrim(to_char(mod(ccs, 1000000), '000009'))
,0
,30
,mod(ccs, &noCallPackages) + 1
,cas
);
	if	mod(i, 256) = 0
	then
		commit;
	end	if;
end	loop;
commit;
END;
/

