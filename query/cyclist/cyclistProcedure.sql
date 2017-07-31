CREATE DEFINER=`dev`@`%` PROCEDURE `cyclistSeq5sBefAft`()
BEGIN
	
	DECLARE D ,T smallint;
	DECLARE B, BB, E, EE, N int;
	DECLARE TID, OID tinyint;
    DECLARE row_not_found boolean default FALSE;

    DECLARE cur CURSOR FOR 
	SELECT `cyclistevents`.`device`,
		`cyclistevents`.`trip`,
		`cyclistevents`.`TargetID`,
		`cyclistevents`.`ObstacleId`,
		`cyclistevents`.`endCyclistTime`,
		`cyclistevents`.`beginCyclistTime`
	FROM `das1`.`cyclistevents`
    ORDER BY device, trip, TargetID, ObstacleId, beginCyclistTime;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
		SET row_not_found = TRUE;

    OPEN cur;
    
    WHILE row_not_found = FALSE DO
        
        FETCH cur INTO D, T, TID, OID, E, B;
		SET EE = E + 200;
		SET BB = B - 200 ;
		SET N = N + 1;


		INSERT INTO cyclistSeq5s(
			eventNum ,
			Device	,
			Trip	,
			`Time`	,
			TargetId	,
			ObstacleId	,
			`Range`	,
			Rangerate	,
			Transversal	,
			TargetType	,
			`Status`	,
			CIPV	,
			GpsValidWsu	,
			GpsTimeWsu	,
			LatitudeWsu	,
			LongitudeWsu	,
			AltitudeWsu	,
			GpsHeadingWsu	,
			GpsSpeedWsu	,
			HdopWsu	,
			PdopWsu	,
			FixQualityWsu	,
			GpsCoastingWsu	,
			ValidCanWsu	,
			YawRateWsu	,
			SpeedWsu	,
			TurnSngRWsu	,
			TurnSngLWsu	,
			BrakeAbsTcsWsu	,
			AxWsu	,
			PrndlWsu	,
			VsaActiveWsu	,
			HeadlampWsu	,
			WiperWsu	,
			ThrottleWsu	,
			SteerWsu	)
		SELECT	
			N as num ,
			w.Device	,
			w.Trip	,
			w.Time	,	
			f.TargetId	,
			f.ObstacleId	,
			f.Range	,
			f.Rangerate	,
			f.Transversal	,
			f.TargetType	,
			f.Status	,
			f.CIPV	,
			w.GpsValidWsu	,
			w.GpsTimeWsu	,
			w.LatitudeWsu	,
			w.LongitudeWsu	,
			w.AltitudeWsu	,
			w.GpsHeadingWsu	,
			w.GpsSpeedWsu	,
			w.HdopWsu	,
			w.PdopWsu	,
			w.FixQualityWsu	,
			w.GpsCoastingWsu	,
			w.ValidCanWsu	,
			w.YawRateWsu	,
			w.SpeedWsu	,
			w.TurnSngRWsu	,
			w.TurnSngLWsu	,
			w.BrakeAbsTcsWsu	,
			w.AxWsu	,
			w.PrndlWsu	,
			w.VsaActiveWsu	,
			w.HeadlampWsu	,
			w.WiperWsu	,
			w.ThrottleWsu	,
			w.SteerWsu
		FROM
			(
			select * 
			from DataFrontTargets
			where	Device = D and
					Trip = T and
					Time between B and E	and	
					ObstacleID = OID and 
					TargetID = TID
			)	as f
		RIGHT JOIN 
			(
			SELECT * 
			FROM DataWsu  
			WHERE	Device = D and
					Trip = T and
					Time between BB and EE
			)	as w 
		ON	f.Device = w.device and 
			f.Trip = w.Trip and
			f.Time = w.Time
		ORDER BY	w.Device, w.Trip, w.Time;
    END WHILE;
 
    CLOSE cur;
 
END