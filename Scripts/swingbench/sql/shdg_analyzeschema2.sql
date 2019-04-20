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
            dbms_stats.set_global_prefs('CONCURRENT','TRUE');
            dbms_stats.set_table_prefs('&username','COUNTRIES','INCREMENTAL','TRUE');
            dbms_stats.set_table_prefs('&username','CHANNELS','INCREMENTAL','TRUE');
            dbms_stats.set_table_prefs('&username','CUSTOMERS','INCREMENTAL','TRUE');
            dbms_stats.set_table_prefs('&username','PROMOTIONS','INCREMENTAL','TRUE');
            dbms_stats.set_table_prefs('&username','PRODUCTS','INCREMENTAL','TRUE');
            dbms_stats.set_table_prefs('&username','PRODUCTS','INCREMENTAL','TRUE');
            dbms_stats.set_table_prefs('&username','SUPPLEMENTARY_DEMOGRAPHICS','INCREMENTAL','TRUE');
            dbms_stats.set_table_prefs('&username','SALES','INCREMENTAL','TRUE');
            dbms_stats.set_table_prefs('&username','TIMES','INCREMENTAL','TRUE');
            dbms_stats.gather_schema_stats('&username');
        $ELSIF DBMS_DB_VERSION.VER_LE_12
        $THEN
             -- Oracle 12c. Concurrent Stats collection work slightly different in this release
             execute immediate q'[ALTER SYSTEM SET RESOURCE_MANAGER_PLAN = 'DEFAULT_PLAN']';
             if jobs_count < &parallelism then
                execute immediate q'[ALTER SYSTEM SET JOB_QUEUE_PROCESSES = &parallelism ]';
             end if;
             dbms_stats.set_global_prefs('CONCURRENT','MANUAL');
             dbms_stats.set_table_prefs('&username','COUNTRIES','INCREMENTAL','TRUE');
             dbms_stats.set_table_prefs('&username','CHANNELS','INCREMENTAL','TRUE');
             dbms_stats.set_table_prefs('&username','CUSTOMERS','INCREMENTAL','TRUE');
             dbms_stats.set_table_prefs('&username','PROMOTIONS','INCREMENTAL','TRUE');
             dbms_stats.set_table_prefs('&username','PRODUCTS','INCREMENTAL','TRUE');
             dbms_stats.set_table_prefs('&username','PRODUCTS','INCREMENTAL','TRUE');
             dbms_stats.set_table_prefs('&username','SUPPLEMENTARY_DEMOGRAPHICS','INCREMENTAL','TRUE');
             dbms_stats.set_table_prefs('&username','SALES','INCREMENTAL','TRUE');
             dbms_stats.set_table_prefs('&username','TIMES','INCREMENTAL','TRUE');
             DBMS_STATS.GATHER_SCHEMA_STATS('&username');
        $END
    end;
end;
/

--End