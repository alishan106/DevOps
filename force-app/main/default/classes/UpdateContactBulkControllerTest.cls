@isTest
public class UpdateContactBulkControllerTest {
    @isTest
    public static void UpdateContactBulkControllerTest(){
        
        Test.startTest();
        UpdateContactBulkController controller = new UpdateContactBulkController();
        Test.stopTest();
        
    }
    
    @isTest
    public static void UpdateContactBulkTest1(){
        
        test.startTest();
        PageReference pageRef = Page.customer_list;
        Test.setCurrentPage(pageRef);
        UpdateContactBulkController  controller = new UpdateContactBulkController();
        controller.cancel();
        System.assertNotEquals(null,controller.cancel());       
        test.stopTest();        
    }
    @isTest
    public static void UpdateContactBulkTest2(){
        
        test.startTest();
        PageReference pageRef = Page.customer_list;
        Test.setCurrentPage(pageRef);
        UpdateContactBulkController  controller = new UpdateContactBulkController();
        controller.save();
        System.assertNotEquals(null,controller.save());       
        test.stopTest();        
    }
    

}