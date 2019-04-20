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
             dbms_output.put_line('database version is less than or equal to 11.2');
             DBMS_STATS.SET_GLOBAL_PREFS('CONCURRENT','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','WAREHOUSES','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','INVENTORIES','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','PRODUCT_INFORMATION','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','PRODUCT_DESCRIPTIONS','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','ORDERENTRY_METADATA','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','CUSTOMERS','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','ADDRESSES','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','ORDER_ITEMS','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','ORDERS','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','LOGON','INCREMENTAL','TRUE');
             DBMS_STATS.GATHER_SCHEMA_STATS('&username');
        $ELSIF DBMS_DB_VERSION.VER_LE_12
        $THEN
             -- Oracle 12c. Concurrent Stats collection work slightly different in this release
             execute immediate q'[ALTER SYSTEM SET RESOURCE_MANAGER_PLAN = 'DEFAULT_PLAN']';
             if jobs_count < &parallelism then
                execute immediate q'[ALTER SYSTEM SET JOB_QUEUE_PROCESSES = &parallelism ]';
             end if;
             execute immediate q'[ALTER SYSTEM SET JOB_QUEUE_PROCESSES = &parallelism ]';
             DBMS_STATS.SET_GLOBAL_PREFS('CONCURRENT','MANUAL');
             DBMS_STATS.SET_TABLE_PREFS('&username','WAREHOUSES','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','INVENTORIES','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','PRODUCT_INFORMATION','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','PRODUCT_DESCRIPTIONS','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','ORDERENTRY_METADATA','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','CUSTOMERS','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','ADDRESSES','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','ORDER_ITEMS','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','ORDERS','INCREMENTAL','TRUE');
             DBMS_STATS.SET_TABLE_PREFS('&username','LOGON','INCREMENTAL','TRUE');
             DBMS_STATS.GATHER_SCHEMA_STATS('&username');
        $END
    end;
end;
/

--End
