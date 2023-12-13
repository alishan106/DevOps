trigger UpdatePhone on Account (before insert,after insert,before update,after update,before delete, after delete, after undelete) {
    if(Trigger.isBefore && Trigger.isInsert){
        for(Account acc : Trigger.New){
            System.debug('isBefore isInsert'+acc); 
            System.debug('isBefore isInsert'+Trigger.newMap); 
        }
    }
    /*
    if(Trigger.isAfter && Trigger.isInsert){
        for(Account acc : Trigger.New){
            System.debug('isAfter isInsert'+acc);
            System.debug('isBefore isInsert'+Trigger.newMap); 
            
        }
    }
    if(Trigger.isBefore && Trigger.isupdate){
        for(Account acc : Trigger.New){
            System.debug('isAfter isupdate'+acc); 
        }
        for(Account acc : Trigger.old){
            System.debug('isAfter isupdate old'+acc); 
        }
        System.debug('isBefore isInsert'+Trigger.oldMap); 
    }
    if(Trigger.isAfter && Trigger.isupdate){
        for(Account acc : Trigger.new){
            System.debug('isAfter isupdate'+acc); 
        }
        for(Account acc : Trigger.old){
            System.debug('isAfter isupdate old'+acc); 
        }
        System.debug('isBefore isInsert'+Trigger.oldMap); 
    }
*/
}