public without sharing class CommunityContactsClass {
    public CommunityContactsClass() {        
    }    
    @AuraEnabled
    public static void insertContacts(Contact contactObject){        
        insert contactObject;
    }
    @AuraEnabled
    public static String findAccountId(String userIdVar){        
        List<User> u = [SELECT AccountId FROM User WHERE Id = :userIdVar];
        //System.debug('accId = ' + u[0].AccountId);
        if(!u.isEmpty()) {
            String accId = u[0].AccountId;
            return accId;
        }
        else{
            String accId = '';
            return accId;
        }        
    }
}