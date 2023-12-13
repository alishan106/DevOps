trigger preventstageName on Opportunity (before update) {    
    
    Set<id> oppIds = new Set<id>();
    Id contRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('NameOfRecordType').getRecordTypeId();
    for(Opportunity opp:trigger.new){        
        if(opp.StageName !=trigger.oldmap.get(opp.id).StageName && opp.Id == contRecordTypeId){
            oppIds.add(opp.id);            
        }
    }    
    List<OpportunityContactRole> ocr = [SELECT id, Role from OpportunityContactRole WHERE OpportunityId IN:oppids];
    //List<OpportunityTeamMember> otm = [SELECT id, Name from OpportunityTeamMember WHERE opportunityId IN:oppids];    
    for(opportunity opp:trigger.new){        
        if(ocr.size()<1){            
            opp.adderror('you can\'t change the status without contactrole for opportunity');            
        }        
    }   
}