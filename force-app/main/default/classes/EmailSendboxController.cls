public class EmailSendboxController {
    public Boolean chekValue {get;set;}
    public String inputTo {get;set;}
    public String inputCc {get;set;}
    public String inputBcc {get;set;}
    public String inputSubject {get;set;}
    public String inputBody {get;set;}
    public Messaging.SingleEmailMessage email;
    
    public EmailSendboxController(){
        
    }
    public void richAction(){   
        
    }    
    public PageReference sendEmail(){
        if(String.isNotBlank(inputTo) && String.isNotBlank(inputSubject) ) 
        {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            
            if(String.isNotBlank(inputBcc)){
                email.setBccAddresses(new String[] {inputBcc});
                system.debug('Bcc'+inputBcc);
            }
            
            if(String.isNotBlank(inputCc)){
                email.setCcAddresses(new String[] {inputCc});
                system.debug('CC'+inputCc);
            }
            
            email.setToAddresses(new String[] {inputTo});
            email.setSubject(inputSubject);
            
            if(String.isNotBlank(inputBody)){            
            if(chekValue){           
                email.setHtmlBody(inputBody);
            }
            else{
                email.setPlainTextBody(inputBody);
            }
            }else{
             if(chekValue){           
                email.setHtmlBody('<b>Nothing is in Body</b>');
            }   
               else{
                email.setPlainTextBody('Nothing is in Body');
            }
            }
            
            Messaging.Email[] sendEmails = new Messaging.Email[]{email};
                Messaging.SendEmailResult[] result = Messaging.sendEmail(sendEmails);
            if(result[0].success){
                System.debug('email send successfully');
                PageReference pageRef = new PageReference('/apex/email_sendbox');
                pageRef.setRedirect(true);
                return pageRef;
            } else {
                System.debug('Error : '+result[0].errors[0].message);
            }
            
        }
        else{
            apexPages.addmessage(new apexpages.message(apexpages.severity.Error, 'To and Body Can Not be Empty...'));
        }
        return Null;  
    }
}