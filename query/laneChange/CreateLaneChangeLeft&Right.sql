-- ------------------------- left lane change
drop table if exists laneChageLeft;
create table laneChangeLeft as 
SELECT  DISTINCT 
	l.device,
    l.trip,
    l.time
FROM    
	(
	SELECT `a`.`Device`,
		`a`.`Trip`,
		`a`.`Time`,
		`a`.`LaneDistanceLeft` - `b`.`LaneDistanceLeft` as leftShift
	FROM `das1`.`DataLane` as a
    JOIN `das1`.`DataLane` as b
		ON a.device = b.device and 
			a.trip = b.trip and 
			a.time = b.time + 10
	WHERE abs(`a`.`LaneDistanceLeft` - `b`.`LaneDistanceLeft`) BETWEEN 2 AND 4 AND
		a.LaneQualityLeft > 1 AND 
        b.LaneQualityLeft > 1
	) as l
JOIN
	(
	SELECT `a`.`Device`,
		`a`.`Trip`,
		`a`.`Time`,
		`a`.`LaneDistanceRight` - `b`.`LaneDistanceRight` as rightShift
	FROM `das1`.`DataLane` as a
    JOIN `das1`.`DataLane` as b
		ON a.device = b.device and 
			a.trip = b.trip and 
			a.time = b.time + 10
	WHERE abs(`a`.`LaneDistanceRight` - `b`.`LaneDistanceRight`) BETWEEN 2 AND 4 AND
		a.LaneQualityRight > 1 AND 
        b.LaneQualityRight > 1
	) as r
    ON l.device = r.device and 
		l.trip = r.trip and 
        l.time between r.time - 100 and r.time + 100
WHERE l.leftShift < 0 AND
	r.rightShift < 0;
-- ---------------------------  right Lane Change  
drop table if exists laneChageRight;
create table laneChangeRight as 
SELECT  DISTINCT 
	l.device,
    l.trip,
    l.time
FROM    
	(
	SELECT `a`.`Device`,
		`a`.`Trip`,
		`a`.`Time`,
		`a`.`LaneDistanceLeft` - `b`.`LaneDistanceLeft` as leftShift
	FROM `das1`.`DataLane` as a
    JOIN `das1`.`DataLane` as b
		ON a.device = b.device and 
			a.trip = b.trip and 
			a.time = b.time + 10
	WHERE abs(`a`.`LaneDistanceLeft` - `b`.`LaneDistanceLeft`) BETWEEN 2 AND 4 AND
		a.LaneQualityLeft > 1 AND 
        b.LaneQualityLeft > 1
	) as l
JOIN
	(
	SELECT `a`.`Device`,
		`a`.`Trip`,
		`a`.`Time`,
		`a`.`LaneDistanceRight` - `b`.`LaneDistanceRight` as rightShift
	FROM `das1`.`DataLane` as a
    JOIN `das1`.`DataLane` as b
		ON a.device = b.device and 
			a.trip = b.trip and 
			a.time = b.time + 10
	WHERE abs(`a`.`LaneDistanceRight` - `b`.`LaneDistanceRight`) BETWEEN 2 AND 4 AND
		a.LaneQualityRight > 1 AND 
        b.LaneQualityRight > 1
	) as r
    ON l.device = r.device and 
		l.trip = r.trip and 
        l.time between r.time - 100 and r.time + 100
WHERE l.leftShift > 0 AND
	r.rightShift > 0;
alter table laneChangeRight add primary key (device,trip,time);
alter table laneChangeLeft add primary key (device,trip,time);
