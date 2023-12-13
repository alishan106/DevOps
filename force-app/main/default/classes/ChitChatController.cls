public with sharing class ChitChatController {

    @AuraEnabled(cacheable=true)
    public static Chit_Chat__c insertChatHistory(Chit_Chat__c chatObject){
        try {
            insert chatObject;
            return chatObject;
        } catch (Exception exp) {
            throw new AuraHandledException(exp.getMessage());
        }

    }
    @AuraEnabled
    public static List<Chit_Chat__c> findChatHistory() {        
        try {
            return [SELECT Id,Name, Chat_Date__c, Messages__c, User_Name__c FROM Chit_Chat__c ORDER BY Name]; 
        } catch (Exception exp) {
            throw new AuraHandledException(exp.getMessage());
        }
}

}