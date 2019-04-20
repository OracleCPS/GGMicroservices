create	or	replace
package
	ccAppPkg
as
/*	Package constants
	*/
	pSQLCursor		integer;
/*	Package state variables
	c	cache structures
	ci	cache initialisation
	*/
	cCustAccount		ccMiscPkg.c_getCustAccount%ROWTYPE;
	cCustCLI		ccMiscPkg.c_getCustCLI%ROWTYPE;
	cPackageCLIs		ccMiscPkg.pPackageCLIs;
	ciCustAccount		ccMiscPkg.c_getCustAccount%ROWTYPE;
	ciCustCLI		ccMiscPkg.c_getCustCLI%ROWTYPE;
	ciPackageCLIs		ccMiscPkg.pPackageCLIs;
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
	);
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
	);
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
	);
/****************************************************************************
 * create new Customer CLI details                                          *
 ****************************************************************************/
	procedure	newCustCLI
	(
	/*			IN	ccMiscPkg.c_getCustCLI%ROWTYPE
		*/
--	,pccROWID		IN	ROWID
--	,pccId			IN	cc.ccId%TYPE
-- nu	,pccValidFrom		IN	cc.ccValidFrom%TYPE;
-- nu	,pccValidTo		IN	cc.ccValidTo%TYPE;
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
	);
/****************************************************************************
 * get Package CLI details for a given Customer CLI Id                      *
 ****************************************************************************/
	procedure	getPackageCLIs
	(
	 pccId			IN	pc.ccId%TYPE
	);
/****************************************************************************
 * query current Package CLI details for a given Customer CLI Id            *
 ****************************************************************************/
	procedure	qryPackageCLIsCurrent
	(
	 pccId			IN	pc.ccId%TYPE
	);
/****************************************************************************
 * query Package CLI history for a given Customer CLI Id                    *
 ****************************************************************************/
	procedure	qryPackageCLIsHistory
	(
	 pccId			IN	pc.ccId%TYPE
	);
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
	);
end	ccAppPkg;
/

