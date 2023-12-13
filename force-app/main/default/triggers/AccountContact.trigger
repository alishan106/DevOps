trigger AccountContact on Account (after insert) {
    List<Contact> conList = new List<Contact>();
    for(Account acc : trigger.new){
        Contact c = new Contact();
        c.AccountId = acc.Id;
        c.LastName = acc.Name;
        conList.add(c);
        
    }
    insert conList;

}