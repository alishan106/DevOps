public class SendMailWithMapController {
    
    public String toList {get;set;}
    public Boolean isWithAttachment {get;set;}
    public String bodyInput {get;set;}
    public String subjectInput {get;set;}
    public List<accountWrapperClass> accountWrapperList{get;set;}
    public boolean headerCheck {get;set;}
    public Map<Id,String> accountMailMap {get;set;}
    
    public SendMailWithMapController(){
        accountWrapperList = new List<accountWrapperClass>();
        accountMailMap = new Map<Id,String>();
        toList = '';
        init();
    }
    
    public void init(){
        for(Account obj : [select id, name, phone,Email_Gmail__c,(select id,Name from Attachments) from Account]){
        accountWrapperList.add(new accountWrapperClass(obj));
                              }
    }
    
    public void sendMail(){
        if(String.isEmpty(subjectInput)){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Subject Cannot Be Empty'));
        }else{
            Messaging.Email[] sendEmails = new Messaging.Email[]{};
                Map<Id,Attachment> attachmentMap = new Map<Id,Attachment>();
            
            if( isWithAttachment ){
                for(Attachment attach : [SELECT ParentId, Body , Name FROM Attachment WHERE ParentId 
                                         in : accountMailMap.keySet()]){
                attachmentMap.put(attach.ParentId, attach);
                                         }
            }
            
            for(Id id  : accountMailMap.keySet()){
                Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
                String emailId = accountMailMap.get(id);
                
                singleEmailMessage.setToAddresses(new String[]{emailId});
                singleEmailMessage.setSubject(subjectInput);
                singleEmailMessage.setPlainTextBody(' ' + bodyInput);
                
                if( isWithAttachment ){
                    if(attachmentMap.containsKey(id)){
                        Attachment attachment = attachmentMap.get(id);
                        Messaging.EmailFileAttachment emailFileAttachment = new Messaging.EmailFileAttachment();
                        emailFileAttachment.setFileName(attachment.Name);
                        emailFileAttachment.setBody(attachment.Body);
                        Messaging.EmailFileAttachment[] attachments = new Messaging.EmailFileAttachment[]{emailFileAttachment};
                        singleEmailMessage.setFileAttachments(attachments);
                    }
                }
                sendEmails.add(singleEmailMessage);
            }
            Messaging.SendEmailResult[] result = Messaging.sendEmail(sendEmails);
            if(result[0].success){
                accountMailMap.clear();
                subjectInput = bodyInput = toList ='';
                headerCheck = false;
                for(accountWrapperClass accountWrapperObj : accountWrapperList){
                    accountWrapperObj.isChecked = false;
                }
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Email Send Successfully.'));
            } else {
                String error =  result[0].errors[0].message;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, error ));
            }
        }    
    }
    
    public void checkboxHandling(){
        headerCheck = true;
        Id mailId ;
        for(accountWrapperClass accountWrapperObj : accountWrapperList){
            mailId = null;
            if(!String.isEmpty(accountWrapperObj.account.Email_Gmail__c)){
                mailId = accountWrapperObj.account.Id;
            }
            if(! accountWrapperObj.isChecked){
                headerCheck = false;
                if(mailId != null ){
                    accountMailMap.remove(mailId);
                    toList = accountMailMap.values().toString();
                }
            }else{
                if(mailId != null && !accountMailMap.containsKey(mailId)){
                    accountMailMap.put(mailId,accountWrapperObj.account.Email_Gmail__c);
                    toList = accountMailMap.values().toString();
                }
            }
        }
    }
    
    public void chkboxHeader(){
        if(headerCheck){
            for(accountWrapperClass accountWrapperObj : accountWrapperList){
                accountWrapperObj.isChecked = true;
                if(accountWrapperObj.account.Email_Gmail__c != NULL && ! accountMailMap.containsKey(accountWrapperObj.account.id)){
                       accountMailMap.put(accountWrapperObj.account.Id , accountWrapperObj.account.Email_Gmail__c ); 
                       toList = accountMailMap.values().toString();
                }
            }  
        } else{
            for(accountWrapperClass accountWrapperObj : accountWrapperList){
                accountWrapperObj.isChecked = false;
                toList = '';
            }
        }
    }
    
    public class accountWrapperClass{
        public Boolean isChecked{get;set;}
        public Account account{get;set;}
        public accountWrapperClass(Account inputObj){
            account = inputObj;
        }
    }
}