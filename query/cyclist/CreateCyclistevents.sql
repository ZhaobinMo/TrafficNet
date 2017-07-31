DROP TABLE IF EXISTS cyclistevents;

create table cyclistevents as
select
	device,
	trip,
	TargetID,
	ObstacleId,
	max(time) as endCyclistTime, 
	min(time) as beginCyclistTime,
	count(*) as cyclistDuration
from DataFrontTargets
where	TargetType = 4 and 
		targetID = 1
group by device,trip,TargetID,ObstacleId;
ALTER TABLE cyclistevents ADD primary key (device, trip, targetID, beginCyclistTime);