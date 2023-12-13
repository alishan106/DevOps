@isTest
private class TestOpportunityAccountTrigger {

    public static testMethod void TestAccTrigger(){
        Account acc = new Account();
        acc.name = 'testaccount';
        acc.Account_Type__c = 'Current Customer';
        acc.Account_Group_Name__c = 'None';
        acc.Email_Gmail__c = 'email@gmail.com';
        insert acc;
        
        Account acc1 = new Account();
        acc1.name = 'testaccount1';
        acc1.Account_Type__c = 'Buyer';
        acc1.Account_Group_Name__c = 'NoneOfThese';
        acc1.Email_Gmail__c = 'email1@gmail.com';
        insert acc1;
        
        Account acc2 = new Account();
        acc2.name = 'testaccount2';
        acc2.Account_Type__c = 'Reseller';
        acc2.Account_Group_Name__c = 'Non';
        acc2.Email_Gmail__c = 'email2@gmail.com';
        insert acc2;
        
        Account acc3 = new Account();
        acc3.name = 'testaccount3';
        acc3.Account_Group_Name__c = 'Non';
        acc3.Email_Gmail__c = 'email3@gmail.com';
        insert acc3;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Acc Opp';
        opp.StageName = 'Prospecting';
        opp.CloseDate = date.today().addDays(2);
        opp.Discount__c = 100;
        opp.AccountId = acc1.Id;
        opp.Stage_Type__c = '25';
        insert opp;
        
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'Acc Opp1';
        opp1.StageName = 'Prospecting';
        opp1.CloseDate = date.today().addDays(2);
        opp1.Discount__c = 25;
        opp1.AccountId = acc2.Id;
        opp1.Stage_Type__c = '10';
        insert opp1;
        
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'Acc Opp2';
        opp2.StageName = 'Prospecting';
        opp2.CloseDate = date.today().addDays(2);
        opp2.Discount__c = 10;
        opp2.AccountId = acc3.Id;
        opp2.Stage_Type__c = '0';
        insert opp2;
        
        Opportunity opp3 = new Opportunity();
        opp3.Name = 'Acc Opp3';
        opp3.StageName = 'Prospecting';
        opp3.CloseDate = date.today().addDays(2);
        opp3.Discount__c = 90;
        opp3.AccountId = acc.Id;
        opp3.Stage_Type__c = '100';
        insert opp3;
    }
}