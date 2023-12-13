trigger PreventContactDelete on Contact (before delete) {
    
    List<Contact> accList = new List<Contact>();  
    Set<id> conIdSet = new Set<id>();  
    for(Contact con : Trigger.old)  
    {  
        conIdSet.add(con.Id);  
    }  
    
    List<Contact> conts = new List<Contact>([Select Id, LastName , Contact.Account.Only_Default_Contact__c from Contact where Id IN :conIdSet]);
    
    for(Contact cont : conts)
    {
        system.debug('checkbox1'+cont.Account.Only_Default_Contact__c);
        if(cont.Account.Only_Default_Contact__c)
        {
            cont.addError('Contact cannot be deleted');
        }
    }
    
}