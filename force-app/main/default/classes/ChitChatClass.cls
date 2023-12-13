public without sharing class ChitChatClass {
    public ChitChatClass() {}

     @AuraEnabled
        public static List<Chit_Chat__c> findChatHistory(){

            return [ SELECT Id, Name, Chat_Date__c, Messages__c, User_Name__c FROM Chit_Chat__c Order BY Name];
        }

    @AuraEnabled
    public static void insertChatHistory(Chit_Chat__c chatObject ){
        try{
            insert chatObject;
        }
         catch(Exception e){
            throw new AuraHandledException(e.getMessage());
         }   
        }

}