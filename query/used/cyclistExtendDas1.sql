CREATE TABLE das1_Yaohui.cyclist as
SELECT 
	`DataFrontTargets`.`Device`,
    `DataFrontTargets`.`Trip`,
    `DataFrontTargets`.`Time`,
    `DataFrontTargets`.`TargetId`,
    `DataFrontTargets`.`ObstacleId`,
    `DataFrontTargets`.`Range`,
    `DataFrontTargets`.`Rangerate`,
    `DataFrontTargets`.`Transversal`,
    `DataFrontTargets`.`TargetType`,
    `DataFrontTargets`.`Status`,
    `DataFrontTargets`.`CIPV`,
--     `DataWsu`.`Device`,
--     `DataWsu`.`Trip`,
--     `DataWsu`.`Time`,
    `DataWsu`.`GpsValidWsu`,
    `DataWsu`.`GpsTimeWsu`,
    `DataWsu`.`LatitudeWsu`,
    `DataWsu`.`LongitudeWsu`,
    `DataWsu`.`AltitudeWsu`,
    `DataWsu`.`GpsHeadingWsu`,
    `DataWsu`.`GpsSpeedWsu`,
    `DataWsu`.`HdopWsu`,
    `DataWsu`.`PdopWsu`,
    `DataWsu`.`FixQualityWsu`,
    `DataWsu`.`GpsCoastingWsu`,
    `DataWsu`.`ValidCanWsu`,
    `DataWsu`.`YawRateWsu`,
    `DataWsu`.`SpeedWsu`,
    `DataWsu`.`TurnSngRWsu`,
    `DataWsu`.`TurnSngLWsu`,
    `DataWsu`.`BrakeAbsTcsWsu`,
    `DataWsu`.`AxWsu`,
    `DataWsu`.`PrndlWsu`,
    `DataWsu`.`VsaActiveWsu`,
    `DataWsu`.`HeadlampWsu`,
    `DataWsu`.`WiperWsu`,
    `DataWsu`.`ThrottleWsu`,
    `DataWsu`.`SteerWsu`
FROM `das1`.`DataFrontTargets`
	JOIN `das1`.`DataWsu`
		ON 	`DataFrontTargets`.`Device` = `DataWsu`.`Device` and
			`DataFrontTargets`.`Trip` = `DataWsu`.`Trip` and
			`DataFrontTargets`.`Time` = `DataWsu`.`Time`
WHERE `DataFrontTargets`.`TargetType` = 4
ORDER BY `DataFrontTargets`.`Device`,`DataFrontTargets`.`Trip`,`DataFrontTargets`.`Time`
-- LIMIT 200