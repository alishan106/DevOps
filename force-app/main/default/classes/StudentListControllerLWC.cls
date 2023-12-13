public with sharing class StudentListControllerLWC {
    public StudentListControllerLWC() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Student__c> displayStudentRecord(){
        List<Student__c> stuList = [SELECT Id, Name, Last_Name__c, Email_ID__c, Phone__c FROM Student__c];
        return stuList;
    }

    @AuraEnabled
    public static void updateStudent(Student__c stuObj){
        try {
            UPDATE stuObj;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void cloneStudent(Student__c stuObj){
        try {
            stuObj.Id = NULL;
            INSERT stuObj;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}