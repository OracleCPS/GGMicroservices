begin
	dbms_utility.analyze_schema(upper('&username'), 'ESTIMATE');
end;
/

-- End;
