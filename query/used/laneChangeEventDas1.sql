-- IF Object_id (N'das1_yaohui..lanechangeevents', N'U') IS NOT NULL 
--   DROP TABLE das1_yaohui..lanechangeevents
-- 
-- 
-- DROP TABLE das1_yaohui..lanechangeevents
-- TRUNCATE TABLE das1_yaohui..lanechangeevents
-- 

DECLARE @D SMALLINT, 
		@T SMALLINT 
        

CREATE TABLE das1_Yaohui.lanechangeevents 
  ( 
     device          SMALLINT, 
     trip            SMALLINT, 
     starttime       INT, 
     endtime         INT, 
     boundarytype    TINYINT, 
     changedirection TINYINT, 
     lanextime1      INT, 
     lanextime2      INT, 
     PRIMARY KEY(device, trip, starttime, endtime, changedirection) 
  )



        
    DECLARE x CURSOR FOR 
      SELECT a.device, 
             a.trip 
      FROM   spfot..summary a 
             LEFT JOIN (SELECT device, 
                               trip 
                        FROM   spscott..lanechangeevents 
                        GROUP  BY device, 
                                  trip) b 
                    ON a.device = b.device 
                       AND a.trip = b.trip 
      WHERE  b.device IS NULL 
             AND a.distance > 100 
      --and a.Device = 10161 --and a.trip = 1200 
      ORDER  BY a.device, 
                a.trip 

    OPEN x 
  
  
  
  
  
  
  
  
  
  
  
  