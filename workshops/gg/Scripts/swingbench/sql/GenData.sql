set echo off
set feedback off
set verify off

define dirname=&1
define sc=&2
define btxns=&3

define custct=1000000

set termout off

column c1 new_value sc
select	 LEAST(GREATEST(&sc, 10), 1000) / 100	c1
from		 dual
/
column c1 new_value custct
select	 TO_CHAR(CEIL(&custct * &sc))			c1
from		 dual
/

set termout on

REMARK Get,<Name>,<PIN>,<Int. Code>,<Reg. Code>,<Number>
REMARK New,<Name>,<PIN>,<Int. Code>,<Reg. Code>,<Number>,<Call Pkg Id.>
REMARK Qry,<Name>,<PIN>,<Int. Code>,<Reg. Code>,<Number>
REMARK Set,<Id>,<Int. Code>,<Reg. Code>,<Number>
REMARK Upd,<Name>,<PIN>,<Int. Code>,<Reg. Code>,<Number>,<Id>,<Int. Code>,<Reg. Code>,<Number>
REMARK UpI,<Name>,<PIN>,<Int. Code>,<Reg. Code>,<Number>,<Id>,<Int. Code>,<Reg. Code>,<Number>

define noCallPackages=10
define noSlotsPerPackage=10
define noCustAccounts=&custct

define updCC=1.0
define qryCC=0.5
define newCC=0.25

set serveroutput on
exec dbms_output.enable(1000000);

prompt
prompt Generating workload for Calling Circle application 
prompt
prompt Consider rebuilding Calling Circle database if Key Hit Ratio > 30 %
prompt

DECLARE
  pKeyHits            NUMBER := 0;
  pKeyTries           NUMBER := 0;
  TYPE tTxPct
  IS TABLE OF         NUMBER
  INDEX BY            BINARY_INTEGER;
  tTxPcts             tTxPct;
  TYPE tFileName
  IS TABLE OF         VARCHAR2(32)
  INDEX BY            BINARY_INTEGER;
  tFileNames          tFileName;
  TYPE tDirName
  IS TABLE OF         VARCHAR2(128)
  INDEX BY            BINARY_INTEGER;
  tDirNames           tDirName;
  pFile               utl_file.file_type;
  FUNCTION getRnd
  (
   pRange    IN       NUMBER
  )
  RETURN              NUMBER
  IS
  BEGIN
    RETURN(MOD(ABS(DBMS_RANDOM.RANDOM), pRange));
  END getRnd;
  FUNCTION getKey
  (
   pBase     IN       NUMBER
  ,pRange    IN       NUMBER
  ,pUnique   IN       BOOLEAN DEFAULT TRUE
  )
  RETURN              VARCHAR2
  IS
    pDummy            NUMBER;
    pKey              NUMBER;
    pValid            BOOLEAN := FALSE;
  BEGIN
    IF pUnique
    THEN
      LOOP
        EXIT WHEN pValid;
        pKey := pBase + getRnd(pRange);
        BEGIN
          pKeyTries := pKeyTries + 1;
          SELECT  1
          INTO    pDummy
          FROM    custKeys
          WHERE   key = pKey;
          pKeyHits := pKeyHits + 1;
        EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
            pValid := TRUE;
        END;
      END LOOP;
      INSERT INTO custKeys(Key) VALUES (pKey);
      COMMIT;
    ELSE
      pKey := pBase + getRnd(pRange);
    END IF;
    RETURN
    (
       LTRIM(TO_CHAR(pKey, '0000000000000009'))
    || ',1234,+44,01'
    || LTRIM(TO_CHAR(MOD(pKey, 1000), '009'))
    || ','
    || LTRIM(TO_CHAR(MOD(pKey, 1000000), '000009'))
    );
  END getKey;
  PROCEDURE newCCProcess
  (
   pFile     IN       utl_file.file_type
  ,pTxStr    IN       VARCHAR2
  ,pTxns     IN       NUMBER
  )
  IS
  BEGIN
-- New,...
    UTL_FILE.PUT_LINE(pFile, 'New,' || pTxStr || ',' || LTRIM(TO_CHAR(getRnd(10) + 1)));
    FOR i IN 1..pTxns
    LOOP
-- Upd,...
      UTL_FILE.PUT_LINE(pFile, 'Upd,' || pTxStr || ',' || LTRIM(TO_CHAR(i, '09'))
                            || ',+44,01' || LTRIM(TO_CHAR(getRnd(1000), '009'))
                            || ',' || LTRIM(TO_CHAR(getRnd(1000000), '000009')));
    END LOOP;
  END newCCProcess;
  PROCEDURE updCCProcess
  (
   pFile     IN       utl_file.file_type
  ,pTxStr    IN       VARCHAR2
  ,pTxns     IN       NUMBER
  )
  IS
  BEGIN
-- Get,...
    UTL_FILE.PUT_LINE(pFile, 'Get,' || pTxStr);
    FOR i IN 1..pTxns
    LOOP
-- Upd,...
      UTL_FILE.PUT_LINE(pFile, 'Upd,' || pTxStr || ',' || LTRIM(TO_CHAR(i, '09'))
                            || ',+44,01' || LTRIM(TO_CHAR(getRnd(1000), '009'))
                            || ',' || LTRIM(TO_CHAR(getRnd(1000000), '000009')));
    END LOOP;
  END updCCProcess;
  PROCEDURE qryCCProcess
  (
   pFile     IN       utl_file.file_type
  ,pTxStr    IN       VARCHAR2
  )
  IS
  BEGIN
-- Qry,...
    UTL_FILE.PUT_LINE(pFile, 'Qry,' || pTxStr);
  END qryCCProcess;
BEGIN
  tDirNames(1) := '&dirname';
--  tDirNames(1) := '/tmp/callingcircle';
/*
  tDirNames(1) := 'C:\SwingBench\Intel-RAC-0001';
  tDirNames(2) := 'C:\SwingBench\Intel-RAC-0002';
  tDirNames(3) := 'C:\SwingBench\Intel-RAC-0003';
  tDirNames(4) := 'C:\SwingBench\Intel-RAC-0004';
  tDirNames(5) := 'C:\SwingBench\Intel-RAC-0005';
  tDirNames(6) := 'C:\SwingBench\Intel-RAC-0006';
*/
/*
  tDirNames(1) := 'F:\';
  tDirNames(2) := 'G:\';
  tDirNames(3) := 'H:\';
  tDirNames(4) := 'I:\';
  tDirNames(5) := 'J:\';
  tDirNames(6) := 'K:\';
  */
  tFileNames(1) := 'newccprocess.txt';
  tTxPcts(1)    := &newCC;
  tFileNames(2) := 'updccprocess.txt';
  tTxPcts(2)    := &updCC;
  tFileNames(3) := 'qryccprocess.txt';
  tTxPcts(3)    := &qryCC;
  DBMS_RANDOM.INITIALIZE(TO_NUMBER(TO_CHAR(SYSDATE, 'SSSSS')));
FOR k IN tDirNames.FIRST..tDirNames.LAST
LOOP
  FOR i IN tFileNames.FIRST..tFileNames.LAST
  LOOP
    pFile := UTL_FILE.FOPEN(tDirNames(k), tFileNames(i), 'w');
    FOR j IN 1..&btxns * tTxPcts(i)
    LOOP
      IF i = 1
      THEN
-- New Calling Circle Process
-- CaName: 0000000020xxxxxx
        newCCProcess(pFile, getKey(20 * 1000000, &noCustAccounts / 2), 10);
      ELSIF i = 2
      THEN
-- Update Calling Circle Process
-- CaName: 0000000015xxxxxx and 0000000025xxxxxx
        updCCProcess(pFile, getKey((15 + 10 * getRnd(2)) * 1000000, &noCustAccounts / 2), 5 + getRnd(5));
      ELSIF i = 3
      THEN
-- Query Calling Circle Process
-- CaName: 0000000015xxxxxx and 0000000025xxxxxx
        qryCCProcess(pFile, getKey((15 + 10 * getRnd(2)) * 1000000, &noCustAccounts / 2, FALSE));
      ELSE
        RAISE NO_DATA_FOUND;
      END IF;
    END LOOP;
    UTL_FILE.FCLOSE(pFile);
  END LOOP;
END LOOP;
  DBMS_RANDOM.TERMINATE;
  DBMS_OUTPUT.PUT_LINE('Key Hit Ratio = ' || TO_CHAR(pKeyHits / pKeyTries * 100, '990.99') || ' %');
END;
/

prompt

exit;
