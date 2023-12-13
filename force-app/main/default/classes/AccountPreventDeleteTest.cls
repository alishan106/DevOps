@isTest
public class AccountPreventDeleteTest {

    @isTest
    public static void mainTest(){
       Account acc = new Account();
        acc.Name = 'Acc Cement';
        acc.Account_Group_Name__c = 'Birla Group';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'Fail';
        con.AccountId = acc.Id;
        insert con;
        
        Contact con1 = new Contact();
        con1.LastName = 'Fail1';
        con1.AccountId = acc.Id;
        insert con1;
        
        Test.startTest();
        
        Delete acc;
        
        Test.stopTest();
    }
}