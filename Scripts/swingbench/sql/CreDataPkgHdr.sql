create	or	replace
package
	ccDataPkg
as
/*	Package constants
	*/
/*	Package state
	*/
	pInstanceId		ccMiscPkg.c_getInstanceId%ROWTYPE;
/*	Package functions
	*/
/****************************************************************************
 * get Customer Account details for a given Customer Name                   *
 ****************************************************************************/
	function	getCustAccount
	(
	 pcaName		IN	ca.caName%TYPE
	)
	return		ccMiscPkg.c_getCustAccount%ROWTYPE;
/****************************************************************************
 * create new Customer Account details                                      *
 ****************************************************************************/
	function	newCustAccount
	(
	 pCustAccount		IN	ccMiscPkg.c_getCustAccount%ROWTYPE
	)
	return		ca.caId%TYPE;
/****************************************************************************
 * set Customer Account details following a login attempt                   *
 ****************************************************************************/
	procedure	setCustAccount
	(
	 pCustAccount		IN	ccMiscPkg.c_getCustAccount%ROWTYPE
	);
/****************************************************************************
 * get Customer details for a given Customer CLI Id                         *
 ****************************************************************************/
	function	getCustCLI
	(
	 pcaId			IN	cc.caId%TYPE
	,pdcId			IN	cc.dcId%TYPE
	,pccCLI			IN	cc.ccCLI%TYPE
	)
	return		ccMiscPkg.c_getCustCLI%ROWTYPE;
/****************************************************************************
 * create new Customer CLI details                                          *
 ****************************************************************************/
	function	newCustCLI
	(
	 pCustCLI		IN	ccMiscPkg.c_getCustCLI%ROWTYPE
	)
	return		cc.ccId%TYPE;
/****************************************************************************
 * set Customer CLI details following a successful change of Package CLI    *
 ****************************************************************************/
	procedure	setCustCLI
	(
	 pCustCLI		IN	ccMiscPkg.c_getCustCLI%ROWTYPE
	);
/****************************************************************************
 * get Package CLI details for a given Customer CLI Id                      *
 ****************************************************************************/
	function	getPackageCLIs
	(
	 pccId			IN	pc.ccId%TYPE
	)
	return		ccMiscPkg.pPackageCLIs;
/****************************************************************************
 * query Package CLI history for a given Customer CLI Id                    *
 ****************************************************************************/
	function	qryPackageCLIs
	(
	 pccId			IN	pc.ccId%TYPE
	)
	return		ccMiscPkg.pPackageCLIs;
/****************************************************************************
 * set Package CLI details following a validated change of Package CLI      *
 ****************************************************************************/
	procedure	setPackageCLI
	(
	 pPackageCLIold		IN	ccMiscPkg.c_getPackageCLIs%ROWTYPE
	,pPackageCLInew		IN	ccMiscPkg.c_getPackageCLIs%ROWTYPE
	);
/****************************************************************************
 * get Dial Code details for a given Value and Parent Value                 *
 ****************************************************************************/
	function	getDialCode
	(
	 pdcValue		IN	dc.dcValue%TYPE
	,pdcValueParent		IN	dc.dcValue%TYPE
	)
	return		ccMiscPkg.c_getDialCode%ROWTYPE;
end	ccDataPkg;
/

