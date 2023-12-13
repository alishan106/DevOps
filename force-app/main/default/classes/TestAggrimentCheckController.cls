@isTest
public class TestAggrimentCheckController {

    public static testMethod void AggrimentTest(){
        
        Test.startTest();
			
        AggrimentCheckController objectAgg = new AggrimentCheckController();
        objectAgg.updateAggriment();
        Test.stopTest();
    }
}