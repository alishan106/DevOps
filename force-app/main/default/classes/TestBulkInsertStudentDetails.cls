@isTest
public class TestBulkInsertStudentDetails {

    public static testMethod void BulkInsertMethod(){
        Student__c stu = new Student__c();
        stu.Name = 'Alishan';
        stu.Email_ID__c = 'alishan@gmail.com';
        insert stu;
        Test.startTest();
        BulkInsertStudentDetails obj = new BulkInsertStudentDetails();
        obj.addAllRecord();
        obj.cancel();
        Test.stopTest();
    }
}