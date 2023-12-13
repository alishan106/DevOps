global class ContactToAccountWithBatch Implements Database.Batchable<sObject> {
    Integer i = 1;
    List <Account> accountlist = new List<Account>();
    global ContactToAccountWithBatch(List<Account> acclist){
        accountlist = acclist; 
    }
    public List<SObject> start(Database.BatchableContext BC){
        return accountlist;
    }
    global void execute(Database.BatchableContext BC,List<sObject> accountList){
        list<Contact> conlist = new list<contact>();
        for(sObject acc : accountList){
            Contact con = new Contact(AccountId=acc.id, LastName='Contact Batch'+i);
            conlist.add(con);
            i++;
        }  
        Insert conlist;
    }
    global void finish(Database.BatchableContext BC){
        System.debug('----completed----');
    }

}