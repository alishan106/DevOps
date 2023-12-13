public class AccountHandler {
    /*public static void countContact(Map<Id,Account> accountNewMap){
        List<Contact> conList = new List<Contact>();
        List<Account> accList = [select Id,Name from Account where Id IN:accountNewMap.keyset()];
    
        for(Account acc:accList){
            acc.Only_Default_Contact__c=true;
            System.debug('acc.Only_Default_Contact__c'+acc.Only_Default_Contact__c);
            conList.add(new Contact(FirstName='Info',LastName='Default',Email='info@websitedomain.tld',AccountId=acc.Id));
        } 
        update accList;
        if(conList.size()>0){
            insert conList;
        }
       
    }
    
    public static void checkContactCountOnAccount(List<Contact> contactList){
       
        Set<Id> accIds = new Set<Id>();
        for(Contact con:contactList){
            accIds.add(con.AccountId);
        }   
  
        List<Account> accList = [select id,(select Id,Name from Contacts) from Account where Id IN:accIds];
        for(Account acc:accList){
            if(acc.Contacts.size()>1){
                acc.Only_Default_Contact__c=false;
               
            }
        }
    	update accList;   
       
    }*/
}