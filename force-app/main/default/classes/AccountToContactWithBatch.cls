global class AccountToContactWithBatch Implements Database.Batchable<sObject> {
    List<Account> acclist = new List<Account>();
    
   global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select id, name, Account_Group_Name__c, Email_Gmail__c from Account');
        
    }
    global void execute(Database.BatchableContext bc, List<Account> accList2){
    
    Integer i = 1;
     for(Account a : accList2)
     {
        Account acc = new Account(Name ='Account Batch '+i, Account_Group_Name__c = 'Group'+i , Email_Gmail__c = 'AccBatch'+i+'@gmail.com');
        acclist.add(acc); 
		i++;
     }
        try {
            insert acclist;
            
        } catch(Exception ex) {
            System.debug(ex);
        }
    }
    global void finish(Database.BatchableContext bc){
        
		System.debug('completed');
        Database.executeBatch(new ContactToAccountWithBatch(acclist));
        
    }

}