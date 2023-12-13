public class FutureApexExample {
    
     public FutureApexExample(){
        createContact();
          createAccount();
        allContact();
        allAccount();
        
    }
    
    //@future
    static void createContact(){
        Contact contact = new Contact(LastName = 'Future Contact 3');
        insert contact;
        System.debug('Contact Id : '+contact.Id);
    }
    
    private void allContact(){
        List<Contact> contactList = [Select Id,LastName From Contact where createddate = Yesterday];
        System.debug('!!'+contactList.size());
    }
    
    //@future
    static void createAccount(){
        Account account = new Account(Name = 'Future Account 3', Account_Group_Name__c='Future Group', Email_Gmail__c='future38@gmail.com');
        insert account;
        System.debug('Account Id : '+account.Id);
    }
    
    static void allAccount(){
        List<Account> accountList = [Select Id,Name From Account where createddate = Today];
        System.debug('@@'+accountList.size());
    }
}