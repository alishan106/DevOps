trigger OpportunityAccountTrigger on Opportunity (before insert) {
    List<Opportunity> opportunityList = Trigger.new;
    Set<Id> accountId = new Set<Id>();
    Map<Id,Account> accountMap;    
    for(Opportunity opp : opportunityList){
        if(opp.AccountId != Null){
            accountId.add(opp.AccountId);
        }
    }
    accountMap = new Map<Id,Account>([SELECT Id, Account_Type__c FROM Account WHERE Id in : accountId]);
    //System.debug('Id----'+accountId);
    //System.debug('Map----'+accountMap);
    for(Opportunity opp : opportunityList){
        if(opp.AccountId != Null){
            Account acc = accountMap.get(opp.AccountId);
            if(acc.Account_Type__c == 'Reseller'){
                opp.Stage_Type__c  = '10';
            }else if(acc.Account_Type__c == 'Buyer'){
                opp.Stage_Type__c  = '25';
            }else if(acc.Account_Type__c == 'Current Customer'){
                opp.Stage_Type__c  = '100';
            }else{
                opp.Stage_Type__c = '0';
            }
        }
    }  
}