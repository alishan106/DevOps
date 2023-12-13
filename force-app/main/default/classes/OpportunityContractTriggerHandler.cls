public class OpportunityContractTriggerHandler {
    
    public static void onAfterUpdate(List<Opportunity> newOpps, Map<Id, Opportunity> oldOppMap){
        List<Contract> ctrList = new List<Contract>();
        for(Opportunity op : newOpps){     
            if(op.StageName == 'Contracts In' && oldOppMap.get(op.id).StageName == 'Contracts Out' && op.AccountId != Null){
                Contract ct = new Contract(Opportunity__c = op.Id, StartDate = System.today(), Status = 'Draft', ContractTerm = 12, AccountId = op.AccountId);
                ctrList.add(ct);
            }
        }                  
        if(ctrList.size()>0){
            Insert ctrList;
        }
    }
}