function Data = SQLQuery_Ding(DBName,Server,Query)
% DBName = 'SP_Ding';
% Server = 'Tri-spdb1';
% a='select Latitude,Longitude,Heading from [tri-spdb2].spwsubsm.dbo.BsmP1 where Gentime between ';
% b=' and ';
% c=' and Latitude between 42.2197 and 42.3279 and Longitude between -83.8074 and -83.6701 and Heading<>0 and Heading<>360 ';
% query=[a,num2str(i_time),b,num2str(last_t),c];
% LDEvent=SQLQuery_Ding(DBName,Server,query);

persistent conn
if  isempty(conn) || strcmp(conn.instance,DBName)==0
    conn = database(DBName,'','',...
        'Vendor','Microsoft SQL Server','Server',Server,...
        'AuthType','Windows','portnumber',1433);
else
    ping(conn);
end
datatype = 'table';
setdbprefs('DataReturnFormat',datatype);
curs = exec(conn,Query);
curs=fetch(curs);
temp = curs.Data;
if strcmp(temp,'No Data')==1
    Data = [];
    Data=table(Data);
else
        Data = temp;
end

