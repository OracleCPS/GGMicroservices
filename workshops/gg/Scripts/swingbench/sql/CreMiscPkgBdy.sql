create	or	replace
package	body
	ccMiscPkg
as
/*	Package constants
	*/
/*	Package cursors
	*/
/*	Package functions
	*/
	function	getInstanceId
	return		c_getInstanceId%ROWTYPE
	is
		pInstanceId	c_getInstanceId%ROWTYPE;
	begin
	/*	include following PL/SQL statement to run *without* OPS
		sequence optimisation
		*/
		pInstanceId.instance_number	:=	0;
	/*	include following SQL statement to run *with* OPS sequence
		optimisation
		open	c_getInstanceId;
		fetch	c_getInstanceId
		into	 pInstanceId;
		*/
		return	(
			 pInstanceId
			);
	end		getInstanceId;
end	ccMiscPkg;
/

