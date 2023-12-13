@isTest
public class TestChitChatController {

    public static testMethod void ChitChatConMethod(){
        
        Chit_Chat__c chats = new Chit_Chat__c();
        chats.Chat_Date__c = '12/11/2021';
        
        Test.startTest();
        ChitChatController.findChatHistory();
        ChitChatController.insertChatHistory(chats);
        Test.stopTest();
        System.assert(chats.Chat_Date__c == '12/11/2021');
    }
}