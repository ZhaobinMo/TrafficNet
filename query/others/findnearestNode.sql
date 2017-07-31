select
	device,
	trip,
	time,
	latitudeWsu,
	longitudeWsu,
	NodeID,
	Latitude,
	longitude,
	distance
from 
	(
		SELECT 
		a.device as device,
		a.Trip as trip,
		a.time as time,
		a.LatitudeWsu as latitudeWsu,
		a.LongitudeWsu as longitudeWsu,
		b.NodeID as NodeID,
		b.Latitude as Latitude,
		b.Longitude as longitude,
		ROW_NUMBER() OVER(PARTITION BY c.`device`,c.`trip`,c.`time` ORDER BY SQRT(POW(a.LatitudeWsu-b.Latitude,2)+POW(a.LongitudeWsu-b.Longitude,2)) ASC) AS rown,
		SQRT(POW(a.LatitudeWsu-b.Latitude,2)+POW(a.LongitudeWsu-b.Longitude,2))  as distance
		From 
		(
			select * from DataWsu
			limit 100
		) as a
		join
		(
			select * from interNodeLatLon2
		) as b
	) as c
    
where rown = 1
group by c.device,c.trip,c.time;