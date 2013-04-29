--  Let's only work with the tables with data! - once we know them we may not need to this is again 
SELECT 'SELECT '''
  ||TABLE_NAME
  ||''', COUNT(*) from UAT_ODI_REPO.'
  ||TABLE_NAME
  ||' HAVING COUNT(*) > 0'
FROM ALL_TAB_COLUMNS
WHERE COLUMN_NAME = 'SESS_NO'
AND OWNER         = 'UAT_ODI_REPO'
AND TABLE_NAME NOT LIKE 'BKP%'
AND TABLE_NAME NOT LIKE '%OLD';
--
-- now get tables with rows so add union all
--
SELECT 'SNP_LPI_EXC_LOG',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_LPI_EXC_LOG
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_LPI_STEP_LOG',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_LPI_STEP_LOG
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_PARAM_SESS',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_PARAM_SESS
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_SEQ_SESS',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_SEQ_SESS
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_SESSION',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_SESSION
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_SESS_STEP',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_SESS_STEP
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_SESS_STEP_LV',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_SESS_STEP_LV
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_SESS_TASK',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_SESS_TASK
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_SESS_TASK_LOG',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_SESS_TASK_LOG
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_SESS_TASK_LS',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_SESS_TASK_LS
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_SESS_TXT_LOG',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_SESS_TXT_LOG
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_STEP_LOG',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_STEP_LOG
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_TASK_TXT',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_TASK_TXT
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_VAR_SESS',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_VAR_SESS
HAVING COUNT(*) > 0
UNION ALL
SELECT 'SNP_SESSION_VW',
  COUNT( *)
FROM UAT_ODI_REPO.SNP_SESSION_VW
HAVING COUNT(*) > 0 ;
--
-- ignore the VIEW!!
--
/*
SNP_SESSION
SNP_SESS_STEP
SNP_SESS_TASK
SNP_SESS_TASK_LOG
SNP_STEP_LOG
SNP_VAR_SESS
*/
--
-- But we also need to clear the scenario reports too!
-- SNP_STEP_REPORT, SNP_SCEN_REPORT
--
-- for each of sbove we need to truncate, but first disable related FKs
--
BEGIN
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_SESSION'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  END LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_SESS_STEP'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  END LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_SESS_TASK'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  END LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_SESS_TASK_LOG'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  END LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_STEP_LOG'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  END LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_VAR_SESS'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  END LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_STEP_REPORT'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  end LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  and FK.R_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_SCEN_REPORT'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" DISABLE';
  END LOOP;
end;
/
--
-- constraints done now truncate - drop storagae as we may as well shrink the storage
--
TRUNCATE TABLE UAT_ODI_REPO.SNP_SESSION
DROP STORAGE;
TRUNCATE TABLE UAT_ODI_REPO.SNP_SESS_STEP
DROP STORAGE;
TRUNCATE TABLE UAT_ODI_REPO.SNP_SESS_TASK
DROP STORAGE;
TRUNCATE TABLE UAT_ODI_REPO.SNP_SESS_TASK_LOG
DROP STORAGE;
TRUNCATE TABLE UAT_ODI_REPO.SNP_STEP_LOG
DROP STORAGE;
TRUNCATE TABLE UAT_ODI_REPO.SNP_VAR_SESS
DROP STORAGE;
TRUNCATE TABLE UAT_ODI_REPO.SNP_SCEN_REPORT
drop storage;
TRUNCATE TABLE UAT_ODI_REPO.SNP_STEP_REPORT
drop storage;
--
-- now put back the constriants
-- 
--
BEGIN
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
       all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_SESSION'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  END LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_SESS_STEP'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  end LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_SESS_TASK'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  end LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_SESS_TASK_LOG'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  end LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_STEP_LOG'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  end LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_VAR_SESS'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  end LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  AND fk.R_CONSTRAINT_NAME = pk.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_STEP_REPORT'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  end LOOP;
  FOR cur IN
  (SELECT fk.owner,
    fk.constraint_name ,
    fk.table_name
  FROM all_constraints fk,
    all_constraints pk
  WHERE fk.CONSTRAINT_TYPE = 'R'
  AND pk.owner             = 'UAT_ODI_REPO'
  AND fk.r_owner           = pk.owner
  and FK.R_CONSTRAINT_NAME = PK.CONSTRAINT_NAME
  AND pk.TABLE_NAME        = 'SNP_SCEN_REPORT'
  )
  LOOP
    EXECUTE immediate 'ALTER TABLE "'||cur.owner||'"."'||cur.table_name||'" MODIFY CONSTRAINT "'||cur.constraint_name||'" ENABLE';
  end LOOP;
end;
/
--
-- almost done! now just update SNP_ID
--
UPDATE UAT_ODI_REPO.SNP_ID
set ID_NEXT       =1
where ID_TBL   = 'SNP_SESSION'
;
commit;
--
-- done
--
select * from UAT_ODI_REPO.SNP_ID; -- 9912518