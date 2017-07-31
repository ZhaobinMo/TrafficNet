DROP TABLE IF EXISTS FreeFlowSeq;

SET @NUM := 0;
SET @Device := 0;
SET @Trip := 0;
Set @Time := 0; 
CREATE TABLE FreeFlowSeq as 
SELECT
	@num := if(@Device = w.Device and @Trip = w.Trip and @Time = w.Time - 10, @num, @num + 1)  as eventNum,
	@Device := `w`.`Device`	,
	@Trip := `w`.`Trip`	,
	@Time := `w`.`Time`	,	
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
FROM  DataFrontTargets as f
LEFT JOIN `das1`.`DataWsu`as w
ON 	w.device = f.device and 
	w.trip = f.trip and 
    w.time = f.time 
where f.device = NULL
ORDER BY w.device, w.trip, w.time;
