DROP TAble if exists CutInSeq2;
SET @NUM := 0;
SET @Device := 0;
SET @Trip := 0;
Set @Time := 0; 
SET @ctime :=0;
SET @OID := 0;
Create table cutInSeq2 as 
SELECT
	@NUM := if(@Device = a.Device and @Trip = a.Trip and @ctime = c.time and @Time = a.Time - 10 and @OID = a.obstacleID, @NUM, @NUM + 1)	as eventNum,
    @Device := `a`.`Device` as device,
    @Trip :=`a`.`Trip` as trip,
    @ctime := c.time as cutInTime,
    @Time := `a`.`Time` as time,
    `a`.`TargetId`,
    @OID :=`a`.`ObstacleId` as ObstacleId,
    `a`.`Range`,
    `a`.`Rangerate`,
    `a`.`Transversal`,
    `a`.`TargetType`,
    `a`.`Status`,
    `a`.`CIPV`,
    `a`.`con`,
    `a`.`GpsValidWsu`,
    `a`.`GpsTimeWsu`,
    `a`.`LatitudeWsu`,
    `a`.`LongitudeWsu`,
    `a`.`AltitudeWsu`,
    `a`.`GpsHeadingWsu`,
    `a`.`GpsSpeedWsu`,
    `a`.`HdopWsu`,
    `a`.`PdopWsu`,
    `a`.`FixQualityWsu`,
    `a`.`GpsCoastingWsu`,
    `a`.`ValidCanWsu`,
    `a`.`YawRateWsu`,
    `a`.`SpeedWsu`,
    `a`.`TurnSngRWsu`,
    `a`.`TurnSngLWsu`,
    `a`.`BrakeAbsTcsWsu`,
    `a`.`AxWsu`,
    `a`.`PrndlWsu`,
    `a`.`VsaActiveWsu`,
    `a`.`HeadlampWsu`,
    `a`.`WiperWsu`,
    `a`.`ThrottleWsu`,
    `a`.`SteerWsu`,
    `a`.`NearestNode`,
    `a`.`NNodeLat`,
    `a`.`NNodeLon` 
FROM

	(
	SELECT `w`.`Device`,
		`w`.`Trip`,
		`w`.`Time`,
		`f`.`TargetId`,
		`f`.`ObstacleId`,
		`f`.`Range`,
		`f`.`Rangerate`,
		`f`.`Transversal`,
		`f`.`TargetType`,
		`f`.`Status`,
		`f`.`CIPV`,
		`f`.`con`,
		`w`.`GpsValidWsu`,
		`w`.`GpsTimeWsu`,
		`w`.`LatitudeWsu`,
		`w`.`LongitudeWsu`,
		`w`.`AltitudeWsu`,
		`w`.`GpsHeadingWsu`,
		`w`.`GpsSpeedWsu`,
		`w`.`HdopWsu`,
		`w`.`PdopWsu`,
		`w`.`FixQualityWsu`,
		`w`.`GpsCoastingWsu`,
		`w`.`ValidCanWsu`,
		`w`.`YawRateWsu`,
		`w`.`SpeedWsu`,
		`w`.`TurnSngRWsu`,
		`w`.`TurnSngLWsu`,
		`w`.`BrakeAbsTcsWsu`,
		`w`.`AxWsu`,
		`w`.`PrndlWsu`,
		`w`.`VsaActiveWsu`,
		`w`.`HeadlampWsu`,
		`w`.`WiperWsu`,
		`w`.`ThrottleWsu`,
		`w`.`SteerWsu`,
		`w`.`NearestNode`,
		`w`.`NNodeLat`,
		`w`.`NNodeLon`
	FROM `das1`.`DataWsu` as w
	JOIN `das1`.`DataFrontTargets` as f
		ON f.device = w.device and
			f.trip = w.trip and 
			f.time = w.time
	) as a
JOIN `das1`.`CutInEvents` as c
ON a.device = c.device and 
	a.trip = c.trip and 
    a.ObstacleId = c.ObstacleId and 
    a.TargetId = c.TargetId 
where    a.time between c.time - 500 and c.time + 500
ORDER BY a.device,a.trip,c.time,a.obstacleID,a.time;
        
        

