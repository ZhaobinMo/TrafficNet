Drop table if exists LaneChangeEventLeftSeqtemp;
SET @num := 0;    
SET @Device := 0;
SET @Trip := 0;
SET @Time := 0;

CREATE TABLE LaneChangeEventLeftSeqtemp AS SELECT 
	@num := if(@Device = w.Device and @Trip = w.Trip and @Time = w.Time - 10, @num, @num + 1)as Num,
	@Device :=`w`.`Device` as Device,
    @Trip := `w`.`Trip` as Trip,
    @Time := `w`.`Time` as Time,
    l.startTime as startTime,
    l.leftWheelPassTime as leftWheelPassTime,
    l.rightWheelPassTime as rightWheelPassTime,
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
FROM    `das1`.`DataWsu` AS w
JOIN `das1`.`LaneChangeEventLeftSeq` AS l
	ON w.Device = l.Device AND l.Trip = w.Trip AND w.Time between l.leftWheelPassTime - 200 and l.rightWheelPassTime + 200
ORDER BY l.Device,l.Trip,l.startTime,w.time;

