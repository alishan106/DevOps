trigger UpdateAccount on Opportunity (after insert, before insert, after update, before update,after delete, before delete, after undelete) {
    if(Trigger.isInsert && Trigger.isBefore){
        UpdateAccountHandler.beforeInsert(Trigger.new);
    }
    if(Trigger.isInsert && Trigger.isAfter){
        UpdateAccountHandler.afterInsert(Trigger.New,Trigger.newMap);
    }
    if(Trigger.isUpdate && Trigger.isBefore){
        UpdateAccountHandler.beforeUpdate(Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap);
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        UpdateAccountHandler.afterUpdate(Trigger.new, Trigger.newMap,Trigger.old, Trigger.oldMap);
    }
    if(Trigger.isDelete && Trigger.isBefore){
        UpdateAccountHandler.beforeDelete(Trigger.new,Trigger.newMap);
    }
    if(Trigger.isDelete && Trigger.isAfter){
        UpdateAccountHandler.afterDelete(Trigger.new,Trigger.newMap);
    }
    if(Trigger.isUnDelete && Trigger.isAfter){
        UpdateAccountHandler.afterUndelete(Trigger.new,Trigger.newMap);
    }
    
    
    /*
Set<Id> AccountIds = new Set<Id>();
for(Opportunity opp : Trigger.New){
if(opp.AccountId != NULL && opp.StageName == 'Closed Won'){
AccountIds.add(opp.AccountId);
}
}
List<Account> accall = [Select id, rating from Account where id IN : AccountIds];
List<Account> accList = new List<Account>();
for(Account ids : accall){
Account acc = new Account();
acc.rating = 'Hot';
acc.Id = ids.Id;
accList.add(acc);
}
update accList;
*/
}