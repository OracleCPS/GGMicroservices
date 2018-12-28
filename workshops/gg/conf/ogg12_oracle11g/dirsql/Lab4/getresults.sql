/*select title, price, last_change_ts, source from title;

select id, notes, conflict_reason from title_exceptions;*/

SET SERVEROUTPUT ON
SET LINESIZE 120

DECLARE
  v_MainLoop      NUMBER(4);
  v_BookCtr       NUMBER(4);
  v_eTitle        VARCHAR2(80);
  v_eLChg         TIMESTAMP;
  v_ePrice        NUMBER(8,2);
  v_eSrvr         VARCHAR2 (8);
  v_eNote         VARCHAR2(20);
  v_eConf         VARCHAR2(20);
  v_RSRece euro.title_exceptions%ROWTYPE;
  CURSOR v_eBookId IS SELECT id, notes, conflict_reason from euro.title_exceptions;

BEGIN

  SELECT count(*) into v_BookCtr from euro.title;
  dbms_output.put_line('--');
  dbms_output.put_line('------------------Current Table Contents------------------');
  dbms_output.put_line('--');

  FOR v_MainLoop IN 1 .. v_BookCtr LOOP
   select title, price, last_change_ts, source into v_eTitle, v_EPrice, v_eLChg, v_eSrvr from euro.title where id = v_MainLoop;
   dbms_output.put_line('Book Title: '||v_eTitle);
   dbms_output.put_line('Euro Price: '||v_ePrice);
   dbms_output.put_line('Euro Change TS: '||v_eLChg);
   dbms_output.put_line('Euro Change Orig: '||v_eSrvr);

   dbms_output.put_line('--');
  END LOOP; 
  
  dbms_output.put_line('--');
  dbms_output.put_line('------------------EURO Exceptions Table Contents------------------');
  dbms_output.put_line('--');

  FOR v_RSRece IN v_eBookId LOOP
   select title into v_eTitle from euro.title where id = v_RsRece.id;
   dbms_output.put_line('Conflict==> '||v_eTitle||' ==> Conflict Reason: '||v_RsRece.conflict_reason);
   dbms_output.put_line('--');
  END LOOP;

END;
/





EXIT;
