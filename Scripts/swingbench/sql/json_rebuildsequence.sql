drop sequence PASSENGER_SEQ;

begin
	declare
		passenger_count	number :=0;
	begin
		select count(*) into passenger_count from PASSENGERCOLLECTION;
		passenger_count := passenger_count + 1;
		execute immediate 'create sequence PASSENGER_SEQ start with '||passenger_count||'  cache 100000'; 
	end;
end;
/

-- exit
