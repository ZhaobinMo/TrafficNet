drop table if exists GPScutIn;
create table GPScutIn as 
select
	w.LatitudeWsu,
    w.LongitudeWsu
from CutInEvents as c
join DataWsu as w
on c.device = w.device and
	c.trip = w.trip and
    c.time = w.time;

drop table if exists GPSCarFollowingEvents;
create table GPSCarFollowingEvents as 
select
	w.LatitudeWsu,
    w.LongitudeWsu
from CarFollowingEvents as c
join DataWsu as w
on c.device = w.device and
	c.trip = w.trip and
    c.startTime = w.time;
    
drop table if exists GPScyclistevents;
create table GPScyclistevents as 
select
	w.LatitudeWsu,
    w.LongitudeWsu
from `cyclistevents` as c
join DataWsu as w
on c.device = w.device and
	c.trip = w.trip and
    c.`beginCyclistTime` = w.time;
    

drop table if exists GPSFreeFlowEvents;
create table GPSFreeFlowEvents as 
select
	w.LatitudeWsu,
    w.LongitudeWsu
from `FreeFlowEvents` as c
join DataWsu as w
on c.device = w.device and
	c.trip = w.trip and
    c.`time` = w.time;



drop table if exists GPSlaneChangeLeft;
create table `GPSlaneChangeLeft` as 
select
	w.LatitudeWsu,
    w.LongitudeWsu
from `laneChangeLeft` as c
join DataWsu as w
on c.device = w.device and
	c.trip = w.trip and
    c.`time` = w.time;

drop table if exists GPSlaneChangeRight;
create table `GPSlaneChangeRight` as 
select
	w.LatitudeWsu,
    w.LongitudeWsu
from `laneChangeRight` as c
join DataWsu as w
on c.device = w.device and
	c.trip = w.trip and
    c.`time` = w.time;


drop table if exists GPSPedestrianCrossingEventCandidate;
create table `GPSPedestrianCrossingEventCandidate` as 
select
	w.LatitudeWsu,
    w.LongitudeWsu
from `PedestrianCrossingEventCandidate` as c
join DataWsu as w
on c.device = w.device and
	c.trip = w.trip and
    c.`beginTime` = w.time;












