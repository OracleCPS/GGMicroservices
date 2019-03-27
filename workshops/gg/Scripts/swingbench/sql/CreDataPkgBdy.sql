create	or	replace
package	body
	ccDataPkg
as
/*	Package constants
	pInstanceId		ccMiscPkg.c_getInstanceId%ROWTYPE	:=	ccMiscPkg.getInstanceId;
	*/
/*	Package functions
	*/
/****************************************************************************
 * get new Customer Account key                                             *
 ****************************************************************************/
	function	getCustAccountKey
	return		ca.caId%TYPE
	is
		pId			ca.caId%TYPE;
	begin
    dbms_application_info.set_action('getCustAccountKey');
		select	 decode
			(
			 pInstanceId.instance_number
			, 1, caSeq0.NEXTVAL
			, 2, caSeq1.NEXTVAL
			, 3, caSeq2.NEXTVAL
			, 4, caSeq3.NEXTVAL
			, 5, caSeq4.NEXTVAL
			, 6, caSeq5.NEXTVAL
			, 7, caSeq6.NEXTVAL
			, 8, caSeq7.NEXTVAL
			, 9, caSeq8.NEXTVAL
			,10, caSeq9.NEXTVAL
			,caSeq.NEXTVAL
			)
		into	 pId
		from	 dual;
    dbms_application_info.set_action(null);
		return	(
			 pId
			);
    
	end		getCustAccountKey;
/****************************************************************************
 * get new Customer CLI key                                                 *
 ****************************************************************************/
	function	getCustCLIKey
	return		cc.ccId%TYPE
	is
		pId			cc.ccId%TYPE;
	begin
    dbms_application_info.set_action('getCustCLIKey');
		select	 decode
			(
			 pInstanceId.instance_number
			, 1, ccSeq0.NEXTVAL
			, 2, ccSeq1.NEXTVAL
			, 3, ccSeq2.NEXTVAL
			, 4, ccSeq3.NEXTVAL
			, 5, ccSeq4.NEXTVAL
			, 6, ccSeq5.NEXTVAL
			, 7, ccSeq6.NEXTVAL
			, 8, ccSeq7.NEXTVAL
			, 9, ccSeq8.NEXTVAL
			,10, ccSeq9.NEXTVAL
			,ccSeq.NEXTVAL
			)
		into	 pId
		from	 dual;
    dbms_application_info.set_action(null);
		return	(
			 pId
			);
	end		getCustCLIKey;
/****************************************************************************
 * get Customer Account details for a given Customer Name                   *
 ****************************************************************************/
	function	getCustAccount
	(
	 pcaName		IN	ca.caName%TYPE
	)
	return		ccMiscPkg.c_getCustAccount%ROWTYPE
	is
		pCustAccount		ccMiscPkg.c_getCustAccount%ROWTYPE;
	begin
  dbms_application_info.set_action('getCustAccount');
	open	ccMiscPkg.c_getCustAccount
		(
		 pcaName
		);
	fetch	ccMiscPkg.c_getCustAccount
	into	 pCustAccount;
	close	ccMiscPkg.c_getCustAccount;
  dbms_application_info.set_action(null);
	return	(
		 pCustAccount
		);  
	end		getCustAccount;
/****************************************************************************
 * create new Customer Account details                                      *
 ****************************************************************************/
	function	newCustAccount
	(
	 pCustAccount		IN	ccMiscPkg.c_getCustAccount%ROWTYPE
	)
	return		ca.caId%TYPE
	is
		pcaId			ca.caId%TYPE;
	begin
  dbms_application_info.set_action('newCustAccount');
	pcaId	:=	getCustAccountKey;
	insert
	into	custAccounts
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
	 pcaId
	,pCustAccount.caValidFrom
	,pCustAccount.caValidTo
	,pCustAccount.caName
	,pCustAccount.caPIN
	,pCustAccount.caLastLogin
	,pCustAccount.caFailedLogins
	,pCustAccount.caLastFailedLogin
	);
  dbms_application_info.set_action(null);
	return	(
		 pcaId
		);
	end		newCustAccount;
/****************************************************************************
 * set Customer Account details following a login attempt                   *
 ****************************************************************************/
	procedure	setCustAccount
	(
	 pCustAccount		IN	ccMiscPkg.c_getCustAccount%ROWTYPE
	)
	is
	begin
  dbms_application_info.set_action('setCustAccount');
	update	custAccounts
	set	 caLastLogin		=	pCustAccount.caLastLogin
		,caFailedLogins		=	pCustAccount.caFailedLogins
		,caLastFailedLogin	=	pCustAccount.caLastFailedLogin
	where	ROWID			=	pCustAccount.caROWID;
  dbms_application_info.set_action(null);
	end		setCustAccount;
/****************************************************************************
 * get Customer details for a given Customer CLI Id                         *
 ****************************************************************************/
	function	getCustCLI
	(
	 pcaId			IN	cc.caId%TYPE
	,pdcId			IN	cc.dcId%TYPE
	,pccCLI			IN	cc.ccCLI%TYPE
	)
	return		ccMiscPkg.c_getCustCLI%ROWTYPE
	is
		pCustCLI		ccMiscPkg.c_getCustCLI%ROWTYPE;
	begin
  dbms_application_info.set_action('getCustCLI');
	open	ccMiscPkg.c_getCustCLI
		(
		 pcaId
		,pdcId
		,pccCLI
		);
	fetch	ccMiscPkg.c_getCustCLI
	into	 pCustCLI;
	close	ccMiscPkg.c_getCustCLI;
  dbms_application_info.set_action(null);
	return	(
		 pCustCLI
		);
	end		getCustCLI;
/****************************************************************************
 * create new Customer CLI details                                          *
 ****************************************************************************/
	function	newCustCLI
	(
	 pCustCLI		IN	ccMiscPkg.c_getCustCLI%ROWTYPE
	)
	return		cc.ccId%TYPE
	is
		pccId			cc.ccId%TYPE;
	begin
  dbms_application_info.set_action('newCustCLI');
	pccId	:=	getCustCLIKey;
	insert
	into	custCLIs
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
	 pccId
	,pCustCLI.ccValidFrom
	,pCustCLI.ccValidTo
	,pCustCLI.dcId
	,pCustCLI.ccCLI
	,pCustCLI.ccUpdates
	,pCustCLI.ccUpdatesAllowed
	,pCustCLI.cpId
	,pCustCLI.caId
	);
	insert
	into	packageCLIs
	(
	 ccId
	,psId
	,pcValidFrom
	,pcValidTo
	,dcId
	,pcCLI
	)
	select	/*+ index(ps) */
	 pccId
	,ps.psId
	,pCustCLI.ccValidFrom
	,pCustCLI.ccValidTo
	,ccMiscPkg.dcIdUnused
	,ccMiscPkg.dcValueUnused
	from	 packageSlots	ps
	where	ps.cpId			=	pCustCLI.cpId;
  dbms_application_info.set_action(null);
	return	(
		 pccId
		);
	end		newCustCLI;
/****************************************************************************
 * set Customer CLI details following a successful change of Package CLI    *
 ****************************************************************************/
	procedure	setCustCLI
	(
	 pCustCLI		IN	ccMiscPkg.c_getCustCLI%ROWTYPE
	)
	is
	begin
  dbms_application_info.set_action('setCustCLI');
	update	custCLIs
	set	 ccUpdates		=	pCustCLI.ccUpdates
	where	ROWID			=	pCustCLI.ccROWID;
  dbms_application_info.set_action(null);
	end		setCustCLI;
/****************************************************************************
 * get Package CLI details for a given Customer CLI Id                      *
 ****************************************************************************/
	function	getPackageCLIs
	(
	 pccId			IN	pc.ccId%TYPE
	)
	return		ccMiscPkg.pPackageCLIs
	is
		pDialCode			ccMiscPkg.c_getDialCode%ROWTYPE;
		pPackageCLIs		ccMiscPkg.pPackageCLIs;
		i			binary_integer	:=	0;
	begin
  dbms_application_info.set_action('getPackageCLIs');
	for	pPkgCLI	in
	(
	select	/*+ ordered index(pc) index(dc1) index(dc2) use_nl(dc1) use_nl(dc2) */
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
		,dialCodes	dc2
	where	pc.ccId			=	pccId
	and	SYSDATE	between			pc.pcValidFrom
					and	pc.pcValidTo
	and	dc1.dcId		=	pc.dcId
	and	SYSDATE	between			dc1.dcValidFrom
					and	dc1.dcValidTo
	and	dc2.dcId		=	dc1.dcIdParent
	and	SYSDATE	between			dc2.dcValidFrom
					and	dc2.dcValidTo
	order	by
		 pc.psId
	)
	loop
		pDialCode	:=	ccDataPkg.getDialCode
					(
			 pdcValue			=>	pPkgCLI.dcRegionValue
			,pdcValueParent		=>	pPkgCLI.dcCountryValue
					);
		pPkgCLI.dcRegionType	:=	pDialCode.dcRegionType;
		pPkgCLI.dcRegionValue	:=	pDialCode.dcRegionValue;
		pPkgCLI.dcRegionText	:=	pDialCode.dcRegionText;
		pPkgCLI.dcCountryType	:=	pDialCode.dcCountryType;
		pPkgCLI.dcCountryValue	:=	pDialCode.dcCountryValue;
		pPkgCLI.dcCountryText	:=	pDialCode.dcCountryText;
		i		:=	i + 1;
		pPackageCLIs(i)	:=	pPkgCLI;
	end	loop;
  dbms_application_info.set_action(null);
	return	(
		 pPackageCLIs
		);
	end		getPackageCLIs;
/****************************************************************************
 * query Package CLI history for a given Customer CLI Id                    *
 ****************************************************************************/
	function	qryPackageCLIs
	(
	 pccId			IN	pc.ccId%TYPE
	)
	return		ccMiscPkg.pPackageCLIs
	is
		pDialCode			ccMiscPkg.c_getDialCode%ROWTYPE;
		pPackageCLIs		ccMiscPkg.pPackageCLIs;
		i			binary_integer	:=	0;
	begin
  dbms_application_info.set_action('qryPackageCLIs');
	for	pPkgCLI	in
	(
	select	/*+ ordered index(pc) index(dc1) index(dc2) use_nl(dc1) use_nl(dc2) */
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
		,dialCodes	dc2
	where	pc.ccId			=	pccId
	and	SYSDATE		/* hi */	>	pc.pcValidFrom
	and	SYSDATE - 90	/* lo */	<	pc.pcValidTo
	and	dc1.dcId		=	pc.dcId
	and	dc1.dcValidTo	/* hi */	>	pc.pcValidFrom
	and	dc1.dcValidFrom	/* lo */	<	pc.pcValidTo
	and	dc2.dcId		=	dc1.dcIdParent
	and	dc2.dcValidTo	/* hi */	>	pc.pcValidFrom
	and	dc2.dcValidFrom	/* lo */	<	pc.pcValidTo
	order	by
		 pc.psId
		,pc.pcValidFrom
		,dc1.dcValidFrom
		,dc2.dcValidFrom
	)
	loop
		pDialCode	:=	ccDataPkg.getDialCode
					(
			 pdcValue			=>	pPkgCLI.dcRegionValue
			,pdcValueParent		=>	pPkgCLI.dcCountryValue
					);
		pPkgCLI.dcRegionType	:=	pDialCode.dcRegionType;
		pPkgCLI.dcRegionValue	:=	pDialCode.dcRegionValue;
		pPkgCLI.dcRegionText	:=	pDialCode.dcRegionText;
		pPkgCLI.dcCountryType	:=	pDialCode.dcCountryType;
		pPkgCLI.dcCountryValue	:=	pDialCode.dcCountryValue;
		pPkgCLI.dcCountryText	:=	pDialCode.dcCountryText;
		i		:=	i + 1;
		pPackageCLIs(i)	:=	pPkgCLI;
	end	loop;
  dbms_application_info.set_action(null);
	return	(
		 pPackageCLIs
		);
	end		qryPackageCLIs;
/****************************************************************************
 * set Package CLI details following a validated change of Package CLI      *
 ****************************************************************************/
	procedure	setPackageCLI
	(
	 pPackageCLIold		IN	ccMiscPkg.c_getPackageCLIs%ROWTYPE
	,pPackageCLInew		IN	ccMiscPkg.c_getPackageCLIs%ROWTYPE
	)
	is
	begin
  dbms_application_info.set_action('setPackageCLI');
	/*	Update only for first change, insert/update for subsequent
		changes ...
		*/
	if	(pPackageCLIold.dcId > 0)
	then
		insert
		into	packageCLIs
		(
		 ccId
		,psId
		,pcValidFrom
		,pcValidTo
		,dcId
		,pcCLI
		)
		values
		(
		 pPackageCLIold.ccId
		,pPackageCLIold.psId
		,pPackageCLIold.pcValidFrom
		,pPackageCLIold.pcValidTo
		,pPackageCLIold.dcId
		,pPackageCLIold.pcCLI
		);
	end	if;
	update	packageCLIs
	set	 pcValidFrom		=	pPackageCLInew.pcValidFrom
		,pcValidTo		=	pPackageCLInew.pcValidTo
		,dcId			=	pPackageCLInew.dcId
		,pcCLI			=	pPackageCLInew.pcCLI
	where	ROWID			=	pPackageCLInew.pcROWID;
  dbms_application_info.set_action(null);
	end		setPackageCLI;
/****************************************************************************
 * get Dial Code details for a given Value and Parent Value                 *
 ****************************************************************************/
	function	getDialCode
	(
	 pdcValue		IN	dc.dcValue%TYPE
	,pdcValueParent		IN	dc.dcValue%TYPE
	)
	return		ccMiscPkg.c_getDialCode%ROWTYPE
	is
		pDialCode		ccMiscPkg.c_getDialCode%ROWTYPE;
	begin
  dbms_application_info.set_action('sgetDialCode');
	open	ccMiscPkg.c_getDialCode
		(
		 pdcValue
		,pdcValueParent
		);
	fetch	ccMiscPkg.c_getDialCode
	into	 pDialCode;
	close	ccMiscPkg.c_getDialCode;
  dbms_application_info.set_action(null);
	return	(
		 pDialCode
		);
	end		getDialCode;
/*	Anonymous block initialisation
	*/
	begin
		pInstanceId	:=	ccMiscPkg.getInstanceId;
end	ccDataPkg;
/

