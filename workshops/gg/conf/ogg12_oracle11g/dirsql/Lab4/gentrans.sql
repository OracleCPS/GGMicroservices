
/* Generate Bookstore Transactions */

DECLARE
  v_MainLoop      NUMBER(4);
  v_BookId        NUMBER(4);
  v_BookCtr       NUMBER(4);
  v_Ctr           NUMBER(4);
  v_AmtChg        NUMBER(8,2);

BEGIN

  /* How many books do we sell */
  SELECT count(*) into v_BookCtr from euro.title;

  /* Generate a random number of updates */
  SELECT dbms_random.value(1, v_BookCtr) INTO v_Ctr FROM dual;
  v_Ctr := FLOOR(v_Ctr) * 3;

  /* Do some updates */
  FOR v_MainLoop IN 1 .. v_Ctr LOOP

   /* Select a book to update */
   SELECT dbms_random.value(1, v_BookCtr) INTO v_BookId FROM dual; 
   v_BookId := FLOOR(v_BookId); 

   /* Set the new price */
   SELECT dbms_random.value(1.99, 99.99) INTO v_AmtChg FROM dual; 

   /* Do the update */
   UPDATE euro.title SET PRICE = v_AmtChg, last_change_ts = CURRENT_TIMESTAMP, source = 'Euro' where id = v_BookId;
   COMMIT;

  END LOOP;

END;

/

EXIT;

