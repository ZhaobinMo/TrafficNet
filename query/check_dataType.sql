set @num := 0;
select 
@num:=@num+1 as num,
column_name, 
data_type 
from information_schema.columns where table_name = 'CarFollowingSeq';-- cyclistTimeInterval10s