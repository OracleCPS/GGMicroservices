CREATE USER &username IDENTIFIED BY &password;

ALTER USER &username DEFAULT TABLESPACE &tablespace QUOTA UNLIMITED ON &tablespace;

ALTER USER &username QUOTA UNLIMITED ON &indextablespace;

ALTER USER &username TEMPORARY TABLESPACE TEMP;

GRANT CREATE SESSION TO &username;

GRANT CREATE TABLE to &username;

GRANT CREATE SEQUENCE to &username;

GRANT CREATE PROCEDURE to &username;

GRANT RESOURCE TO &username;

GRANT CREATE VIEW to &username;

GRANT ALTER SESSION TO &username;

GRANT EXECUTE ON dbms_lock TO &username;

GRANT CREATE VIEW to &username;

GRANT EXECUTE ON dbms_lock TO &username;

GRANT ANALYZE ANY DICTIONARY to &username;

GRANT ANALYZE ANY to &username;

GRANT CREATE JOB to &username;

GRANT MANAGE SCHEDULER to &username;

GRANT MANAGE ANY QUEUE to &username;

GRANT ALTER SESSION TO &username;

grant select on SYS.V_$PARAMETER to &username;

BEGIN
  $IF DBMS_DB_VERSION.VER_LE_10_2
  $THEN
    null;
  $ELSIF DBMS_DB_VERSION.VER_LE_11_2
  $THEN
    null;
  $ELSIF DBMS_DB_VERSION.VER_LE_12
  $THEN
		-- The Following enables concurrent stats collection on Oracle Database 12c
		EXECUTE IMMEDIATE 'GRANT ALTER SYSTEM TO &username';  
		DBMS_RESOURCE_MANAGER_PRIVS.GRANT_SYSTEM_PRIVILEGE(
   			GRANTEE_NAME   => '&username',
   			PRIVILEGE_NAME => 'ADMINISTER_RESOURCE_MANAGER',
   			ADMIN_OPTION   => FALSE);
	$END
END;

-- End;

