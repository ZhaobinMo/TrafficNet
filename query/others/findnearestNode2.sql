select
	c.device,
	c.trip,
	c.time,
	c.latitudeWsu,
	c.longitudeWsu,
	c.NodeID,
	c.Latitude,
	c.longitude,
	c.distance
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
		SQRT(POW(a.LatitudeWsu-b.Latitude,2)+POW(a.LongitudeWsu-b.Longitude,2))  as distance
		From 
		(
			select * from DataWsu
			where trip = 70
            limit 1000
		) as a
		join
		(
			select * from interNodeLatLon2
		) as b
	) as c
join
	(
		select 
			g.device,
			g.trip,
			g.time,
			min(g.distance) as mindistance
		from
			(
						
				SELECT 
					e.device as device,
					e.Trip as trip,
					e.time as time,
					e.LatitudeWsu as latitudeWsu,
					e.LongitudeWsu as longitudeWsu,
					f.NodeID as NodeID,
					f.Latitude as Latitude,
					f.Longitude as longitude,
					SQRT(POW(e.LatitudeWsu-f.Latitude,2)+POW(e.LongitudeWsu-f.Longitude,2))  as distance
				From 
					(
						select * from DataWsu
						where trip = 70
						limit 1000
					) as e
				join
					(
						select * from interNodeLatLon2
					) as f
						 
				
			) as g
			group by g.device,g.trip,g.time
	) as d
on c.device = d.device and c.trip = d.trip and c.time = d.time and c.distance = d.mindistance
-- having c.distance = min(c.distance);