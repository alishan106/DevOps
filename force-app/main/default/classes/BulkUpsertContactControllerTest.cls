@isTest
public class BulkUpsertContactControllerTest {
    
    @isTest
    public static void mainTest(){
        
        Account acc = new Account();
        acc.Name = 'Acc Cement';
        acc.Account_Group_Name__c = 'Birla Group';
        insert acc;
        
        List<Contact> conList = new List<Contact>();
        
        Contact con = new Contact();
        con.LastName = 'Fail';
        con.FirstName = 'Not Fail';
        con.AccountId = acc.Id;
        insert con;
        
        Contact con1 = new Contact();
        con1.LastName = 'Fail1';
        con.FirstName = 'Not Fail';
        con1.AccountId = acc.Id;
        insert con1;
        
        conList.add(con);
        conList.add(con1);
        
        Test.startTest();
        BulkUpsertContactController obj = new BulkUpsertContactController();
        obj.bulkSave();
        obj.deleteRow();
        obj.addRow();
        obj.cancel();
        Test.stopTest();
    }

}