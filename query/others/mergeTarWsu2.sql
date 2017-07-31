Create table TarOuterJoinWsu as
select * from TarRightJoinWsu
union
select * from TarLeftJoinWsu;