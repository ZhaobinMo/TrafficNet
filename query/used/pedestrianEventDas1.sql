-- fetch the time interval of pedestrian event, which contains the trip interval to check +-1min interval 
set @beforetime = 0;
set @aftertime = 0;
-- CREATE TABLE test.pedestrianEventTimeInterval1min as
DROP TABLE IF exists pedestrianTimeInterval10s;
create table pedestrianTimeInterval10s as
select 	a.Device,
    a.Trip,
    a.Time,
    a.TargetId,
    a.ObstacleId,
    a.beginpedestrianTime,
    a.endpedestrianTime,
    a.pedestrianDuration,
    b.beginTripTime,
    b.endTripTime,
    b.tripDuration,
    CONVERT(abs((a.beginpedestrianTime - @beforetime + b.beginTripTime)/2) + abs((a.beginpedestrianTime - @beforetime - b.beginTripTime)/2),SIGNED) as beforepedestrianTime ,
    CONVERT(abs((a.endpedestrianTime + @aftertime + b.endTripTime)/2) - abs((a.endpedestrianTime + @aftertime - b.endTripTime)/2),SIGNED) as afterpedestrianTime
from
	(
	select *,max(time) as endpedestrianTime, min(time) as beginpedestrianTime,count(*) as pedestrianDuration
	from DataFrontTargets
	where TargetType = 3
	group by device,trip,ObstacleId
	order by device,trip
	-- limit 1000
	) as a
join
	(
	select *,max(time) as endTripTime, min(time) as beginTripTime,count(*) as tripDuration
	from DataFrontTargets
	group by device,trip
	order by device,trip
	-- limit 10000
	) as b
on 	a.device = b.device and
	a.trip = b.trip
-- group by device,trip
order by device,trip