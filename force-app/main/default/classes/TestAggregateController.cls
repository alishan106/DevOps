@isTest
public class TestAggregateController {
    

    public static testMethod void AggregateMethod(){
        
       Opportunity opp = new Opportunity(Name = 'Acc Opp', StageName = 'Prospecting', CloseDate = date.today() , Stage_Type__c = '10', Discount__c = 100);
        insert opp;
        AggregateController controll = new AggregateController();
    }
}