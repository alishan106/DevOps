trigger AccountCheckbox on Account (after insert,after update) {
    if( trigger.isInsert){
        System.debug('execute');
        
            AccountHandler.countContact(trigger.newMap);
        
    }    
}