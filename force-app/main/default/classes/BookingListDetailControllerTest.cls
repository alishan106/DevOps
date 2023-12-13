@isTest
public class BookingListDetailControllerTest {

    @isTest
    public static void testNo1(){
        
        Bank_Number__c bnk = new Bank_Number__c();
        bnk.Bank_Name__c = 'HDFC';
        bnk.IFSC_Code__c = 'PUNB0081500';
        insert bnk;        
        
        Customer__c cus = new Customer__c();
        cus.Email__c = 'roop@gmail.com';
        cus.Bank__c = bnk.Id;
        cus.Contact__c = '9876543120';
        insert cus;
        
        Booking__c boo  = new Booking__c();
        boo.Customer__c = cus.Id;
        boo.Customer_Email__c = 'Alka@gmail.com';
        insert boo;
        
        Test.startTest();
        
        BookingListDetailController bookng = new BookingListDetailController();
        bookng.sendEmail();
            
        Test.stopTest();
    }
}