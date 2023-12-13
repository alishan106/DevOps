public class UpdateAccountHalper {    
    public static void updateRelatedAccount(List<Opportunity> newOpp, Map<Id,Opportunity> oldMap){
        List<Opportunity> oppRec = new List<Opportunity>();
        for(Opportunity op: newOpp){
            if(op.StageName != oldMap.get(op.Id).StageName){
                Opportunity opp = new Opportunity();
                opp.NextStep = op.StageName;
                opp.Id = op.Id;
                oppRec.add(opp);
            }
        }
        if(oppRec.size() > 0){
            update oppRec;
        }
    }
    
}