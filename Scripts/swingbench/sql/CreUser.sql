grant	 connect, resource
to	&username	identified	by	&password
/

alter	user	&username
default	tablespace	USERS
temporary	tablespace	TEMP
/

grant alter session to &username;

grant create synonym to &username;

REM  grant	 select
REM on	sys.v_$mystat
REM to	&dbuser
REM /

REM grant	 select
REM on	sys.v_$instance
REM to	&dbuser
REM /

