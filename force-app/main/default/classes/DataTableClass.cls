public class DataTableClass {
    @AuraEnabled
    public static List<Account> getAccount(){
        return [SELECT Id, Name, Phone, Website, Email_Gmail__c FROM Account Limit 10];
    }

}