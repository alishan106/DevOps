public with sharing class AccountAttachmentsController{
    public List<Account> Records {get; set;}
    public AccountAttachmentsController(){
        Records = [select Id, Name, Email_Gmail__c, phone, (select id, name, contentType from Attachments) From Account];
        
    }
}