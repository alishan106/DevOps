@isTest
public class BirthdayWishSchedulerTest {
    @istest
    public static void  testschedule() {        
        Test.StartTest();
        BirthdayWishScheduler sh1 = new BirthdayWishScheduler();      
        String sch = '0 0 23 * * ?';
        system.schedule('Test check', sch, sh1);
        Test.stopTest();        
    }
}