trigger CreateContract on Opportunity (after update) {
    
    List<Contract> conttoinsert = new List<Contract>();    
    for (Opportunity opp : Trigger.new){        
        // Create contract record only when the Stage is Updated to "Pending Win"
        if (opp.StageName != Trigger.OldMap.get(opp.id).StageName) {
            Contract con = new Contract();
            con.Opportunity__c   = opp.id;
            con.AccountId               = opp.AccountId;
            //con.CurrencyIsoCode       = opp.CurrencyIsoCode;
            conttoinsert.add(con); // For Bulk processing of the Records.
        } //end if
    } // End of For
    
    // Inserting the New Contract Records if these records exist
    if(!conttoinsert.isEmpty()) {
        insert conttoinsert;
    }   
}