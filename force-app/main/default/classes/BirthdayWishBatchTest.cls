@isTest
public class BirthdayWishBatchTest {
    
    static testMethod void testMethod1(){
        insert new Contact(FirstName='test', LastName = '1', Email = 'alizeeshan106@gmail.com', Birthday__c = date.today());        
        Test.startTest();       
        BirthdayWishBatch cb = New BirthdayWishBatch();       
        Id batchId = Database.executeBatch(new BirthdayWishBatch()); 
        Test.stopTest();
        
    }
}