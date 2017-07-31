DROP TABLE IF EXISTS CutInEvents;

SET @NUM := 0;
SET @Device := 0;
SET @Trip := 0;
Set @Time := 0; 
SET @CIPV := 0;
SET @OID := 0;
SET @cutin := 0;
CREATE TABLE CutInEvents as 
SELECT 
	a.device,
	a.trip,
    a.time,
    a.TargetId,
    a.ObstacleId,
	a.`Range`,
    a.Rangerate,
    a.`Transversal`,
    a.`TargetType`,
    a.`Status`,
    a.`CIPV`,
    a.cutin
FROM
	(
    SELECT
		@cutin := if(@Device = f.Device and @Trip = f.Trip and @Time = f.Time - 10 and @CIPV = 0 and f.CIPV = 1 and @OID = f.obstacleID, 1, 0)	as cutIn,
		@Device := `f`.`Device`	as Device,
		@Trip := `f`.`Trip`	as trip,
		@Time := `f`.`Time`	as time,	
		`f`.`TargetId`,
		@OID := `f`.`ObstacleId` as ObstacleId,
		`f`.`Range`,
		`f`.`Rangerate`,
		`f`.`Transversal`,
		`f`.`TargetType`,
		`f`.`Status`,
		@CIPV := `f`.`CIPV` as CIPV
	FROM  DataFrontTargets as f
    WHERE f.targettype = 0
	ORDER BY f.device, f.trip, f.obstacleID, f.time
    ) as a
WHERE a.cutin = 1
ORDER BY a.device, a.trip, a.obstacleID, a.time;




