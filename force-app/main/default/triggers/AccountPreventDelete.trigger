trigger AccountPreventDelete on Account (before delete) {
    
    Set<Id> AccountIds = new Set<Id>();
    for(Account acc : Trigger.old){
        AccountIds.add(acc.Id);
    }
    
    List<Account> acList = [Select Id, Name, (Select Id, Name from Contacts) from Account Where Id IN : AccountIds];
    Map<id,Account> mapacc = new Map<id,Account>();
    for(Account a : acList){
        mapacc.put(a.Id, a);
    }
    for(account acc:trigger.old)
    {
        if(mapacc.get(acc.id).contacts.size()>=2)
        {
            acc.adderror('Account cannot be deleted because it has more then one contact');
        }
    }
}