/*select title, price, last_change_ts, source from title;

select id, notes, conflict_reason from title_exceptions;*/

SET SERVEROUTPUT ON
SET LINESIZE 120

DECLARE
  v_MainLoop      NUMBER(4);
  v_BookCtr       NUMBER(4);
  v_aTitle        VARCHAR2(80);
  v_aLChg         TIMESTAMP;
  v_aPrice        NUMBER(8,2);
  v_aSrvr         VARCHAR2 (8);
  v_aNote         VARCHAR2(20);
  v_aConf         VARCHAR2(20);
  v_RSRec amer.title_exceptions%ROWTYPE;
  CURSOR v_aBookId IS SELECT id, notes, conflict_reason from amer.title_exceptions;

BEGIN

  SELECT count(*) into v_BookCtr from amer.title;
  dbms_output.put_line('--');
  dbms_output.put_line('------------------Current Table Contents------------------');
  dbms_output.put_line('--');

  FOR v_MainLoop IN 1 .. v_BookCtr LOOP
   select title, price, last_change_ts, source into v_aTitle, v_aPrice, v_aLChg, v_aSrvr from amer.title where id = v_MainLoop;
   dbms_output.put_line('Book Title: '||v_aTitle);
   dbms_output.put_line('Amer Price: '||v_aPrice);
   dbms_output.put_line('Amer Change TS: '||v_aLChg);
   dbms_output.put_line('Amer Change Orig: '||v_aSrvr);

   dbms_output.put_line('--');
  END LOOP; 
  dbms_output.put_line('--');
  dbms_output.put_line('------------------AMER Exceptions Table Contents------------------');
  dbms_output.put_line('--');

  FOR v_RSRec IN v_aBookId LOOP
   select title into v_aTitle from amer.title where id = v_RsRec.id;
   dbms_output.put_line('Conflict==> '||v_aTitle||' ==> Conflict Reason: '||v_RsRec.conflict_reason);
   dbms_output.put_line('--');
  END LOOP;

END;
/





EXIT;
