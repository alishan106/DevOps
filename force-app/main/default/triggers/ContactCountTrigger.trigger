trigger ContactCountTrigger on Contact (after insert) {
    if(Trigger.isAfter ){
       // if(Trigger.isInsert)
     
            //AccountHandler.checkContactCountOnAccount(Trigger.New);
        
    }
}