create	or	replace
package
	ccMiscPkg
as
/*	Package constants
	*/
	startDate	constant	DATE	:=	to_date('19700101000000', 'YYYYMMDDHH24MISS');
	endDate		constant	DATE	:=	to_date('43121231235959', 'YYYYMMDDHH24MISS');
	dcIdUnused	constant	dialCodes.dcId%TYPE	:=	-1;
	dcTypeUnused	constant	dialCodes.dcType%TYPE	:=	'INIT';
	dcValueUnused	constant	dialCodes.dcValue%TYPE	:=	'Unused';
/*	Package cursors
	*/
/****************************************************************************
 * get Customer Account details for a given Account Name                    *
 ****************************************************************************/
	cursor	c_getCustAccount
	(
	 pcaName			custAccounts.caName%TYPE
	)
	is
	select	/*+ index(ca) */
		 ca.ROWID		caROWID
		,ca.caId
		,ca.caValidFrom
		,ca.caValidTo
		,ca.caName
		,ca.caPIN
		,ca.caLastLogin
		,ca.caFailedLogins
		,ca.caLastFailedLogin
	from	 custAccounts	ca
	where	ca.caName		=	pcaName
	and	SYSDATE	between			ca.caValidFrom
					and	ca.caValidTo;	
/****************************************************************************
 * get Customer CLI details for a given Customer Account Id and CLI         *
 ****************************************************************************/
	cursor	c_getCustCLI
	(
	 pcaId				custCLIs.caId%TYPE
	,pdcId				custCLIs.dcId%TYPE
	,pccCLI				custCLIs.ccCLI%TYPE
	)
	is
	select	/*+ ordered index(cc) index(dc1) index(dc2) index(cp) use_nl(dc1) use_nl(dc2) use_nl(cp) */
		 cc.ROWID		ccROWID
		,cc.ccId
		,cc.ccValidFrom
		,cc.ccValidTo
		,cc.dcId
		,dc1.dcType		dcRegionType
		,dc1.dcValue		dcRegionValue
		,dc1.dcText		dcRegionText
		,dc2.dcType		dcCountryType
		,dc2.dcValue		dcCountryValue
		,dc2.dcText		dcCountryText
		,cc.ccCLI
		,cc.ccUpdates
		,cc.ccUpdatesAllowed
		,cc.cpId
		,cp.cpName
		,cp.cpPLSQL
		,cc.caId
	from	 custCLIs	cc
		,dialCodes	dc1
		,dialCodes	dc2
		,callPackages	cp
	where	cc.caId			=	pcaId
	and	cc.dcId			=	pdcId
	and	cc.ccCLI		=	pccCLI
	and	SYSDATE	between			cc.ccValidFrom
					and	cc.ccValidTo
	and	dc1.dcId		=	cc.dcId
	and	SYSDATE	between			dc1.dcValidFrom
					and	dc1.dcValidTo
	and	dc2.dcId		=	dc1.dcIdParent
	and	SYSDATE	between			dc2.dcValidFrom
					and	dc2.dcValidTo
	and	cp.cpId			=	cc.cpId
	and	SYSDATE	between			cp.cpValidFrom
					and	cp.cpValidTo;
/****************************************************************************
 * get Package CLI details for a given Customer CLI Id                      *
 ****************************************************************************/
	cursor	c_getPackageCLIs
	(
	 pccId				custCLIs.ccCLI%TYPE
	)
	is
	select
		 pc.ROWID		pcROWID
		,pc.ccId
		,pc.psId
		,pc.pcValidFrom
		,pc.pcValidTo
		,pc.dcId
		,dc1.dcType		dcRegionType
		,dc1.dcValue		dcRegionValue
		,dc1.dcText		dcRegionText
		,dc2.dcType		dcCountryType
		,dc2.dcValue		dcCountryValue
		,dc2.dcText		dcCountryText
		,pc.pcCLI
	from	 packageCLIs	pc
		,dialCodes	dc1
		,dialCodes	dc2;
/*	Package type definitions
	*/
	type	pPackageCLIs	is	table	of
					c_getPackageCLIs%ROWTYPE
	index	by	binary_integer;
/****************************************************************************
 * get Dial Code details for a given Value and Parent Value                 *
 ****************************************************************************/
	cursor	c_getDialCode
	(
	 pdcValue			dialCodes.dcValue%TYPE
	,pdcValueParent			dialCodes.dcValue%TYPE
	)
	is
	select	/*+ ordered index(dc1) index(dc2) use_nl(dc2) */
		 dc1.dcId
		,dc1.dcType		dcRegionType
		,dc1.dcValue		dcRegionValue
		,dc1.dcText		dcRegionText
		,dc2.dcType		dcCountryType
		,dc2.dcValue		dcCountryValue
		,dc2.dcText		dcCountryText
	from	 dialCodes	dc1
		,dialCodes	dc2
	where	dc1.dcValue		=	pdcValue
	and	SYSDATE	between			dc1.dcValidFrom
					and	dc1.dcValidTo
	and	dc2.dcId		=	dc1.dcIdParent
	and	dc2.dcValue		=	pdcValueParent
	and	dc2.dcIdParent		is	NULL
	and	SYSDATE	between			dc2.dcValidFrom
					and	dc2.dcValidTo;
/****************************************************************************
 * get Oracle instance identifier for OPS sequence optimisation             *
 ****************************************************************************/
/*	cursor	c_getInstanceId
	is
	select	 instance_number
	from	 v$instance;
	*/
	cursor	c_getInstanceId
	is
	select	 0	instance_number
	from	 dual;
/*	Package functions
	*/
	function	getInstanceId
	return		c_getInstanceId%ROWTYPE;
end	ccMiscPkg;
/

