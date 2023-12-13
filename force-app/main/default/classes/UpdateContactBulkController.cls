public class UpdateContactBulkController {
    
    public Contact contactName{get;set;}
    public Contact del{get;set;}
    public List<Contact> contactList{get;set;}
    public List<Contact> addcontactList{get;set;}
    public List<Contact> delcontactList{get;set;}
    public List<Contact> addSelectedcontactList{get;set;}
    public UpdateContactBulkController(){
        contactName = new Contact();
        contactList = new List<Contact>(); 
        addcontactList = new List<Contact>();
        delcontactList = new List<Contact>();
        addSelectedcontactList = new List<Contact>();
        contactList = [SELECT Id, FirstName, LastName, AccountId FROM Contact];
        for(Integer count=0;count<1;count++){
            addcontactList.add(new Contact());
        }
    }
    public PageReference cancel(){
        PageReference pg = new PageReference('/003/o');
        pg.setRedirect(true);
        return pg;        
    }
    public PageReference save(){
        try{ 
            update contactList;
            PageReference pg = new PageReference('/003/o');
            pg.setRedirect(true);
            return pg; 
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return NULL;
    }
}