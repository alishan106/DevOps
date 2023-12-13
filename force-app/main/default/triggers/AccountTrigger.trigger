trigger AccountTrigger on Account (after update){
    Map<Id, String> accMap = new Map<Id, String>();
    Map<Id, Account> oldMap = trigger.oldMap;
    for(Account acc : trigger.New){
        if(acc.Name != oldMap.get(acc.Id).Name){
            accMap.put(acc.Id, acc.Name);
        }
    }
    System.debug('accMap'+accMap);
    List<Contact> conList = [SELECT Id, Name, AccountId FROM Contact WHERE AccountId IN : accMap.keySet()];
    for(Contact con : conList){
        if(accMap.containsKey(con.AccountId)){
                con.FirstName = accMap.get(con.AccountId); 
                System.debug('qwertyuiop');
                System.debug('con.FirstName => '+con.FirstName);
        }
    }
    if(conList.size() > 0){
        System.debug('qwertyuiop');
        UPDATE conList;
    }
}
/*trigger AccountTrigger on Account (before insert, before update, after insert, after update)
{
    List<Account> accountList = Trigger.new;
    List<Opportunity> opportunityList = new List<Opportunity>(); 
    List<Opportunity> accountopportunityList = new List<Opportunity>();
    Set<Id> accountIds = new Set<Id>();
    Map<Id,Account> oldAccountMap = Trigger.oldMap;
    if(Trigger.isUpdate)
    {
        for( Account account : accountList){
            Account oldAccount = oldAccountMap.get(account.id);
            if(oldAccount.Rating!=account.Rating)
            {                
                accountIds.add(account.Id);
            }
        }
        if(accountIds.size()>0){
            
            accountOpportunityList = [SELECT Id, DeliveryInstallationStatus__c from Opportunity where AccountId in : accountIds];
        }
    }
    for(Account act : accountList)
    {
        if(act.Billing_same_as_shipping__c == true && Trigger.isBefore)
        {
            act.ShippingStreet = act.BillingStreet;
            act.ShippingCity = act.BillingCity;
            act.ShippingState = act.BillingState;
            act.ShippingPostalCode = act.BillingPostalCode;
            act.ShippingCountry = act.BillingCountry;
        }
        else if(Trigger.isAfter && trigger.IsInsert)
        {
            Opportunity opp = new Opportunity(Name = act.Name, Discount__c=2, StageName = 'Closed Lost', CloseDate = Date.parse('3/15/2021'),AccountId = act.Id);
            if(act.Rating!=NULL)
            {
                if(act.Rating.equals('Hot'))
                {
                    opp.DeliveryInstallationStatus__c = 'In Progress';
                } 
                else if(act.Rating.equals('Warm'))
                {
                    opp.DeliveryInstallationStatus__c = 'Yet to begin';
                } 
                else if(act.Rating.equals('Cold'))
                {
                    opp.DeliveryInstallationStatus__c = 'Completed';
                }
                
            }
            opportunityList.add(opp);            
        }
        else if(Trigger.isAfter && trigger.IsUpdate)
        {
            
            Opportunity opp;
            if(accountOpportunityList.size()>0)
            {
                opp = accountOpportunityList.get(0);
                if(act.Rating!=NULL)
                {
                    if(act.Rating.equals('Hot'))
                    {
                        opp.DeliveryInstallationStatus__c = 'In Progress';
                    } 
                    else if(act.Rating.equals('Warm'))
                    {
                        opp.DeliveryInstallationStatus__c = 'Yet to begin';
                    } 
                    else if(act.Rating.equals('Cold'))
                    {
                        opp.DeliveryInstallationStatus__c = 'Completed';
                    }
                }
                else
                {
                    opp.DeliveryInstallationStatus__c = '';
                }
                opportunityList.add(opp);            
            } 
        }
    }
    if(opportunityList.size()>0)
    {
        upsert opportunityList;
    }
}*/