trigger OpportunityProductTrigger on OpportunityProduct__c (before insert, before update){
    
    if(OpportunityProductTriggerHelper.isFirst){
       OpportunityProductTriggerHelper.isFirst = false;
        if(Trigger.isInsert){
            OpportunityProductTriggerHelper.setPrimaryProductAtInsert(Trigger.new);
        }
        if(Trigger.isUpdate ){
            List<OpportunityProduct__c> filteredList = new List<OpportunityProduct__c>();
            for(OpportunityProduct__c obj : Trigger.new){
                OpportunityProduct__c oldObj = Trigger.oldMap.get(obj.Id);
                if(obj.Primary_Product__c != oldObj.Primary_Product__c){
                    filteredList.add(obj);
                }
                if(filteredList.size() > 0){
                     OpportunityProductTriggerHelper.setPrimaryProductAtUpdate (filteredList);
                }
            }
        }
    }    
}