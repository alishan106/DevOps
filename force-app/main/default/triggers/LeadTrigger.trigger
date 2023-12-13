trigger LeadTrigger on Lead(before insert, before update){ 
    Lead[] ld= Trigger.new;
    if(trigger.isInsert && trigger.isBefore ){
        
        for(Lead l: ld){
            l.LastName = 'DR '  + l.LastName;
        }
    }
    
    if(trigger.isUpdate && trigger.isBefore ){
        
        for(Lead l: ld){
            l.LastName = 'ER '  + l.LastName;
        }
        
    }
}