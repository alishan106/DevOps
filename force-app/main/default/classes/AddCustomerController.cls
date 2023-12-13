public class AddCustomerController {
    public Hotel_Customer__c customer{get;set;}
    public List<Hotel_Customer__c> customerList{get;set;} 
    public String searchText {get;set;} 
    public Id customerId{get;set;}
    public Boolean inputscreen{get;set;}
    public Boolean outputscreen{get;set;}
    public Boolean saveNnewOn{get;set;}
    public AddCustomerController(){
        inputscreen=true;
        outputscreen=false;
        saveNnewOn=true;
        customer = new Hotel_Customer__c();
        customerList = new List<Hotel_Customer__c>();
        customerList = [SELECT Id, First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, Email__c, Phone__c, Nationality__c,Full_Name__c, Is_Married__c FROM Hotel_Customer__c order by LastModifiedDate DESC , CreatedDate DESC];
        String id = ApexPages.currentPage().getParameters().get('id');
        String clone = ApexPages.currentPage().getParameters().get('clone');
        String saveNnew = ApexPages.currentPage().getParameters().get('savNenew');
        String isViewClicked = ApexPages.currentPage().getParameters().get('viewClicked');
        if(!String.isBlank(isViewClicked)){
            inputscreen = false;
            outputscreen = true;
            customer = [SELECT Id, First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, Email__c, Phone__c, Nationality__c,Full_Name__c, Is_Married__c FROM Hotel_Customer__c where id =: isViewClicked];
        }
        else if(!String.isBlank(id)){
            saveNnewOn=false;
            customer = [SELECT Id, First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, Email__c, Phone__c, Nationality__c,Full_Name__c, Is_Married__c FROM Hotel_Customer__c where id =: id];            
        }
        else if(!String.isBlank(clone)){
            customer = [SELECT First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, Email__c, Phone__c, Nationality__c, Is_Married__c,Full_Name__c FROM Hotel_Customer__c where id =: clone];
            customer.Id = null;
        }
        else if(!String.isBlank(saveNnew)){
            
            customer = [SELECT First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, Email__c, Phone__c, Nationality__c, Is_Married__c,Full_Name__c FROM Hotel_Customer__c where id =: saveNnew];
            customer.Id = null;
        }
        else {
            customer=new Hotel_Customer__c();
        }
    }    
    public pagereference addCustomer(){   
        try {
            upsert customer;
            pagereference page = new pagereference('/apex/customer_list');
            page.setRedirect(true);
            return page;
        }catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return NULL;
    }
    
    public pagereference deleteCustomer(){  
        try {
            customer.id=customerId;
            delete customer;
            pagereference page = new pagereference('/apex/customer_list');
            page.setRedirect(true);
            return page;
        }catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return NULL;
    }
    public pagereference editCustomer(){
        {   
            try {
                pagereference page = new pagereference('/apex/add_new_customer?id='+customerId); 
                page.setRedirect(true);
                return page;
            }catch(DmlException e) {
                System.debug('The following exception has occurred: ' + e.getMessage());
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
                ApexPages.addMessage(myMsg);
            }
            return NULL;
        }
        
    }
    public pagereference viewCustomer(){  
        try {
            pagereference page = new pagereference('/apex/add_new_customer?viewClicked='+customerId); 
            page.setRedirect(true);
            return page;
        }catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return NULL;
    }
    public pagereference cloneCustomer(){   
        try {
            pagereference page = new pagereference('/apex/add_new_customer?clone='+customerId);
            page.setRedirect(true);
            return page;
        }catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return NULL; 
    }
    public pagereference cancelCustomer(){
        pagereference page = new pagereference('/apex/customer_list'); 
        page.setRedirect(true);        
        return page; 
    }
    public pagereference saveNnew(){   
        try {
            upsert customer;
            PageReference pageRef = new PageReference('/apex/add_new_customer');
            pageRef.setRedirect(true);
            return pageRef;
        }catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return NULL;
    }
    private void init(){
        customerList = [SELECT Id, First_Name__c, Last_Name__c, Gender__c, Address__c, City__c, Email__c, Phone__c, Nationality__c, Is_Married__c,Full_Name__c FROM Hotel_Customer__c order by CreatedDate];
    }
    public pagereference addNew(){
        pagereference page = new pagereference('/apex/add_new_customer'); 
        page.setRedirect(true);        
        return page;  
    }
}