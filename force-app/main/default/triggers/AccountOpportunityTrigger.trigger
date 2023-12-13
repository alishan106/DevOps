trigger AccountOpportunityTrigger on Account (after update) {
    List<Account> accountList = Trigger.new;
    List<Opportunity> opportunityList = New List<Opportunity>();
    Set<Id> AccountId = New Set<Id>();
    Map<Id, Account> accountMap = Trigger.newMap;
    for(Account acc : accountList){
        accountId.add(acc.Id);
    }
    opportunityList = [Select Id, AccountId, stage_type__c from Opportunity where accountId in : accountId];
    for(Opportunity opp : opportunityList){
        Account accObj = accountMap.get(opp.AccountId);
        if(accObj.Account_Type__c != NULL){
            if(accObj.Account_Type__c == 'Reseller'){
                opp.Stage_Type__c = '10';
            }else if(accObj.Account_Type__c == 'Buyer'){
                opp.Stage_Type__c = '25';
            }else if(accObj.Account_Type__c == 'Current Customer'){
                opp.Stage_Type__c = '100';
            }
        }
        else{
            opp.Stage_Type__c = '0';
        }
    }
    update opportunityList;  
}