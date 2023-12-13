@isTest
public class AccountContactTest {
@isTest
    static void testme(){
        Integer count=[select count() from Account];
        Integer size=[select count() from Contact];
        Account acc=new Account(Name='LearnFrenzy',phone='022-845454');
         
        try{
            insert acc;
        }catch(Exception e){
            System.debug(e);
        }
         
        Integer newCount=[select count() from Account];
        Integer newsize=[select count() from Contact];
        Contact c=[select lastname,phone from Contact where accountid=:acc.id];
        System.assertEquals(c.lastname,acc.name);
        System.assertEquals(c.phone,acc.phone);
    }    
    

}