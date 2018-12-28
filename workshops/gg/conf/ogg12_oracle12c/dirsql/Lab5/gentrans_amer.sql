
/* Generate Bookstore Transactions */

DECLARE
  v_MainLoop      NUMBER(4);
  v_BookId        NUMBER(4);
  v_BookCtr       NUMBER(4);
  v_Ctr           NUMBER(4);
  v_AmtChg        NUMBER(8,2);
  v_Srvr          NUMBER(2);

BEGIN

  /* How many books do we sell */
  SELECT count(*) into v_BookCtr from amer.title;

  /* Generate a random number of updates */
  SELECT dbms_random.value(1, v_BookCtr) INTO v_Ctr FROM dual;
  v_Ctr := v_Ctr * 3;

  /* Do some updates */
  FOR v_MainLoop IN 1 .. v_Ctr LOOP

   /* Select a book to update */
   SELECT dbms_random.value(1, v_BookCtr) INTO v_BookId FROM dual;  

   /* Set the new price */
   SELECT dbms_random.value(1.99, 999.99) INTO v_AmtChg FROM dual; 

   /* Choose a database to update */
   SELECT dbms_random.value(1, 10) INTO v_Srvr FROM dual;

   /* Do the update */
   IF v_Srvr < 6 THEN

    UPDATE amer.title SET PRICE = v_AmtChg, last_change_ts = CURRENT_TIMESTAMP, source = 'Amer' where id = v_BookId;
    COMMIT;

   END IF;

  END LOOP;

END;

/

EXIT;


