@isTest
public class UpdateAccountTest {
	@isTest
    public static void TestAcc(){
        
        Account acc = new Account();
        acc.Name = 'Musical';
        acc.Account_Group_Name__c = 'MS Dhoni';
        acc.Rating = 'Hot';
        insert acc;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Sukhi';
        opp.CloseDate = date.today();
        opp.StageName = 'Closed Won';
        opp.Discount__c = 90.10;
        opp.AccountId = acc.Id;
        insert opp;        
    }
}