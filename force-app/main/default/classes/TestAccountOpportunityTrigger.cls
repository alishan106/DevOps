@isTest
public class TestAccountOpportunityTrigger {

    @isTest
    public static void mainMethod(){
        
        Account acc = new Account();
        acc.Name = 'Account Trigger';
        acc.Account_Group_Name__c = 'group';
        acc.Email_Gmail__c = 'ela@gmail.com';
        acc.Rating = 'Hot';
        insert acc;   
        
        Account acc1 = new Account();
        acc1.Name = 'Account Trigger 12';
        acc1.Account_Group_Name__c = 'group';
        acc1.Email_Gmail__c = 'ela12@gmail.com';
        acc1.Rating = 'In Progress';
        insert acc1; 
        
       	Opportunity opp = new Opportunity();
        opp.Name = 'Acc Opp';
        opp.StageName = 'Prospecting';
        opp.CloseDate = date.today().addDays(2);
        opp.DeliveryInstallationStatus__c = 'In Progress';
        opp.Discount__c = 100;
        opp.AccountId = acc.Id;
        opp.Stage_Type__c = '0';
        insert opp; 
        
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'Acc Opp12';
        opp1.StageName = 'Prospecting';
        opp1.CloseDate = date.today().addDays(2);
        opp1.DeliveryInstallationStatus__c = 'In Progress';
        opp1.Discount__c = 100;
        opp1.AccountId = acc1.Id;
        opp1.Stage_Type__c = '0';
        insert opp1; 
        
        acc.Rating = 'Warm';
        acc.Account_Type__c = 'Reseller';
        update acc;
        
        opp.AccountId = acc.Id;
        opp.DeliveryInstallationStatus__c = 'In Progress';
        update opp;
        
        acc.Rating = 'Cold';
        acc.Account_Type__c = 'Buyer';
        update acc;
        
        opp.AccountId = acc.Id;
        opp.DeliveryInstallationStatus__c = 'Yet to begin';
        update opp;
        
        acc.Rating = 'Hot';
        acc.Account_Type__c = 'Current Customer';
        update acc;
        
        acc.Rating = '';
        acc.Account_Type__c = '';
        update acc;
        
        opp.AccountId = acc.Id;
        opp.DeliveryInstallationStatus__c = 'Completed';
        update opp;
        
        acc.Billing_same_as_shipping__c = true;
        acc.Account_Type__c = '';
        update acc;
        
        
        
        /* Account accUp = new Account();
        accUp.Email_Gmail__c = 'elaji@gmail.com';        
        accUp.Account_Type__c = 'Current Customer';
        accUp.Id = acc.Id;
        
        
        Account acc1 = new Account();
        acc1.Name = 'Account Trigger1';
        acc1.Account_Group_Name__c = 'group1';
        acc1.Account_Type__c = 'Current Customer';
        acc1.Email_Gmail__c = 'ela1@gmail.com';
        acc1.AccountNumber = '12345665';        
        insert acc1;
        
        Account acc2 = new Account();
        acc2.Name = 'Account Trigger';
        acc2.Account_Group_Name__c = 'group';
        acc2.Account_Type__c = 'Buyer';
        acc2.Email_Gmail__c = 'ela2@gmail.com';
        insert acc2; 
        update accUp; */
    }

}