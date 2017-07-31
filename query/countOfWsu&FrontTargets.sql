select COUNT(*) from DataWsu; -- 79489633
select COUNT(*) from 
(select distinct device,trip,time from DataFrontTargets) as fd; -- 48062120
select COUNT(*) from FreeFlowSeq; -- 39523277
select COUNT(*) from cyclistSeq5s; -- 1351737
select count(*) from DataLane; -- 86263013