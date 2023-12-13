public class OpportunityProductTriggerHelper {
    public static Boolean isFirst = true;
    
    public static void setPrimaryProductAtInsert(List <OpportunityProduct__c> productList){
        Set<Id> oppIds = new Set<Id>();
        for(OpportunityProduct__c product : productList ){
            oppIds.add(product.Opportunity__c);
        }
        Map <Id,Opportunity> sameOppMap = new Map<Id,Opportunity>(
            [SELECT Id,(SELECT Id, Primary_Product__c FROM OpportunityProducts__r )
             FROM Opportunity  WHERE Id in : oppIds ]);
        
        oppIds.clear();
        
        for(OpportunityProduct__c product : productList ){
            Opportunity opp = sameOppMap.get(product.Opportunity__c);
            if(opp.OpportunityProducts__r.size() > 0){
                if(product.Primary_Product__c){
                    oppIds.add(product.Opportunity__c);
                }
            }else{
                // First Product Checked
                product.Primary_Product__c = true;
            }
        }
        // Checked insert handling that is not first product
        List<OpportunityProduct__c> updateProductList = [SELECT Id, Opportunity__c, Primary_Product__c
                                                         FROM OpportunityProduct__c
                                                         WHERE Opportunity__c in: oppIds 
                                                         AND Primary_Product__c = true];
        for(OpportunityProduct__c obj : updateProductList ){
            obj.Primary_Product__c = false;
        } 
        UPDATE updateProductList;  
    }
    
    public static void setPrimaryProductAtUpdate(List <OpportunityProduct__c> productList){
        Set<Id> checkedProductIds = new Set<Id>();
        Set<Id> uncheckedProductIds = new Set<Id>();
        for(OpportunityProduct__c product : productList){
            if(product.Primary_Product__c){
                checkedProductIds.add(product.Opportunity__c);
            }else{
                uncheckedProductIds.add(product.Opportunity__c);
            }
        }
        // Handling Checked updates
        if(checkedProductIds.size() > 0){
           List <OpportunityProduct__c> uncheckProductList = [SELECT Id, Primary_Product__c, Opportunity__c
                                                             FROM OpportunityProduct__c 
                                                             WHERE Primary_Product__c = true 
                                                             AND Opportunity__c in : checkedProductIds ];
            for(OpportunityProduct__c obj : uncheckProductList){
                obj.Primary_Product__c = false;
            }
            UPDATE uncheckProductList;
        }
        // Handling unchecked updates
        if(uncheckedProductIds.size() > 0){
           List <OpportunityProduct__c> checkProductList = [SELECT Id, Primary_Product__c, Opportunity__c
                                                             FROM OpportunityProduct__c 
                                                             WHERE Primary_Product__c = false 
                                                             AND Opportunity__c in : uncheckedProductIds ];
      	 Map<Id,OpportunityProduct__c> productMap = new Map<Id,OpportunityProduct__c>();
            for(OpportunityProduct__c obj : checkProductList){
                obj.Primary_Product__c = true;
                productMap.put(Obj.Opportunity__c, obj);
            }
            UPDATE productMap.values();
        }
    }
}