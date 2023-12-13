public class UpdateAccountHandler {
    
    public static void beforeInsert(List<Opportunity> newOpp){
        //UpdateAccountHalper.updateRelatedAccount();
    }
    public static void afterInsert(List<Opportunity> newOpp, Map<Id,Opportunity> newMap){
        //UpdateAccountHalper.updateStatus(); 
    }
    public static void beforeUpdate(List<Opportunity> newOpp, Map<Id,Opportunity> newMap, List<Opportunity> oldOpp, Map<Id,Opportunity> oldMap){
        
    }
    public static void afterUpdate(List<Opportunity> newOpp, Map<Id,Opportunity> newMap, List<Opportunity> oldOpp, Map<Id,Opportunity> oldMap){
       UpdateAccountHalper.updateRelatedAccount(newOpp,oldMap);
    }
    public static void beforeDelete(List<Opportunity> newOpp, Map<Id,Opportunity> newMap){
        
    }
    public static void afterDelete(List<Opportunity> newOpp, Map<Id,Opportunity> newMap){
        
    }
    public static void afterUndelete(List<Opportunity> newOpp, Map<Id,Opportunity> newMap){
        
    }
    
}