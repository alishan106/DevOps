public class TotalRatingAccountTriggerHelper {
    
    Map<Id,Account> newAccountMap ;
    public static Boolean isFirstTime = true;
    public static void setRatingCount(List<Account> accountList){
        Integer totalHot, totalCold, totalWarm;
        totalHot = totalCold = totalWarm = 0;
        List<AggregateResult> countList = [SELECT COUNT(Id), Rating FROM Account GROUP BY Rating];
        for(AggregateResult res : countList){
            if(res.get('Rating') == 'Hot'){
                totalHot = (Integer) res.get('expr0');
            }else if(res.get('Rating') == 'Warm'){
                totalWarm = (Integer) res.get('expr0');
            }else if(res.get('Rating') == 'Cold'){
                totalCold = (Integer) res.get('expr0');
            }
        }
        List<Account> ratingAccountList = new List<Account>();
        for(Account acc : [SELECT Id,Total_Cold__c, Total_Warm__c, Email_Gmail__c, Total_Hot__c From Account]){
			acc.Total_Cold__c = totalCold;
            acc.Total_Hot__c = totalHot;
            acc.Total_Warm__c = totalWarm;
            ratingAccountList.add(acc);
        }
        UPDATE ratingAccountList;
    }

}