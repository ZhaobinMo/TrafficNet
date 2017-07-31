-- create the table for the time when left/right side of the car pass the line 
-- when change to the left lane

Drop table if exists LaneChangeEventLeft;  
Create table LaneChangeEventLeft as  
SELECT 	l.device,
		l.trip,
        l.startTime,
        l.leftWheelPassTime,
        r.rightWheelPassTime
FROM
	( -- left side
	SELECT 	a.device,
			a.trip,
			a.startTime,
			min(a.time) as leftWheelPassTime
	FROM	
			(
			SELECT 	c.device,
					c.trip,
					c.time as startTime,
					d.time,
					d.lanedistanceleft + 0.91 as value
			FROM	das1.DataLane as d
			JOIN	das1.laneChangeLeft as c
				ON 	c.device = d.device and
					c.trip = d.trip and 
					d.time between c.time - 1000 and c.time
			WHERE 	d.lanequalityleft IN (2,3) and 
					d.lanedistanceleft + 0.91 > 0 
			) as a
			GROUP BY a.device, a.trip, a.startTime
	) as l
JOIN
	( -- right side
	SELECT 	a.device,
			a.trip,
			a.startTime,
			max(a.time) as rightWheelPassTime
	FROM	
			(
			SELECT 	c.device,
					c.trip,
					c.time as startTime,
					d.time,
					d.lanedistanceright - 0.91 as value
			FROM	das1.DataLane as d
			JOIN	das1.laneChangeLeft as c
				ON 	c.device = d.device and
					c.trip = d.trip and 
					d.time between c.time and c.time + 1000
			WHERE 	d.lanequalityright IN (2,3) and 
					d.lanedistanceright - 0.91 < 0 
			) as a
			GROUP BY a.device, a.trip, a.startTime
	) as r
    ON 	l.device = r.device and
		l.trip = r.trip and 
        l.startTime = r.startTime ;
Alter table LaneChangeEventLeft add primary key (device,trip,startTime);
        
        
        
Drop table if exists LaneChangeEventRight;  
Create table LaneChangeEventRight as  
SELECT 	l.device,
		l.trip,
        l.startTime,
        l.rightWheelPassTime,
        r.leftWheelPassTime
FROM
	( -- left side
	SELECT 	a.device,
			a.trip,
			a.startTime,
			max(a.time) as leftWheelPassTime
	FROM	
			(
			SELECT 	c.device,
					c.trip,
					c.time as startTime,
					d.time,
					d.lanedistanceleft + 0.91 as value
			FROM	das1.DataLane as d
			JOIN	das1.laneChangeLeft as c
				ON 	c.device = d.device and
					c.trip = d.trip and 
					d.time between c.time and c.time + 1000
			WHERE 	d.lanequalityleft IN (2,3) and 
					d.lanedistanceleft + 0.91 > 0 
			) as a
			GROUP BY a.device, a.trip, a.startTime
	) as l
JOIN
	( -- right side
	SELECT 	a.device,
			a.trip,
			a.startTime,
			min(a.time) as rightWheelPassTime
	FROM	
			(
			SELECT 	c.device,
					c.trip,
					c.time as startTime,
					d.time,
					d.lanedistanceright - 0.91 as value
			FROM	das1.DataLane as d
			JOIN	das1.laneChangeLeft as c
				ON 	c.device = d.device and
					c.trip = d.trip and 
					d.time between c.time - 1000 and c.time
			WHERE 	d.lanequalityright IN (2,3) and 
					d.lanedistanceright - 0.91 < 0 
			) as a
			GROUP BY a.device, a.trip, a.startTime
	) as r
    ON 	l.device = r.device and
		l.trip = r.trip and 
        l.startTime = r.startTime ;
Alter table LaneChangeEventRight add primary key (device,trip,startTime);
    