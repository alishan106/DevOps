@isTest
public class AccountListControllerLWCTest {
    
    @isTest
    public static void accListTest(){
        Account acc = new Account(Name='Test Account 1'); 
        AccountListControllerLWC newObj = new AccountListControllerLWC();
        AccountListControllerLWC.displayAccountRecord();        
    }
    @isTest
    public static void accListTest2(){
        Account acc = new Account(Name='Test Account 2');
        Id id1 = acc.Id;
        insert acc;
        Account acc1 = new Account(Name='Test Account 3', id = id1);
        AccountListControllerLWC newObj = new AccountListControllerLWC();
        AccountListControllerLWC.updateAccount(acc1);
 		System.assert(acc.Id != NULL);         
    }
    @isTest
    public static void accListTest3(){
        Account acc = new Account(Name='Test Account 4');
        insert acc;
        AccountListControllerLWC newObj = new AccountListControllerLWC();
        AccountListControllerLWC.cloneAccount(acc); 
        System.assert(acc.Id != NULL);  
    }
    @isTest
    public static void accListTest4(){
        Account acc2 = new Account();
        AccountListControllerLWC newObj = new AccountListControllerLWC();
        AccountListControllerLWC.cloneAccount(acc2);
        System.assert(acc2.Id == NULL);      
    }
}