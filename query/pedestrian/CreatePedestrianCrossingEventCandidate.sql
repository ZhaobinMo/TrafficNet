-- select events with minimum speed less than so could be the scenario of pedestrian crossing.
-- try with CIPV
drop table if exists PedestrianCrossingEventCandidate;
Create table PedestrianCrossingEventCandidate as 
select * 
from
	(
	select 
		device,
		trip,
		min(time) as beginTime,
		max(Time) as endTime,
		min(speedWsu) as minSpeedWsu
	from pedestrianSeq
	group by eventNum,device,trip
	order by device,trip,time
	) as a 
where a.minSpeedWsu<3;