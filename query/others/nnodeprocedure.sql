CREATE DEFINER=`dev`@`%` PROCEDURE `WsuWithNearestNode`()
BEGIN
	Declare TDevice	smallint;
	Declare TTrip	smallint;
	Declare TTime	int;
	Declare TGpsValidWsu	tinyint;
	Declare TGpsTimeWsu	bigint;
	Declare TLatitudeWsu	float;
	Declare TLongitudeWsu	float;
	Declare TAltitudeWsu	double;
	Declare TGpsHeadingWsu	double;
	Declare TGpsSpeedWsu	double;
	Declare THdopWsu	double;
	Declare TPdopWsu	double;
	Declare TFixQualityWsu	tinyint;
	Declare TGpsCoastingWsu	tinyint;
	Declare TValidCanWsu	tinyint;
	Declare TYawRateWsu	double;
	Declare TSpeedWsu	double;
	Declare TTurnSngRWsu	tinyint;
	Declare TTurnSngLWsu	tinyint;
	Declare TBrakeAbsTcsWsu	tinyint;
	Declare TAxWsu	double;
	Declare TPrndlWsu	tinyint;
	Declare TVsaActiveWsu	tinyint;
	Declare THeadlampWsu	tinyint;
	Declare TWiperWsu	tinyint;
	Declare TThrottleWsu	double;
	Declare TSteerWsu	double;
	Declare Tcon	int;
    Declare TNNode int;
    Declare TNLat,TNlon double;
    
    DECLARE row_not_found tinyint default FALSE;
    DECLARE cur1 CURSOR FOR 
		SELECT `DataWsu`.`Device`,
			`DataWsu`.`Trip`,
			`DataWsu`.`Time`,
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
			`DataWsu`.`SteerWsu`,
			`DataWsu`.`con`
		FROM `das1`.`DataWsu`;
    
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET row_not_found = TRUE;
    OPEN cur1;

    
    WHILE row_not_found = FALSE DO
        
        FETCH cur1 INTO  
			TDevice,
			TTrip,
			TTime,
			TGpsValidWsu,
			TGpsTimeWsu,
			TLatitudeWsu,
			TLongitudeWsu,
			TAltitudeWsu,
			TGpsHeadingWsu,
			TGpsSpeedWsu,
			THdopWsu,
			TPdopWsu,
			TFixQualityWsu,
			TGpsCoastingWsu,
			TValidCanWsu,
			TYawRateWsu,
			TSpeedWsu,
			TTurnSngRWsu,
			TTurnSngLWsu,
			TBrakeAbsTcsWsu,
			TAxWsu,
			TPrndlWsu,
			TVsaActiveWsu,
			THeadlampWsu,
			TWiperWsu,
			TThrottleWsu,
			TSteerWsu,
			Tcon;
        SELECT 	TNNode = NodeID,
				TNLat = Latitude,
                TNlon = Longitude
        From `das1`.`IntersecNode`
        order by (POW(TLatitudeWsu-Latitude,2)+POW(TLongitudeWsu-Longitude,2)) ASC
		LIMIT 1;
        
        INSERT INTO `DataWsuNNode`
		SELECT 
			TDevice,
			TTrip,
			TTime,
			TGpsValidWsu,
			TGpsTimeWsu,
			TLatitudeWsu,
			TLongitudeWsu,
			TAltitudeWsu,
			TGpsHeadingWsu,
			TGpsSpeedWsu,
			THdopWsu,
			TPdopWsu,
			TFixQualityWsu,
			TGpsCoastingWsu,
			TValidCanWsu,
			TYawRateWsu,
			TSpeedWsu,
			TTurnSngRWsu,
			TTurnSngLWsu,
			TBrakeAbsTcsWsu,
			TAxWsu,
			TPrndlWsu,
			TVsaActiveWsu,
			THeadlampWsu,
			TWiperWsu,
			TThrottleWsu,
			TSteerWsu,
			Tcon,
            TNNode,
            TNLat,
            TNlon;


    END WHILE;
 
    CLOSE cur1;
 
END