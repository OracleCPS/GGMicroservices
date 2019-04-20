PROMPT "--------------------------------------- "
PROMPT "DESCRIBE PRODUCTS TABLE"
PROMPT "--------------------------------------- "
desc products;

PROMPT "--------------------------------------- "
PROMPT "DESCRIBE CURRENCY TABLE"
PROMPT "--------------------------------------- "
desc currency;

PROMPT "--------------------------------------- "
PROMPT "SELECT USER from DBA_USERS"
PROMPT "--------------------------------------- "
select username, created from dba_users where username = 'CURRENCY_ADMIN';

EXIT;

