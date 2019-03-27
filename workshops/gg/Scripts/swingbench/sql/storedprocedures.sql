create or replace type integer_return_array is varray(25) of integer
/

create or replace PACKAGE swingbench AS
  function storedprocedure1(min_sleep integer, max_sleep integer) return integer_return_array;
  function storedprocedure2(min_sleep integer, max_sleep integer) return integer_return_array;
  function storedprocedure3(min_sleep integer, max_sleep integer) return integer_return_array;
  function storedprocedure4(min_sleep integer, max_sleep integer) return integer_return_array;
  function storedprocedure5(min_sleep integer, max_sleep integer) return integer_return_array;
  function storedprocedure6(min_sleep integer, max_sleep integer) return integer_return_array;
END;
/

create or replace PACKAGE BODY swingbench AS
  SELECT_STATEMENTS   integer := 1;
  INSERT_STATEMENTS   integer := 2;
  UPDATE_STATEMENTS   integer := 3;
  DELETE_STATEMENTS   integer := 4;
  COMMIT_STATEMENTS   integer := 5;
  ROLLBACK_STATEMENTS integer := 6;
  SLEEP_TIME          integer := 7;
  info_array integer_return_array := integer_return_array();
  function from_mills_to_tens(value integer) return float is
    real_value float := 0;
    begin
      real_value := value/1000;
      return real_value;
      exception
        when zero_divide then
          real_value := 0;
          return real_value;
  END FROM_MILLS_TO_TENS;
  function from_mills_to_secs(value integer) return float is    
    real_value float := 0;    
    begin    
      real_value := value/1000;    
      return real_value;    
      exception    
        when zero_divide then    
          real_value := 0;    
          return real_value;    
  end from_mills_to_secs;
  procedure sleep(min_sleep integer, max_sleep integer) is
    sleeptime number := 0;
    begin
      if (max_sleep = min_sleep) then
        sleeptime := from_mills_to_secs(max_sleep);
        dbms_lock.sleep(sleeptime);
      elsif (((max_sleep - min_sleep) > 0) AND (min_sleep < max_sleep)) then
        sleeptime := dbms_random.value(from_mills_to_secs(min_sleep), from_mills_to_secs(max_sleep));
        dbms_lock.sleep(sleeptime);
     end if;
     info_array(SLEEP_TIME) := (sleeptime * 1000) + info_array(SLEEP_TIME);
  end sleep;
  procedure init_dml_array is
    begin
      info_array := integer_return_array();
      for i in 1..7 loop
        info_array.extend;
        info_array(i) := 0;
      end loop;
  end init_dml_array;
  procedure increment_selects(num_selects integer) is
    begin
      info_array(SELECT_STATEMENTS) := info_array(SELECT_STATEMENTS) + num_selects;
  end increment_selects;
  procedure increment_inserts(num_inserts integer) is
    begin
      info_array(INSERT_STATEMENTS) := info_array(INSERT_STATEMENTS) + num_inserts;
  end increment_inserts;
  procedure increment_updates(num_updates integer) is
    begin
      info_array(UPDATE_STATEMENTS) := info_array(UPDATE_STATEMENTS) + num_updates;
  end increment_updates;
  procedure increment_deletes(num_deletes integer) is
    begin
      info_array(DELETE_STATEMENTS) := info_array(DELETE_STATEMENTS) + num_deletes;
  end increment_deletes;
  procedure increment_commits(num_commits integer) is
    begin
      info_array(COMMIT_STATEMENTS) := info_array(COMMIT_STATEMENTS) + num_commits;
  end increment_commits;
  procedure increment_rollbacks(num_rollbacks integer) is
    begin
      info_array(ROLLBACK_STATEMENTS) := info_array(ROLLBACK_STATEMENTS) + num_rollbacks;
  end increment_rollbacks;
  function storedprocedure1(min_sleep integer, max_sleep integer) return integer_return_array is
    begin
      init_dml_array();
      sleep(min_sleep, max_sleep);
      return info_array;
  end storedprocedure1;
  function storedprocedure2(min_sleep integer, max_sleep integer) return integer_return_array is
    begin
      init_dml_array();
      sleep(min_sleep, max_sleep);
      return info_array;
  end storedprocedure2;
  function storedprocedure3(min_sleep integer, max_sleep integer) return integer_return_array is
    begin
      init_dml_array();
      sleep(min_sleep, max_sleep);
      return info_array;
  end storedprocedure3;
  function storedprocedure4(min_sleep integer, max_sleep integer) return integer_return_array is
    begin
      init_dml_array();
      select count(1) from dual;

      sleep(min_sleep, max_sleep);
      return info_array;
  end storedprocedure4;
  function storedprocedure5(min_sleep integer, max_sleep integer) return integer_return_array is
    begin
      init_dml_array();
      sleep(min_sleep, max_sleep);
      return info_array;
  end storedprocedure5;
  function storedprocedure6(min_sleep integer, max_sleep integer) return integer_return_array is
    begin
      init_dml_array();
      sleep(min_sleep, max_sleep);
      return info_array;
  end storedprocedure6;
END;
/

