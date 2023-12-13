@isTest
public class ContactTriggerTest {
    
    @isTest    
    public static void TestContactTriggerAndController(){
        
        Contact conList = new Contact(
            LastName='Kayum');
        
        Test.startTest();
        insert conList;
        
        System.assertEquals('Kayum', conList.LastName);
        System.assertEquals(10000, conList.Salary__c);
        
        conList.LastName='ishant';
        update conList;
        
        
        Test.stopTest();
        System.assertEquals('ishant', conList.LastName);
    }
    
    @isTest
    public static void ContactDesignamtionTrggerTest(){
        
        Contact conList = new Contact(
            LastName='Faheem',
            Designation__c = 'Clerk',
            Salary__c = 16000);
        
        Test.startTest();
        try{
            insert conList;
        }
        catch(System.Exception ex){                
        }
    }
    @isTest
    public static void ContactDesignamtionTrggerTest2(){
        
        Contact conList = new Contact(
            LastName='Nadeem',
            Designation__c = 'Manager',
            Salary__c = 51000);
        
        Test.startTest();
        try{
            insert conList;
        }
        catch(System.Exception ex){                
        }
    }
    @isTest
    public static void ContactDesignamtionTrggerTest3(){
        
        Contact conList = new Contact(
            LastName='Waheem',
            Designation__c = 'Accountant',
            Salary__c = 41000);
        
        Test.startTest();
        try{
            insert conList;
        }
        catch(System.Exception ex){                
        }
    }
}