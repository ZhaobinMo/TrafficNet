
drop table if exists DataWsuContinue;
create table DataWsuContinue
select 	a.device,
		a.trip,
        min(a.time) as startTime,
		max(a.time) as endTime
from        
	(
	select 	device,
			trip,
			time,
			time - 10*(@rownum := @rownum + 1) as con
			
	from DataWsu t,
	(select @rownum := 0) r
	order by device,trip,time
	) as a
group by a.device,a.trip,a.con;
        
drop table if exists DataLaneContinue;
create table DataLaneContinue
select 	`a`.`﻿Device`,
		a.trip,
        min(a.time) as startTime,
		max(a.time) as endTime
from        
	(
	select 	`t`.`﻿Device`,
			trip,
			time,
			time - 10*(@rownum := @rownum + 1) as con
			
	from DataLane t,
	(select @rownum := 0) r
	order by `t`.`﻿Device`,trip,time
	) as a
group by `a`.`﻿Device`,a.trip,a.con;