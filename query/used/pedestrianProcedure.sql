CREATE DEFINER=`dev`@`%` PROCEDURE `cyclist2`()
BEGIN
    DECLARE D, Tr smallint;
    DECLARE Tbegin,Tend,Tbefore,Tafter INT;
    DECLARE Ob tinyint;
    DECLARE row_not_found tinyint default FALSE;
    DECLARE cur1 CURSOR FOR 
		SELECT 	`cyclistTimeInterval10s`.`Device`,
				`cyclistTimeInterval10s`.`Trip`,
				`cyclistTimeInterval10s`.`ObstacleId`,
				`cyclistTimeInterval10s`.`beginCyclistTime`,
				`cyclistTimeInterval10s`.`endCyclistTime`,
				`cyclistTimeInterval10s`.`beforeCyclistTime`,
				`cyclistTimeInterval10s`.`afterCyclistTime`                
		FROM 	`das1`.`cyclistTimeInterval10s`;
    
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET row_not_found = TRUE;
    OPEN cur1;

    
    WHILE row_not_found = FALSE DO
        
        FETCH cur1 INTO D,Tr,Ob,Tbegin,Tend,Tbefore,Tafter;
        


        INSERT INTO cyclist
        SELECT 	`a`.`Device`,
				`a`.`Trip`,
				`a`.`Time`,
				`a`.`TargetId`,
				`a`.`ObstacleId`,
				`a`.`Range`,
				`a`.`Rangerate`,
				`a`.`Transversal`,
				`a`.`TargetType`,
				`a`.`Status`,
				`a`.`CIPV`,
				`b`.`GpsValidWsu`,
				`b`.`GpsTimeWsu`,
				`b`.`LatitudeWsu`,
				`b`.`LongitudeWsu`,
				`b`.`AltitudeWsu`,
				`b`.`GpsHeadingWsu`,
				`b`.`GpsSpeedWsu`,
				`b`.`HdopWsu`,
				`b`.`PdopWsu`,
				`b`.`FixQualityWsu`,
				`b`.`GpsCoastingWsu`,
				`b`.`ValidCanWsu`,
				`b`.`YawRateWsu`,
				`b`.`SpeedWsu`,
				`b`.`TurnSngRWsu`,
				`b`.`TurnSngLWsu`,
				`b`.`BrakeAbsTcsWsu`,
				`b`.`AxWsu`,
				`b`.`PrndlWsu`,
				`b`.`VsaActiveWsu`,
				`b`.`HeadlampWsu`,
				`b`.`WiperWsu`,
				`b`.`ThrottleWsu`,
				`b`.`SteerWsu`
		FROM `das1`.`DataFrontTargets` as a
        INNER JOIN `das1`.`DataWsuTemp` as b
			ON 	a.time = b.time AND
				a.Device = b.Device AND
                a.Trip = b.Trip
		WHERE 	a.Device = D AND
				a.Trip = Tr AND
				a.TargetID = 1 AND
				a.Time BETWEEN Tbefore AND (Tbegin - 10) 
		ORDER BY Device, trip,time; 
        
        INSERT INTO cyclist
        SELECT 	`a`.`Device`,
				`a`.`Trip`,
				`a`.`Time`,
				`a`.`TargetId`,
				`a`.`ObstacleId`,
				`a`.`Range`,
				`a`.`Rangerate`,
				`a`.`Transversal`,
				`a`.`TargetType`,
				`a`.`Status`,
				`a`.`CIPV`,
				`b`.`GpsValidWsu`,
				`b`.`GpsTimeWsu`,
				`b`.`LatitudeWsu`,
				`b`.`LongitudeWsu`,
				`b`.`AltitudeWsu`,
				`b`.`GpsHeadingWsu`,
				`b`.`GpsSpeedWsu`,
				`b`.`HdopWsu`,
				`b`.`PdopWsu`,
				`b`.`FixQualityWsu`,
				`b`.`GpsCoastingWsu`,
				`b`.`ValidCanWsu`,
				`b`.`YawRateWsu`,
				`b`.`SpeedWsu`,
				`b`.`TurnSngRWsu`,
				`b`.`TurnSngLWsu`,
				`b`.`BrakeAbsTcsWsu`,
				`b`.`AxWsu`,
				`b`.`PrndlWsu`,
				`b`.`VsaActiveWsu`,
				`b`.`HeadlampWsu`,
				`b`.`WiperWsu`,
				`b`.`ThrottleWsu`,
				`b`.`SteerWsu`
		FROM `das1`.`DataFrontTargets` as a
        INNER JOIN `das1`.`DataWsuTemp` as b
			ON 	a.time = b.time AND
				a.Device = b.Device AND
                a.Trip = b.Trip
		WHERE 	a.Device = D AND
				a.Trip = Tr AND
				a.obstacleID = Ob AND
				a.Time BETWEEN Tbegin AND Tend
		ORDER BY Device, trip,time; 
        
        
        INSERT INTO cyclist
        SELECT 	`a`.`Device`,
				`a`.`Trip`,
				`a`.`Time`,
				`a`.`TargetId`,
				`a`.`ObstacleId`,
				`a`.`Range`,
				`a`.`Rangerate`,
				`a`.`Transversal`,
				`a`.`TargetType`,
				`a`.`Status`,
				`a`.`CIPV`,
				`b`.`GpsValidWsu`,
				`b`.`GpsTimeWsu`,
				`b`.`LatitudeWsu`,
				`b`.`LongitudeWsu`,
				`b`.`AltitudeWsu`,
				`b`.`GpsHeadingWsu`,
				`b`.`GpsSpeedWsu`,
				`b`.`HdopWsu`,
				`b`.`PdopWsu`,
				`b`.`FixQualityWsu`,
				`b`.`GpsCoastingWsu`,
				`b`.`ValidCanWsu`,
				`b`.`YawRateWsu`,
				`b`.`SpeedWsu`,
				`b`.`TurnSngRWsu`,
				`b`.`TurnSngLWsu`,
				`b`.`BrakeAbsTcsWsu`,
				`b`.`AxWsu`,
				`b`.`PrndlWsu`,
				`b`.`VsaActiveWsu`,
				`b`.`HeadlampWsu`,
				`b`.`WiperWsu`,
				`b`.`ThrottleWsu`,
				`b`.`SteerWsu`
		FROM `das1`.`DataFrontTargets` as a
        INNER JOIN `das1`.`DataWsuTemp` as b
			ON 	a.time = b.time AND
				a.Device = b.Device AND
                a.Trip = b.Trip
		WHERE 	a.Device = D AND
				a.Trip = Tr AND
				a.TargetID = 1 AND
				a.Time BETWEEN (Tend + 10) AND Tafter
		ORDER BY Device, trip,time; 
   /*     
        -- select before and after parts
        DROP TABLE IF EXISTS marginTab;
		CREATE TEMPORARY TABLE IF NOT EXISTS marginTab AS
        SELECT 	`a`.`Device`,
				`a`.`Trip`,
				`a`.`Time`,
				`a`.`TargetId`,
				`a`.`ObstacleId`,
				`a`.`Range`,
				`a`.`Rangerate`,
				`a`.`Transversal`,
				`a`.`TargetType`,
				`a`.`Status`,
				`a`.`CIPV`,
				`b`.`GpsValidWsu`,
				`b`.`GpsTimeWsu`,
				`b`.`LatitudeWsu`,
				`b`.`LongitudeWsu`,
				`b`.`AltitudeWsu`,
				`b`.`GpsHeadingWsu`,
				`b`.`GpsSpeedWsu`,
				`b`.`HdopWsu`,
				`b`.`PdopWsu`,
				`b`.`FixQualityWsu`,
				`b`.`GpsCoastingWsu`,
				`b`.`ValidCanWsu`,
				`b`.`YawRateWsu`,
				`b`.`SpeedWsu`,
				`b`.`TurnSngRWsu`,
				`b`.`TurnSngLWsu`,
				`b`.`BrakeAbsTcsWsu`,
				`b`.`AxWsu`,
				`b`.`PrndlWsu`,
				`b`.`VsaActiveWsu`,
				`b`.`HeadlampWsu`,
				`b`.`WiperWsu`,
				`b`.`ThrottleWsu`,
				`b`.`SteerWsu`
		FROM `das1`.`DataFrontTargets` as a
        RIGHT JOIN `das1`.`DataWsuTemp` as b
			ON 	a.time = b.time AND
				a.Device = b.Device AND
                a.Trip = b.Trip
		WHERE 	a.Device = D AND
				a.Trip = Tr AND
                a.obstacleID = Ob AND
                a.Time BETWEEN Tbegin AND Tend;       
       
		INSERT INTO `das1`.`cyclist`
        SELECT DISTINCT * FROM tempTab ORDER BY Device,Trip,Time;
        */
    END WHILE;
 
    CLOSE cur1;
 
END