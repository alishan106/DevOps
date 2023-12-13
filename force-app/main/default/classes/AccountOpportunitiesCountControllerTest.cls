@isTest
public class AccountOpportunitiesCountControllerTest {
  
    @isTest
    public static void AccountAttachmentsControllerTest(){
        Test.startTest();
        Insert new Account(Name='Alishan', Email_Gmail__c='alishan106@gmmail.com');
        AccountOpportunitiesCountController controller = new AccountOpportunitiesCountController();
        Test.stopTest();
    }
}