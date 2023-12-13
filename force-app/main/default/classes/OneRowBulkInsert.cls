public class OneRowBulkInsert {
	public Contact contactName{get;set;}
    public List<Contact> contactList{get;set;}
    public List<Contact> addcontactList{get;set;}
    public List<Contact> addSelectedcontactList{get;set;}

public OneRowBulkInsert(){
        contactName = new Contact();
        addcontactList = new List<Contact>();
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
  
    public void addRowInsert(){
        addcontactList.add(new Contact());      
    }
 
    public PageReference saveAll(){       
        try{
            for(Contact con : addcontactList)
            {   
                if((!String.isBlank(con.FirstName)) && (!String.isBlank(con.LastName)) && (!String.isBlank(con.AccountId))){
                    addSelectedcontactList.add(con);
                }
            }
            upsert addSelectedcontactList;

            PageReference pg = new PageReference('/003/o');
            pg.setRedirect(true);
            return pg;
        }
        catch(DmlException e){
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return NULL;
    }
}