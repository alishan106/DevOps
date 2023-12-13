public with sharing class TestExam {
    public TestExam() {}

        @AuraEnabled
        public static List<Account> getRecentReports(){
            return [SELECT Id, Name FROM Account];
        }
    
}