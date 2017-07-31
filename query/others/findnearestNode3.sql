SELECT Device,Trip,startTime,endTime
INTO
    @D, @Tr, @BT, @ET  
FROM
    DataWsuContinue
LIMIT 1;
SELECT @D, @Tr, @BT, @ET;  
call WsuWithNearestNode2(@D,@Tr,@BT,@ET)