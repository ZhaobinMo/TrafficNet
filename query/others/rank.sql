SELECT t.*, 
--       @rownum := @rownum + 1 AS rank
       time - 10*(@rownum := @rownum + 1) as con
  FROM DataWsu t, 
       (SELECT @rownum := 0) r