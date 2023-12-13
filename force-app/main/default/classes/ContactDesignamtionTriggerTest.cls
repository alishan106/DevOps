@isTest
public class ContactDesignamtionTriggerTest {

    public static testMethod void ContactDesignamtion(){
        
		Contact con = new Contact();
        con.LastName = 'Xevier';
        con.Designation__c = 'Clerk';
        con.Salary__c = 9000;
        insert con;
        
        con.AssistantPhone = '2123212234';
        update con;
        
        Contact con1 = new Contact();
        con1.LastName = 'Xevier1';
		con1.Designation__c = 'Manager';
		con1.Salary__c = 13000;
        insert con1;
        
        Contact con2 = new Contact();
        con2.LastName = 'Xevier2';
		con2.Designation__c = 'Accountant';
		con2.Salary__c = 15000;
        insert con2;
        
    }
}