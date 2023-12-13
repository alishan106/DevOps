public with sharing class AccountListControllerLWC {
    public AccountListControllerLWC() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Account> displayAccountRecord(){
        List<Account> stuList = [SELECT Id, Name,  Email_Gmail__c, Phone FROM Account];
        return stuList;
    }

    @AuraEnabled
    public static void updateAccount(Account accObj){
        try {
            UPDATE accObj;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void cloneAccount(Account accObj){
        try {
            accObj.Id = NULL;
            INSERT accObj;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}