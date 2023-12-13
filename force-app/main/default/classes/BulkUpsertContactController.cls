public class BulkUpsertContactController {
    public Contact del{get;set;}
    public List<Contact> contactList{get;set;}
    public List<Contact> addcontactList{get;set;}
    public List<Contact> delcontactList{get;set;}
    public List<Contact> addSelectedcontactList{get;set;}
    public BulkUpsertContactController(){
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
    
    public void addRow(){
        contactList.add(new Contact());      
    }
    public void deleteRow(){ 
        try{ 
            if(contactList.size() >0){
                del = contactList.remove(contactList.size() -1);
                if(del.Id!=NULL){
                    delcontactList.add(del);
                }
            }
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
    }
    public void bulkSave(){
        try{
            for(Contact con : addcontactList )
            {   
                if((!String.isBlank(con.FirstName)) && (!String.isBlank(con.LastName)) && (!String.isBlank(con.AccountId))){
                    addSelectedcontactList.add(con);
                } 
            }
            upsert contactList;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        } 
    }
}