CREATE  PROCEDURE `WsuWithNearestNodeShorter`()
BEGIN
	Declare TDevice	smallint;
	Declare TTrip	smallint;
	Declare TTime	int;
	Declare TLatitudeWsu	float;
	Declare TLongitudeWsu	float;
	Declare Tcon	int;
    Declare TNNode int;
    Declare TNLat,TNlon double;
    
    DECLARE row_not_found tinyint default FALSE;
    DECLARE cur1 CURSOR FOR 
		SELECT `DataWsu`.`Device`,
			`DataWsu`.`Trip`,
			`DataWsu`.`Time`,
			`DataWsu`.`LatitudeWsu`,
			`DataWsu`.`LongitudeWsu`,
		FROM `das1`.`DataWsu`;
    
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET row_not_found = TRUE;
    OPEN cur1;

    
    WHILE row_not_found = FALSE DO
        
        FETCH cur1 INTO  
			TDevice,
			TTrip,
			TTime,
			TLatitudeWsu,
			TLongitudeWsu;


			NodeID as TNNode,
            Latitude as TNLat,
            Longitude as TNlon
		from `das1`.`IntersecNode`
		order by (POW(TLatitudeWsu-Latitude,2)+POW(TLongitudeWsu-Longitude,2)) ASC
		LIMIT 1;
        
        
		Update table DataWsu
        set NearestNode = TNNode,
			NNodeLat = TNLat,
            NNodeLon = TNlon
		where 	Device = TDevice and 
				Trip = TTrip and 
                Time = TTime;


    END WHILE;
 
    CLOSE cur1;
 
END