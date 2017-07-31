DROP TABLE IF exists CarFollowingSeq;
CREATE TABLE CarFollowingSeq as
SELECT *
FROM DataFrontTargets
WHERE 	CIPV = 1 AND
		TargetType = 0
ORDER BY device,trip,obstacleID,time;


