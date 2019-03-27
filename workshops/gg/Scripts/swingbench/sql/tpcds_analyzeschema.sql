begin
    declare
        jobs_count number := 0;
    begin
    select value into jobs_count from v$parameter
    jobs_count where name='job_queue_processes';
    $IF DBMS_DB_VERSION.VER_LE_10_2
    $THEN
    -- Use the default stats collection approach
    dbms_stats.gather_schema_stats(
        OWNNAME=> '&username'
        ,ESTIMATE_PERCENT=>DBMS_STATS.AUTO_SAMPLE_SIZE
        ,BLOCK_SAMPLE=>TRUE
        ,METHOD_OPT=>'FOR ALL COLUMNS SIZE SKEWONLY'
        ,DEGREE=> &parallelism
        ,GRANULARITY=>'ALL'
        ,CASCADE=>TRUE);
    $ELSIF DBMS_DB_VERSION.VER_LE_11_2
    $THEN
     -- Oracle 11g release 2. Emable concurrent stats collection
    dbms_stats.set_table_prefs('&username','CATALOG_PAGE','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','CATALOG_RETURNS','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','CALL_CENTER','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','CATALOG_SALES','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','CUSTOMER','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','CUSTOMER_ADDRESS','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','CUSTOMER_DEMOGRAPHICS','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','DATE_DIM','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','HOUSEHOLD_DEMOGRAPHICS','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','INCOME_BAND','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','INVENTORY','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','ITEM','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','PROMOTION','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','REASON','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','SHIP_MODE','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','STORE_RETURNS','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','STORE_SALES','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','TIME_DIM','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','WAREHOUSE','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','WEB_PAGE','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','WEB_RETURNS','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','WEB_SALES','INCREMENTAL','TRUE');
    dbms_stats.set_table_prefs('&username','WEB_SITE','INCREMENTAL','TRUE');
    dbms_stats.gather_schema_stats('&username');
    $ELSIF DBMS_DB_VERSION.VER_LE_12
    $THEN
     -- Oracle 12c. Concurrent Stats collection work slightly different in this release
     execute immediate q'[ALTER SYSTEM SET RESOURCE_MANAGER_PLAN = 'DEFAULT_PLAN']';
     if jobs_count < &parallelism then
         execute immediate q'[ALTER SYSTEM SET JOB_QUEUE_PROCESSES = &parallelism ]';
     end if;
     dbms_stats.set_table_prefs('&username','CATALOG_PAGE','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','CATALOG_RETURNS','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','CALL_CENTER','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','CATALOG_SALES','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','CUSTOMER','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','CUSTOMER_ADDRESS','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','CUSTOMER_DEMOGRAPHICS','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','DATE_DIM','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','HOUSEHOLD_DEMOGRAPHICS','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','INCOME_BAND','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','INVENTORY','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','ITEM','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','PROMOTION','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','REASON','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','SHIP_MODE','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','STORE_RETURNS','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','STORE_SALES','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','TIME_DIM','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','WAREHOUSE','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','WEB_PAGE','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','WEB_RETURNS','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','WEB_SALES','INCREMENTAL','TRUE');
     dbms_stats.set_table_prefs('&username','WEB_SITE','INCREMENTAL','TRUE');
     DBMS_STATS.GATHER_SCHEMA_STATS('&username');
    $END
    end;
end;
/

--End