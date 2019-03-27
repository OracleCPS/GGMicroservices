insert	/*+ APPEND */
into	packageCLIs
(
 ccId
,psId
,pcValidFrom
,pcValidTo
,dcId
,pcCLI
)
select	/*+ ORDERED USE_HASH(ps) FULL(cc) FULL(ps) */
 ccId
,psId
,to_date('19700101000000', 'YYYYMMDDHH24MISS')
,to_date('43121231235959', 'YYYYMMDDHH24MISS')
,mod(ccId + psId, 1000) + 1
,ltrim(to_char(mod(ccId, 1000000), '000009'))
from	 custCLIs		cc
	,packageSlots	ps
where	cc.cpId	=	ps.cpId
/

commit
/

