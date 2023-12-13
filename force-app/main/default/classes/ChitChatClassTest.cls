@isTest
public class ChitChatClassTest {
    
    @isTest
    public static void test1(){
        Chit_Chat__c ch = new Chit_Chat__c();
        ch.Messages__c = 'hello user';
        insert ch;
        
        Test.startTest();
        ChitChatClass obj = new ChitChatClass();
        ChitChatClass.findChatHistory();
		ChitChatClass.insertChatHistory(ch);         
        Test.stopTest();
    }

}