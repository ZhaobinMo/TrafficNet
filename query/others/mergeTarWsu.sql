Drop table if exists TarDTT;
Drop table if exists WsuDTT;


Create table TarDTT as
	select device,trip,time
	from DataFrontTargets 
	group by device,trip,time;
Create table WsuDTT as
	select device,trip,time
	from DataWsu
	group by device,trip,time;
    
    
Create table TarWsuUnion as
(
select a.device as Fdevice,
		a.trip as Ftrip,
        a.time as Ftime,
        b.device as Wdevice,
        b.trip as Wtrip,
        b.time as Wtime
from TarDTT as a
right join WsuDTT as b
on a.device = b.device and 
	a.trip = b.trip and 
    a.time = a.time

) union
(
select a.device as Fdevice,
		a.trip as Ftrip,
        a.time as Ftime,
        b.device as Wdevice,
        b.trip as Wtrip,
        b.time as Wtime
from TarDTT as a
left join WsuDTT as b
on a.device = b.device and 
	a.trip = b.trip and 
    a.time = a.time

) 