DROP TABLE IF EXISTS cyclist;

CREATE TABLE cyclist
(
Device	smallint,
Trip	smallint,
Time	int,
TargetId	tinyint,
ObstacleId	tinyint,
`Range`	double,
Rangerate	double,
Transversal	double,
TargetType	tinyint,
Status	tinyint,
CIPV	tinyint,
GpsValidWsu	tinyint,
GpsTimeWsu	bigint,
LatitudeWsu	float,
LongitudeWsu	float,
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
SteerWsu	double
);

CALL cyclist2; 
-- ALTER TABLE cyclist
-- ADD PRIMARY KEY (device,trip,time,obstacleID);