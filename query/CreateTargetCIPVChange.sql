DROP TABLE IF EXISTS TargetCIPVChange;
 
CREATE TABLE TargetCIPVChange as  
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
ORDER BY f.device, f.trip, f.obstacleID, f.time;
-- ALTER TABLE TargetCIPVChange add primary key (cutin,device,trip,time,obstacleID);
-- select * 
-- from TargetCIPVChange
-- where device = 10120 and trip = 752 and time between 44000 and 45000 and obstacleID = 47;