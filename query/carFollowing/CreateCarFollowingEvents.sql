DROP TABLE IF exists CarFollowingEvents;
SET @NUM := 0;
SET @Device := 0;
SET @Trip := 0;
Set @Time := 0; 
SET @OID := 0;


CREATE TABLE CarFollowingEvents as
select a.device,
	a.trip,
    min(a.time) as startTime,
    max(a.time) as endTime
FROM
	(
    select 
		@NUM := if(@Device = cf.Device and @Trip = cf.Trip and @Time = cf.Time - 10 and @OID = cf.obstacleID, @NUM, @NUM + 1)	as eventNum,
		@Device := `cf`.`Device` as device,
		@Trip := `cf`.`Trip` as trip,
		@Time := `cf`.`Time` as time,
		`cf`.`TargetId`,
		@OId :=`cf`.`ObstacleId` as ObstacleId,
		`cf`.`Range`,
		`cf`.`Rangerate`,
		`cf`.`Transversal`,
		`cf`.`TargetType`,
		`cf`.`Status`,
		`cf`.`CIPV`,
		`cf`.`con`
	FROM `das1`.`CarFollowingSeq` as cf
	ORDER BY device,trip,obstacleID,time
	) as a
GROUP BY a.eventNUM;