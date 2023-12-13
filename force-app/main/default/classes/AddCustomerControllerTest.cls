@isTest
public class AddCustomerControllerTest {
    @isTest
    public static void AddCustomerControllerTest(){        
        Test.startTest();        
        AddCustomerController controller = new AddCustomerController(); 
        Test.stopTest();
    }
    @isTest
    public static void AddCustomerTest1(){
        
        test.startTest();
        PageReference pageRef = Page.customer_list;
        Hotel_Customer__c hCust = new Hotel_Customer__c();
        hCust.First_Name__c = 'Arnav B1';
        hCust.Gender__c = 'Male';
        hCust.Email__c = 'Male1@gmail.com';
        hCust.Nationality__c = 'Indian';
        insert hCust;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',hCust.id);
        AddCustomerController  controller = new AddCustomerController();
        controller.addCustomer();
        System.assertNotEquals(null,controller.addCustomer());       
        test.stopTest();        
    }
    
    @isTest
    public static void AddCustomerTest2(){
        
        test.startTest();
        PageReference pageRef = Page.customer_list;
        Hotel_Customer__c hCust = new Hotel_Customer__c();
        hCust.First_Name__c = 'Arnav B2';
        hCust.Gender__c = 'Male';
        hCust.Email__c = 'Male2@gmail.com';
        hCust.Nationality__c = 'Indian';
        insert hCust;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',hCust.id);
        AddCustomerController  controller = new AddCustomerController();
        controller.deleteCustomer();
        System.assertNotEquals(null,controller.deleteCustomer());       
        test.stopTest();        
    }
    @isTest
    public static void AddCustomerTest3(){
        
        test.startTest();
        PageReference pageRef = Page.customer_list;
        Hotel_Customer__c hCust = new Hotel_Customer__c();
        hCust.First_Name__c = 'Arnav B3';
        hCust.Gender__c = 'Male';
        hCust.Email__c = 'Male3@gmail.com';
        hCust.Nationality__c = 'Indian';
        insert hCust;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',hCust.id);
        AddCustomerController  controller = new AddCustomerController();
        controller.editCustomer();
        System.assertNotEquals(null,controller.editCustomer());       
        test.stopTest();        
    }
    @isTest
    public static void AddCustomerTest4(){
        
        test.startTest();
        PageReference pageRef = Page.customer_list;
        Hotel_Customer__c hCust = new Hotel_Customer__c();
        hCust.First_Name__c = 'Arnav B4';
        hCust.Gender__c = 'Male';
        hCust.Email__c = 'Male4@gmail.com';
        hCust.Nationality__c = 'Indian';
        insert hCust;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',hCust.id);
        AddCustomerController  controller = new AddCustomerController();
        controller.viewCustomer();
        System.assertNotEquals(null,controller.viewCustomer());       
        test.stopTest();        
    }
    @isTest
    public static void AddCustomerTest5(){
        
        test.startTest();
        PageReference pageRef = Page.customer_list;
        Hotel_Customer__c hCust = new Hotel_Customer__c();
        hCust.First_Name__c = 'Arnav B5';
        hCust.Gender__c = 'Male';
        hCust.Email__c = 'Male5@gmail.com';
        hCust.Nationality__c = 'Indian';
        insert hCust;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',hCust.id);
        AddCustomerController  controller = new AddCustomerController();
        controller.cloneCustomer();
        System.assertNotEquals(null,controller.cloneCustomer());       
        test.stopTest();        
    }
    @isTest
    public static void AddCustomerTest6(){
        
        test.startTest();
        PageReference pageRef = Page.customer_list;
        Hotel_Customer__c hCust = new Hotel_Customer__c();
        hCust.First_Name__c = 'Arnav B6';
        hCust.Gender__c = 'Male';
        hCust.Email__c = 'Male6@gmail.com';
        hCust.Nationality__c = 'Indian';
        insert hCust;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',hCust.id);
        AddCustomerController  controller = new AddCustomerController();
        controller.cancelCustomer();
        System.assertNotEquals(null,controller.cancelCustomer());       
        test.stopTest();        
    }
    @isTest
    public static void AddCustomerTest7(){
        
        test.startTest();
        PageReference pageRef = Page.customer_list;
        Hotel_Customer__c hCust = new Hotel_Customer__c();
        hCust.First_Name__c = 'Arnav B7';
        hCust.Gender__c = 'Male';
        hCust.Email__c = 'Male7@gmail.com';
        hCust.Nationality__c = 'Indian';
        insert hCust;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',hCust.id);
        AddCustomerController  controller = new AddCustomerController();
        controller.saveNnew();
        System.assertNotEquals(null,controller.saveNnew());       
        test.stopTest();        
    }
    @isTest
    public static void AddCustomerTest8(){
        
        test.startTest();
        PageReference pageRef = Page.customer_list;
        Hotel_Customer__c hCust = new Hotel_Customer__c();
        hCust.First_Name__c = 'Arnav B8';
        hCust.Gender__c = 'Male';
        hCust.Email__c = 'Male8@gmail.com';
        hCust.Nationality__c = 'Indian';
        insert hCust;
        Test.setCurrentPage(pageRef);
        pageRef.getParameters().put('id',hCust.id);
        AddCustomerController  controller = new AddCustomerController();
        controller.addNew();
        System.assertNotEquals(null,controller.addNew());       
        test.stopTest();        
    }
    
}