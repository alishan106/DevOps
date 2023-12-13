@isTest
public class TotalRatingAccountTriggerTest {

    static testMethod void testTrigger(){
        Account acc = new Account(Name = 'test1', Email_Gmail__c='test@gmail.com', Account_Group_Name__c='None' );
        insert acc;
        
        Contact tk = New Contact();

        tk.AccountId = acc.Id;

        tk.LastName = 'Alishan';

        Test.startTest();

        Database.SaveResult str = database.insert(tk , False);

        System.assertEquals(True, str.isSuccess());

        Test.stopTest();
    }
}