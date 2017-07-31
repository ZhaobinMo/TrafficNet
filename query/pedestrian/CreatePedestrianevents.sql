DROP TABLE IF EXISTS pedestrianEvents;

set @num := 0;
create table pedestrianEvents as
select
	@num := @num + 1 as Num,
	device,
	trip,
	TargetID,
	ObstacleId,
	max(time) as endPedestrianTime, 
	min(time) as beginPedestrianTime,
	count(*) as PedestrianDuration
from DataFrontTargets
where	TargetType = 3 and 
		targetID = 1
group by device,trip,TargetID,ObstacleId;
ALTER TABLE pedestrianEvents ADD primary key (Num, device, trip, targetID, beginPedestrianTime);