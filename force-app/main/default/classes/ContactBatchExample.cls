global class ContactBatchExample implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('select id, name, LastName from Contact');
        
    }
    global void execute(Database.BatchableContext bc, List<Contact> conList){
        for(Contact con : conList) { 
            con.FirstName = '';
            con.LastName = con.Name;
        }
        try {
            update conList;
            
        } catch(Exception ex) {
            System.debug(ex);
        }
    }
    global void finish(Database.BatchableContext bc){
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
                          TotalJobItems, CreatedBy.Email
                          FROM AsyncApexJob WHERE Id =
                          :BC.getJobId()];
        System.debug('JobId'+BC.getJobId());
        System.debug('Batch Status'+job.Status);
        System.debug('Batch no of error'+job.NumberOfErrors);
        System.debug('Batch total item'+job.TotalJobItems);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {job.CreatedBy.Email};
            mail.setToAddresses(toAddresses);
        mail.setSubject('Batch Apex Status ' + job.Status);
        mail.setPlainTextBody('The batch apex total job processed ' + job.TotalJobItems +
             ' batch with '+ job.NumberOfErrors + ' failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
    } 
    
}