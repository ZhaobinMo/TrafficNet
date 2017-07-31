drop table if exists FreeFlowEvents;
create table FreeFlowEvents as 
select * 
from FreeFlowSeq
group by eventNum, device, trip;