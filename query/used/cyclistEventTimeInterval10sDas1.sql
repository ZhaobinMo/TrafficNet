-- fetch the time interval of cyclist event, which contains the trip interval to check +-1min interval 
set @beforetime = 1000;
set @aftertime = 1000;
-- CREATE TABLE test.cyclistEventTimeInterval1min as
DROP TABLE IF exists cyclistTimeInterval10s;
create table cyclistTimeInterval10s as
select 	a.Device,
    a.Trip,
    a.Time,
    a.TargetId,
    a.ObstacleId,
    a.beginCyclistTime,
    a.endCyclistTime,
    a.cyclistDuration,
    b.beginTripTime,
    b.endTripTime,
    b.tripDuration,
    CONVERT(abs((a.beginCyclistTime - @beforetime + b.beginTripTime)/2) + abs((a.beginCyclistTime - @beforetime - b.beginTripTime)/2),SIGNED) as beforeCyclistTime ,
    CONVERT(abs((a.endCyclistTime + @aftertime + b.endTripTime)/2) - abs((a.endCyclistTime + @aftertime - b.endTripTime)/2),SIGNED) as afterCyclistTime
from
	(
	select *,max(time) as endCyclistTime, min(time) as beginCyclistTime,count(*) as cyclistDuration
	from DataFrontTargets
	where TargetType = 4
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
order by device,trip;
ALTER TABLE cyclistTimeInterval10s
ADD primary key (Device,Trip,ObstacleId);
