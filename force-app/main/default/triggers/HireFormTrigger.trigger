trigger HireFormTrigger on Hire_Form__c (before insert, after insert, after update) {
    
	 if(Trigger.isInsert && Trigger.isBefore){
        for(Hire_Form__c hireForm : Trigger.new){
            hireForm.Status__c = 'In Progress';           
        }
    }
    
    if(Trigger.isInsert && Trigger.isAfter){
        HireFormTriggerHelper.insertContactWithForm(Trigger.newMap); 
    }
    
    if(Trigger.isUpdate && Trigger.isAfter){
       List <Id> contactIds =  HireFormTriggerHelper.filterHireForms(Trigger.new);
        
        if(contactIds.size() > 0){
            HireFormTriggerHelper.caseStatusUpdate(contactIds);
        }
    }
}