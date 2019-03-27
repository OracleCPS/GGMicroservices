create	or	replace
package	body
	ccAppPkg
as
/*	Package constants
	*/
/*	Package functions
	*/
/****************************************************************************
 * get Customer Account details for a given Customer Name                   *
 ****************************************************************************/
	procedure	getCustAccount
	(
	 pcaName		IN	ca.caName%TYPE
	,pcaPIN			IN	ca.caPIN%TYPE
	/*			OUT	ccMiscPkg.c_getCustAccount%ROWTYPE
		*/
-- nu	,pcaROWID		OUT	ROWID
	,pcaId			OUT	ca.caId%TYPE
-- nu	,pcaValidFrom		OUT	ca.caValidFrom%TYPE
-- nu	,pcaValidTo		OUT	ca.caValidTo%TYPE
-- 	,pcaName		OUT	ca.caName%TYPE
--	,pcaPIN			OUT	ca.caPIN%TYPE
	,pcaLastLogin		OUT	ca.caLastLogin%TYPE
	,pcaFailedLogins	OUT	ca.caFailedLogins%TYPE
	,pcaLastFailedLogin	OUT	ca.caLastFailedLogin%TYPE
	)
	is
		pCustAccount		ccMiscPkg.c_getCustAccount%ROWTYPE;
	begin
  dbms_application_info.set_module('getCustAccount',null);
	/*	Clear all caches
		*/
	cCustAccount	:=	ciCustAccount;
	cCustCLI	:=	ciCustCLI;
	cPackageCLIs	:=	ciPackageCLIs;
	pCustAccount	:=	ccDataPkg.getCustAccount
	(
	 pcaName	=>	pcaName
	);
	/*	Error handling for missing/expired Customer Accounts omitted
		*/
	pcaId			:=	pCustAccount.caId;
	/*	Check for excess login attempts omitted
		*/
	pcaLastLogin		:=	pCustAccount.caLastLogin;
	pcaLastFailedLogin	:=	pCustAccount.caLastFailedLogin;
	pcaFailedLogins		:=	pCustAccount.caFailedLogins;
	if	(pcaPIN	=	pCustAccount.caPIN)
	then
		pCustAccount.caLastLogin	:=	SYSDATE;
		pCustAccount.caFailedLogins	:=	0;
	else
	/*	Action on invalid PIN omitted
		*/
		pCustAccount.caFailedLogins	:=	pCustAccount.caFailedLogins + 1;
		pCustAccount.caLastFailedLogin	:=	SYSDATE;
	end	if;
	ccDataPkg.setCustAccount
	(
	 pCustAccount	=>	pCustAccount
	);
	commit;
	/*	Populate Customer Account cache
		*/
	cCustAccount	:=	pCustAccount;
  dbms_application_info.set_module(null,null);
	end		getCustAccount;
/****************************************************************************
 * create new Customer Account details                                      *
 ****************************************************************************/
	procedure	newCustAccount
	(
	/*			IN	ccMiscPkg.c_getCustAccount%ROWTYPE
		*/
--	,pcaROWID		IN	ROWID
--	,pcaId			IN	ca.caId%TYPE
-- nu	,pcaValidFrom		IN	ca.caValidTo%TYPE
-- nu	,pcaValidTo		IN	ca.caValidFrom%TYPE
	 pcaName		IN	ca.caName%TYPE
	,pcaPIN			IN	ca.caPIN%TYPE
-- nu	,pcaLastLogin		IN	ca.caLastLogin%TYPE
-- nu	,pcaFailedLogins	IN	ca.caFailedLogins%TYPE
-- nu	,pcaLastFailedLogin	IN	ca.caLastFailedLogin%TYPE
	)
	is
		pCustAccount		ccMiscPkg.c_getCustAccount%ROWTYPE;
		pcaId			ca.caId%TYPE;
	begin
  dbms_application_info.set_module('newCustAccount',null);
	pCustAccount.caValidFrom	:=	ccMiscPkg.startDate;
	pCustAccount.caValidTo		:=	ccMiscPkg.endDate;
	pCustAccount.caName		:=	pcaName;
	pCustAccount.caPIN		:=	pcaPIN;
	pCustAccount.caLastLogin	:=	SYSDATE;
	pCustAccount.caFailedLogins	:=	0;
	pCustAccount.caLastFailedLogin	:=	ccMiscPkg.startDate;
	pcaId	:=	ccDataPkg.newCustAccount
	(
	 pCustAccount	=>	pCustAccount
	);
	commit;
  dbms_application_info.set_module(null,null);
	end		newCustAccount;
/****************************************************************************
 * get Customer details for a given Customer CLI Id                         *
 ****************************************************************************/
	procedure	getCustCLI
	(
	 pcaId			IN	cc.caId%TYPE
	,pdcCountryValue	IN	dc.dcValue%TYPE
	,pdcRegionValue		IN	dc.dcValue%TYPE
	,pccCLI			IN	cc.ccCLI%TYPE
	/*			OUT	ccMiscPkg.c_getCustCLI%ROWTYPE
		*/
-- nu	,pccROWID		OUT	ROWID
	,pccId			OUT	cc.ccId%TYPE
-- nu	,pccValidFrom		OUT	cc.ccValidFrom%TYPE
-- nu	,pccValidTo		OUT	cc.ccValidTo%TYPE
-- nu	,pdcId			OUT	cc.dcId%TYPE
	,pdcRegionType		OUT	dc.dcType%TYPE
--	,pdcRegionValue		OUT	dc.dcValue%TYPE
	,pdcRegionText		OUT	dc.dcText%TYPE
	,pdcCountryType		OUT	dc.dcType%TYPE
--	,pdcCountryValue	OUT	dc.dcValue%TYPE
	,pdcCountryText		OUT	dc.dcText%TYPE
--	,pccCLI			OUT	cc.ccCLI%TYPE
	,pccUpdates		OUT	cc.ccUpdates%TYPE
	,pccUpdatesAllowed	OUT	cc.ccUpdatesAllowed%TYPE
-- nu	,pcpId			OUT	cc.cpId%TYPE
	,pcpName		OUT	cp.cpName%TYPE
-- nu	,pcpPLSQL		OUT	cp.cpPLSQL%TYPE
--	,pcaId			OUT	ca.caId%TYPE
	)
	is
		pDialCode		ccMiscPkg.c_getDialCode%ROWTYPE;
		pCustCLI		ccMiscPkg.c_getCustCLI%ROWTYPE;
	begin
  dbms_application_info.set_module('getCustCLI',null);
	pDialCode	:=	ccDataPkg.getDialCode
	(
	 pdcValue	=>	pdcRegionValue
	,pdcValueParent	=>	pdcCountryValue
	);
	/*	Error handling for missing/expired Dial Codes omitted
		*/
	pCustCLI	:=	ccDataPkg.getCustCLI
	(
	 pcaId		=>	pcaId
	,pdcId		=>	pDialCode.dcId
	,pccCLI		=>	pccCLI
	);
	pccId			:=	pCustCLI.ccId;
	pdcRegionType		:=	pCustCLI.dcRegionType;
	pdcRegionText		:=	pCustCLI.dcRegionText;
	pdcCountryType		:=	pCustCLI.dcCountryType;
	pdcCountryText		:=	pCustCLI.dcCountryText;
	pccUpdates		:=	pCustCLI.ccUpdates;
	pccUpdatesAllowed	:=	pCustCLI.ccUpdatesAllowed;
	pcpName			:=	pCustCLI.cpName;
	/*	Populate Customer CLI cache
		*/
	cCustCLI	:=	pCustCLI;
  dbms_application_info.set_module(null,null);
	end		getCustCLI;
/****************************************************************************
 * create new Customer CLI details                                          *
 ****************************************************************************/
	procedure	newCustCLI
	(
	/*			IN	ccMiscPkg.c_getCustCLI%ROWTYPE
		*/
--	,pccROWID		IN	ROWID
--	,pccId			IN	cc.ccId%TYPE
-- nu	,pccValidFrom		IN	cc.ccValidFrom%TYPE
-- nu	,pccValidTo		IN	cc.ccValidTo%TYPE
-- nu	,pdcId			IN	cc.dcId%TYPE
-- nu	,pdcRegionType		IN	dc.dcType%TYPE
	 pdcRegionValue		IN	dc.dcValue%TYPE
-- nu	,pdcRegionText		IN	dc.dcText%TYPE
-- nu	,pdcCountryType		IN	dc.dcType%TYPE
	,pdcCountryValue	IN	dc.dcValue%TYPE
-- nu	,pdcCountryText		IN	dc.dcText%TYPE
	,pccCLI			IN	cc.ccCLI%TYPE
-- nu	,pccUpdates		IN	cc.ccUpdates%TYPE
-- nu	,pccUpdatesAllowed	IN	cc.ccUpdatesAllowed%TYPE
	,pcpId			IN	cc.cpId%TYPE
-- nu	,pcpName		IN	cp.cpName
-- nu	,pcpPLSQL		IN	cp.cpPLSQL
	,pcaId			IN	ca.caId%TYPE
	)
	is
		pccId			cc.ccId%TYPE;
		pDialCode		ccMiscPkg.c_getDialCode%ROWTYPE;
		pCustCLI		ccMiscPkg.c_getCustCLI%ROWTYPE;
	begin
  dbms_application_info.set_module('newCustCLI',null);
	pDialCode	:=	ccDataPkg.getDialCode
	(
	 pdcValue	=>	pdcRegionValue
	,pdcValueParent	=>	pdcCountryValue
	);
	/*	Error handling for missing/expired Dial Codes omitted
		*/
	pCustCLI.ccValidFrom		:=	ccMiscPkg.startDate;
	pCustCLI.ccValidTo		:=	ccMiscPkg.endDate;
	pCustCLI.dcId			:=	pDialCode.dcId;
	pCustCLI.ccCLI			:=	pccCLI;
	/*	Updates should be a characteristic of the Call Package ...
		*/
	pCustCLI.ccUpdates		:=	0;
	pCustCLI.ccUpdatesAllowed	:=	30;
	pCustCLI.cpId			:=	pcpId;
	pCustCLI.caId			:=	pcaId;
	pccId		:=	ccDataPkg.newCustCLI
	(
	 pCustCLI	=>	pCustCLI
	);
	commit;
  dbms_application_info.set_module(null,null);
	end		newCustCLI;
/****************************************************************************
 * get Package CLI details for a given Customer CLI Id                      *
 ****************************************************************************/
	procedure	getPackageCLIs
	(
	 pccId			IN	pc.ccId%TYPE
	)
	is
	begin
	/*	Populate Package CLIs cache
		*/
  dbms_application_info.set_module('getPackageCLIs',null);
	cPackageCLIs	:=	ccDataPkg.getPackageCLIs
	(
	 pccId		=>	pccId
	);
  dbms_application_info.set_module(null,null);
	end		getPackageCLIs;
/****************************************************************************
 * query current Package CLI details for a given Customer CLI Id            *
 ****************************************************************************/
	procedure	qryPackageCLIsCurrent
	(
	 pccId			IN	pc.ccId%TYPE
	)
	is
		pPackageCLIs		ccMiscPkg.pPackageCLIs;
	begin
  dbms_application_info.set_module('qryPackageCLIsCurrent',null);
	pPackageCLIs	:=	ccDataPkg.getPackageCLIs
	(
	 pccId		=>	pccId
	);
	end		qryPackageCLIsCurrent;
/****************************************************************************
 * query Package CLI history for a given Customer CLI Id                    *
 ****************************************************************************/
	procedure	qryPackageCLIsHistory
	(
	 pccId			IN	pc.ccId%TYPE
	)
	is
		pPackageCLIs		ccMiscPkg.pPackageCLIs;
	begin
  dbms_application_info.set_module('qryPackageCLIsHistory',null);
	pPackageCLIs	:=	ccDataPkg.qryPackageCLIs
	(
	 pccId		=>	pccId
	);
  dbms_application_info.set_module(null,null);
	end		qryPackageCLIsHistory;
/****************************************************************************
 * set Package CLI details following a validated change of Package CLI      *
 ****************************************************************************/
	procedure	setPackageCLI
	(
	 ppsId			IN	ps.psId%TYPE
	,pdcRegionValue		IN	dc.dcValue%TYPE
	,pdcCountryValue	IN	dc.dcValue%TYPE
	,ppcCLI			IN	pc.pcCLI%TYPE
	,pError			OUT	number
	,pErrorText		OUT	varchar2
	)
	is
		pValid			boolean	:=	TRUE;
		pDialCode		ccMiscPkg.c_getDialCode%ROWTYPE;
		pPackageCLIold		ccMiscPkg.c_getPackageCLIs%ROWTYPE;
		pPackageCLInew		ccMiscPkg.c_getPackageCLIs%ROWTYPE;
	begin
  dbms_application_info.set_module('setPackageCLI',null);  
	pError		:=	0;
	pErrorText	:=	'Success';
	begin
		pDialCode	:=	ccDataPkg.getDialCode
		(
		 pdcValue	=>	pdcRegionValue
		,pdcValueParent	=>	pdcCountryValue
		);
	exception
	when	NO_DATA_FOUND
	then	raise_application_error(-20000, 'No Data Found for getDialCode(' || nvl(pdcRegionValue, '<NULL>') || ', ' || nvl(pdcCountryValue, '<NULL>') || ')', TRUE);
  end;
	/*	Error handling for missing/expired Dial Codes omitted
		*/
	begin
	/*	Create "before image" of cache entry
		*/
		pPackageCLIold	:=	cPackageCLIs(ppsId);
	/*	Construct "after image" of cache entry by overlaying
		Dial Code information for the proposed change
		*/
		pPackageCLInew	:=	cPackageCLIs(ppsId);
		pPackageCLInew.pcValidFrom	:=	SYSDATE;
		pPackageCLInew.dcId		:=	pDialCode.dcId;
		pPackageCLInew.dcRegionType	:=	pDialCode.dcRegionType;
		pPackageCLInew.dcRegionValue	:=	pDialCode.dcRegionValue;
		pPackageCLInew.dcRegionText	:=	pDialCode.dcRegionText;
		pPackageCLInew.dcCountryType	:=	pDialCode.dcCountryType;
		pPackageCLInew.dcCountryValue	:=	pDialCode.dcCountryValue;
		pPackageCLInew.dcCountryText	:=	pDialCode.dcCountryText;
		pPackageCLInew.pcCLI		:=	ppcCLI;
	exception
	when	NO_DATA_FOUND
	then	raise_application_error(-20000, 'No Data Found for cPackageCLIs(' || nvl(to_char(ppsId), '<NULL>') || ')', TRUE);
	end;
	/*	Static validation ...
		*/
/*	Check: Maximum Number of Updates Reached
	*/
	if	(pValid)
	then
		if	(
-- Update tracking ...
		cCustCLI.ccUpdatesAllowed	>	0
		and
-- not first Update
		pPackageCLIold.dcId		!=	ccMiscPkg.dcIdUnused
		and
-- Update limit reached
		cCustCLI.ccUpdates		>=	cCustCLI.ccUpdatesAllowed
			)
		then
			pValid	:=	FALSE;
			pError	:=	10;
			pErrorText	:=	'(Static) Maximum Number of Updates Reached';
		end	if;
	end	if;
/*	Check: New and Old Values Match
	*/
	if	(pValid)
	then
		if	(
		pPackageCLIold.dcId		=	pPackageCLInew.dcId
		and
		pPackageCLIold.pcCLI		=	pPackageCLInew.pcCLI
			)
		then
			pValid	:=	FALSE;	
			pError	:=	20;
			pErrorText	:=	'(Static) New and Old Values Match';
		end	if;
	end	if;
/*	Check: New Values Match Customer Details
	*/
	if	(pValid)
	then
		if	(
		cCustCLI.dcId			=	pPackageCLInew.dcId
		and
		cCustCLI.ccCLI			=	pPackageCLInew.pcCLI
			)
		then
			pValid	:=	FALSE;
			pError	:=	30;
			pErrorText	:=	'(Static) New Values Match Customer Details';
		end	if;
	end	if;
/*	Check: New Values Match Existing Details
	*/
	if	(pValid)
	then
	for	i	in	cPackageCLIs.FIRST..cPackageCLIs.LAST
	loop
		if	(
		cPackageCLIs(i).dcId		=	pPackageCLInew.dcId
		and
		cPackageCLIs(i).pcCLI		=	pPackageCLInew.pcCLI
			)
		then
			pValid	:=	FALSE;
			pError	:=	40;
			pErrorText	:=	'(Static) New Values Match Existing Details';
		end	if;
	end	loop;
	end	if;
	/*	Apply proposed "after image" to cache
		*/
	cPackageCLIs(ppsId)		:=	pPackageCLInew;
	/*	Dynamic validation ...
		*/
	if	(pValid)
	then
	declare
		pSQLText		varchar2(1024);
		pErr			number;
		pErrText		varchar2(1024);
	begin
		pSQLText	:=
'BEGIN ' ||
 cCustCLI.cpPLSQL ||
'(pError => :b00, pErrorText => :b01);' ||
'END;';
		dbms_sql.parse(pSQLCursor, pSQLText, dbms_sql.native);
		dbms_sql.bind_variable(pSQLCursor, ':b00', pErr);
		dbms_sql.bind_variable(pSQLCursor, ':b01', pErrText, 1024);
		if	(
			dbms_sql.execute(pSQLCursor)	!=	1
			)
		then
			pErr	:=	100;
			pErrText	:=
'(Dynamic) Internal Error Executing PL/SQL Rule';
		else
			dbms_sql.variable_value(pSQLCursor, ':b00', pErr);
			dbms_sql.variable_value(pSQLCursor, ':b01', pErrText);
		end	if;
		if	(
			pErr 				>	0
			)
		then
			pValid	:=	FALSE;
			pError	:=	pErr;
			pErrorText	:=	pErrText;
		end	if;
	end;
	end	if;
	/*	Consolidation - write successful change to database
		or "rollback" unsuccessful change in cache
		*/
	if	(pValid)
	then
		/*	Write through cache
			*/
		pPackageCLIold.pcValidTo		:=	pPackageCLInew.pcValidFrom - 1 / (60 * 60 * 24);
		ccDataPkg.setPackageCLI
		(
		 pPackageCLIold	=>	pPackageCLIold
		,pPackageCLInew	=>	pPackageCLInew
		);
		if	(
		cCustCLI.ccUpdatesAllowed	>	0
		and
		pPackageCLIold.dcId		!=	ccMiscPkg.dcIdUnused
			)
		then
			cCustCLI.ccUpdates	:=	cCustCLI.ccUpdates + 1;
			ccDataPkg.setCustCLI
			(
			 pCustCLI	=>	cCustCLI
			);
		end	if;
		commit;
	else
		/*	"Rollback"
			*/
		cPackageCLIs(ppsId)	:=	pPackageCLIold;
	end	if;
  dbms_application_info.set_module(null,null);
	end		setPackageCLI;
/*	Anonymous block initialisation
	*/
	begin
		pSQLCursor	:=	dbms_sql.open_cursor;
end	ccAppPkg;
/

