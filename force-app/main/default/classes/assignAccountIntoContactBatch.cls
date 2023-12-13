global class assignAccountIntoContactBatch implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query ='SELECT Name, Id, Email, AccountId, Phone FROM Contact where AccountId = NULL';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> conList){
        List<Account> lstAccout = [SELECT Id, (select Id from Contacts) FROM Account];
        Map<Id, Contact> contactMap = new  Map<Id,  Contact>();
        Map<Id, Account> newAccountMap = new Map<Id, Account>();	
        
        for(account acc:lstAccout){
            Integer cuntAccount = acc.contacts.size();
                for(Contact con : conList){                    
                    if(!contactMap.containsKey(con.Id) && cuntAccount < 2){
                        con.AccountId = acc.Id;
                        system.debug('con'+con);
                        contactMap.put(con.Id, con);
      					cuntAccount += 1;
                    }                    
                }
                 
        }
        system.debug('map'+contactMap.values());
        update contactMap.values();
    }
    
    global void finish(Database.BatchableContext BC) {
        
    }
    
}