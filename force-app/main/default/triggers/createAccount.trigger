trigger createAccount on Account(before update) {
    //List<Contact> lst = new List<Contact>();
    //Contact con = new Contact();
    //Map<Id,Account> mpoAcc = new Map<Id,Account>();
    if(trigger.isBefore)
    {
        //mpoAcc = trigger.oldMap;
        system.debug('oldMap'+trigger.oldMap);
        
        for(integer i = 0; i < 1; i++)
        {
            system.debug('oldMap'+trigger.oldMap);
            /*
            con.AccountId = acc.Id;
            con.FirstName = 'Info';
            con.LastName = 'Default';
            con.Email = 'AmanHAdiYAAdnan@gmail.com';
            lst.add(con);  
        */
        }
    }
    /*
    if(trigger.isBefore && trigger.isUpdate)
    {
        List<Account> ls = [Select Only_Default_Contact__c from Account];
        for(Account a: trigger.new)
        {
            if(lst.size()==1)
            {
                a.Only_Default_Contact__c = TRUE;
                update a;
            }
            else
            {
                a.Only_Default_Contact__c = FALSE;
                update a;
            }
        }
    }
*/
}