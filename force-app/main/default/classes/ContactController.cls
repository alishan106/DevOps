public class ContactController {
    public Contact contact{get;set;}
    public List<Contact> contactList{get;set;}
    public Id id;
    
    public ContactController(){
        contactList = [Select Id, Name, LastName, Phone, Email From Contact];
        
        id = ApexPages.currentPage().getParameters().get('id');
        
        if(id != NULL){
            contact = [Select Id, Name, LastName, Phone, Email From Contact where Id =: id];
        } else {        
        	contact = new Contact();
        }
    }
    
    public void save(){
        if(id == NULL){
        	insert contact;
        } else {
            update contact;
        }
    }  
    @AuraEnabled (cacheable=true)
    public static List<Contact> contactList(){
        return [SELECT Id, AccountId, Account.Name, LastName, FirstName, Phone, Email FROM Contact ORDER BY LastName];
    }
    @AuraEnabled
    public static void saveContacts(List<Contact> conList){
        System.debug(conList);
        if(conList.size() >0){
            INSERT conList;
        }
    }
}