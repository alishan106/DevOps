@isTest
public class CommunityContactsClassTest {
    
    @isTest()
    public static void test2(){
        
        Contact con = new Contact();
        con.LastName = 'con';
        
        String str = 'con';
        
        Test.startTest();
        CommunityContactsClass obj = new CommunityContactsClass();
        CommunityContactsClass.insertContacts(con);
        CommunityContactsClass.findAccountId(str);
        
        Test.stopTest();
               
        
    }

}