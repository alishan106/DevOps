public class getSetController {
 @AuraEnabled(cacheable=true)
    public static List<Account> getAccount(){
        return [SELECT Id, Name, Type, Rating,Phone, Website
                FROM Account limit 10];
    }
    @AuraEnabled(cacheable=true)
     public static List<Contact> getContact(){
        return [SELECT Id,FirstName,LastName FROM Contact limit 10];
    }

    @AuraEnabled(cacheable=true)
     public static List<Opportunity> getOpportunity(){
        return [SELECT Id, StageName, Name, Amount, Type FROM Opportunity limit 10];
    }
}