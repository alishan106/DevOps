trigger ContactDesignamtionTrigger on Contact (before insert, before update) {
    
    for(Contact contact : Trigger.new){
        if(contact.Designation__c == 'Clerk' && (contact.Salary__c < 5000 || contact.Salary__c > 15000 )){
            contact.Salary__c.addError('Clerk Salary Must be Between 5000 - 15000');
        }else if(contact.Designation__c == 'Manager' && (contact.Salary__c < 12000 || contact.Salary__c > 50000 )){
            contact.Salary__c.addError('Manager Salary Must be Between 12000 - 50000');
        }else if(contact.Designation__c == 'Accountant' && (contact.Salary__c < 10000 || contact.Salary__c > 30000)){
            contact.Salary__c.addError('Accountant Salary Must be Between 10000 - 30000');
        }
    }

}