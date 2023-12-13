//	@isTest(seeAllData=true)
@isTest
public class ContactControllerTest {
	
    @isTest
    public static void getContact(){
    	ContactController contactController = new ContactController();
        List<Contact> contactList = contactController.contactList;
        Integer size = contactList.size();
        
        //	System.assert(size == 0);
        System.assert(size == 1,'Size : '+size);
    }
    
    @isTest
    public static void getContactWithData(){
        Contact contact = new Contact(LastName='Test 1');
        
        Test.startTest();
        insert contact;
        Test.stopTest();
        
        System.assert(contact.Id != NULL);
        
        ContactController contactController = new ContactController();
        
        List<Contact> contactList = contactController.contactList;
        
        System.assertEquals('Test 1',contactList.get(0).LastName);
        
        System.assert(contactList.size() == 1);
    }
    
    public static testMethod void  addContactWithoutRequiredField(){
        ContactController contactController = new ContactController();
        contactController.save();
        System.assert(contactController.contact.Id != NULL);
    }
    
    public static testMethod void addContact(){
        ContactController contactController = new ContactController();
        contactController.contact.LastName = 'Test 2';
        contactController.save();
        System.assert(contactController.contact.Id != NULL);
    }
    
    @isTest
    public static void updateContact(){
        Contact contact = new Contact(LastName = 'Test 3');
        
        Test.startTest();
        insert contact;
        Test.stopTest();
        
        System.assert(contact.Id != NULL);
        
        ApexPages.currentPage().getParameters().put('id',contact.Id);
        
        //	ApexPages.currentPage().getParameters().put('id','0035g000003McnZAAS');
        
        ContactController contactController = new ContactController();
        
        System.assert(contactController.id != NULL);
        
        contactController.contact.Email = 'test3@yahoo.com';
        
        contactController.save();
        
        System.assertEquals('test3@yahoo.com',contactController.contact.Email);
        //	contactController.id = ApexPages.currentPage().getParameters().get('id');        
    }

}