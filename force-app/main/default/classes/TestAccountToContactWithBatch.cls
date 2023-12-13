@isTest
public class TestAccountToContactWithBatch {

     static testMethod void testMethod1() 
    {
        List<Account> lstAccount= new List<Account>();
        for(Integer i=0 ;i <200;i++)
        {
            Account acc = new Account();
            acc.Name ='Name'+i;
            lstAccount.add(acc);
        }
        
        insert lstAccount;
        
        Test.startTest();

            AccountToContactWithBatch obj = new AccountToContactWithBatch();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
        System.assert(lstAccount.size() > 0);
    }
}