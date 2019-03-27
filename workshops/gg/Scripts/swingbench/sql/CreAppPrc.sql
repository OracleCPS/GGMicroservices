create	or	replace
procedure
	cp&cpId
	(
	 pError			OUT	number
	,pErrorText		OUT	varchar2
	)
as
	pDialCode	ccMiscPkg.c_getDialCode%ROWTYPE;
	pCountMOB	number		:=	0;
	pErr		number		:=	0;
	pErrText	varchar2(1024)	:=	'Success';
begin
	/*	Dynamic validation ...
		*/
/*	Check: Too Many Mobile Numbers
	*/
	for	i	in	ccAppPkg.cPackageCLIs.FIRST..ccAppPkg.cPackageCLIs.LAST
	loop
		pDialCode	:=	ccDataPkg.getDialCode
					(
			 pdcValue			=>	ccAppPkg.cPackageCLIs(i).dcRegionValue
			,pdcValueParent		=>	ccAppPkg.cPackageCLIs(i).dcCountryValue
					);
		if	(
		pDialCode.dcRegionType	=	'MOB'
			)
		then
			pCountMOB	:=	pCountMOB + 1;
		end	if;
	end	loop;
	if	(pCountMOB	>	10 + &cpId)
	then
		pErr	:=	110;
		pErrText	:=	'(Dynamic) Too Many Mobile Numbers';
	end	if;
	pError	:=	pErr;
	pErrorText	:=	pErrText;
end	cp&cpId;
/

-- End;
