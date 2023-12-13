global class BirthdayWishBatch implements Database.Batchable<sObject>{
    string query;
    global Database.querylocator start(Database.BatchableContext bc){
        String query= 'SELECT Id, FirstName, LastName, Email, birthday__c FROM Contact Where Email != null AND birthday__c = TODAY';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> allContact){	
        EmailTemplate emailTemplate = [SELECT Id, Name, DeveloperName, body, HtmlValue, Subject 
                                       FROM EmailTemplate where DeveloperName = 'Birthday_Wish'];
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        for(Contact con : allContact){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();           
            email.setTemplateId(emailTemplate.Id);
            email.setSaveAsActivity(false);
            email.setTargetObjectId(con.Id);
            email.setCcAddresses(new String [] {'alizeeshan106@gmail.com'});
            email.setToAddresses(new String [] {con.Email});
            emailList.add(email);
            }
        Messaging.sendEmail(emailList);
    }
    global void finish(Database.batchableContext bc){
    }
}