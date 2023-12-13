public class RelationshipController {
    public List<Contact> contactList {get;set;}
    public List<Account> accountList {get;set;}
    public RelationshipController(){
        //	child to parent on standard object
        contactList = [Select id, name, phone, email,AccountId, Account.Name,Account.Email_Gmail__c from contact limit 5];
        
        //	parent to child on standard object
        accountList = [select id, name, phone,Email_Gmail__c , (select id, name, phone, email from contacts ) from account];
        
        //	child to parent on custom object 
        
        //	select id, date_of_registration__c, status__c, 
        //	Student__r.Name, Student__r.Last_Name__c, Student__r.email__c,
        //	course__r.Name 
        //	from registration__c
        
        //	parent to child on custom object
        
        //	select id,name,date_of_birth__c,
        //	(select id,date_of_registration__c,status__c from Students__r) 
        //	from student__C
    }	
}