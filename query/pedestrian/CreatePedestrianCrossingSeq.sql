Drop table if exists pedestrianCrossingSeq;
Create table pedestrianCrossingSeq(
eventNum	int,
Device	smallint,
Trip	smallint,
`Time`	int,
TargetId	tinyint,
ObstacleId	tinyint,
`Range`	double,
Rangerate	double,
Transversal	double,
TargetType	tinyint,
`Status`	tinyint,
CIPV	tinyint,
GpsValidWsu	tinyint,
GpsTimeWsu	bigint,
LatitudeWsu	double,
LongitudeWsu	double,
AltitudeWsu	double,
GpsHeadingWsu	double,
GpsSpeedWsu	double,
HdopWsu	double,
PdopWsu	double,
FixQualityWsu	tinyint,
GpsCoastingWsu	tinyint,
ValidCanWsu	tinyint,
YawRateWsu	double,
SpeedWsu	double,
TurnSngRWsu	tinyint,
TurnSngLWsu	tinyint,
BrakeAbsTcsWsu	tinyint,
AxWsu	double,
PrndlWsu	tinyint,
VsaActiveWsu	tinyint,
HeadlampWsu	tinyint,
WiperWsu	tinyint,
ThrottleWsu	double,
SteerWsu	double);

SET @num := 0;    
SET @Device := 0;
SET @Trip := 0;
SET @ObstacleID := 0;
INSERT INTO pedestrianCrossingSeq
SELECT
	@num := if(@Device = w.Device and @Trip = w.Trip and @ObstacleID = f.ObstacleId, @num, @num + 1),
	@Device := w.Device	,
	@Trip := w.Trip	,
	w.Time	,	
	f.TargetId	,
	@ObstacleID := f.ObstacleId	,
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
FROM das1.DataFrontTargets as f
join das1.DataWsu as w
on f.device = w.device and
	f.trip = w.trip and
    f.time = w.time
where f.TargetId = 1 and 
	f.TargetType = 3
    -- min(SpeedWsu) < 3
group by f.device,f.trip,f.TargetID,f.ObstacleId
having min(SpeedWsu) < 3
order by f.device,f.trip,f.TargetID,f.ObstacleId;