@isTest
public class AaccountContactInlineTest {
    
    @isTest
    public static void testFuntion(){
        
        Contact con = new Contact();
        con.LastName = 'Bachpan Ka Pyar';
        insert con;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(con);
        
        Test.startTest();
        
        AaccountContactInlineController objSc = new AaccountContactInlineController(sc);
        objSc.selectedRecords();
        objSc.putBackWrap();
        objSc.mergeAccount();
        Test.stopTest();
    }

}