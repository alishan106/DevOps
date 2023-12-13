public class SendEmailApexExample {
    public SendEmailApexExample(){
        
    }
    
    //	Send simple email
    public static void sendEmail1(){
        Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
        
        String[] toAddress = new String[]{'pankaj.g@ibirdsservices.com'};
        
        singleEmailMessage.setToAddresses(toAddress);
        singleEmailMessage.setSubject('Apex Simple Email Test Example');
        singleEmailMessage.setPlainTextBody('Hi all\nThis is our first example.How to send email using apex in salesforce');
        
        List<Messaging.Email> sendEmails = new List<Messaging.Email>{singleEmailMessage};
        //	sendEmails.add(singleEmailMessage);
        
        Messaging.sendEmail(sendEmails);
    }
    
    //	send email with to , cc , bcc , reply to , senderName , htmlBody
    public static void sendMail2(){
        Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
        
        singleEmailMessage.setToAddresses(new String[]{'pankaj.g@ibirdsservices.com'});
        singleEmailMessage.setCcAddresses(new String[]{'pankaj218@gmail.com','joshichitra9@gmail.com'});
        singleEmailMessage.setBccAddresses(new String[]{'fardinibirds1234@gmail.com'});
        
        singleEmailMessage.setSubject('Apex Email Test Example');
        String msg = '<b>Hi All</b><br/>Good Morning...';
        singleEmailMessage.setHtmlBody(msg);
        
        singleEmailMessage.setSenderDisplayName('iBirds Software Services Pvt. Ltd. Ajmer');
        
        singleEmailMessage.setReplyTo('pankajgoyal.ibirdscollege@gmail.com');
                        
        Messaging.Email[] sendEmails = new Messaging.Email[]{singleEmailMessage};
        Messaging.SendEmailResult[] result = Messaging.sendEmail(sendEmails);
        if(result[0].success){
            System.debug('email send successfully');
        } else {
            System.debug('Error : '+result[0].errors[0].message);
        }
    }	
    
    //	0035g000003BY1ZAAW
    
    //	send email to contact record
    public static void sendEmail3(){
        
        Contact contact = [SELECT id,Name, Email FROM Contact where id = '0035g000003BY1ZAAW'];
        
        Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
        
        singleEmailMessage.setToAddresses(new String[]{contact.Email});
        singleEmailMessage.setSubject('Salesforce Apex Email');
        
        String msg = '<b style=\'color:red\'>Hello '+contact.Name+'</b><br/>Your registration successfully completed';
        
        singleEmailMessage.setHtmlBody(msg);
        
        singleEmailMessage.setPlainTextBody(msg);
        
        Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.Email[]{singleEmailMessage});
        if(result[0].success){
            System.debug('email send successfully');
        } else {
            System.debug('Error : '+result[0].errors[0].message);
        }
   	}
    
    // send email with attachment    
    public static void sendEmail4(){
        
        Contact contact = [SELECT id, Name, Email FROM Contact where id = '0035g000003BY1ZAAW'];
        Attachment attachment = [SELECT id, Name, body, contentType FROM Attachment where parentId = '0035g000003BY1ZAAW'];
        
        Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
        
        singleEmailMessage.setToAddresses(new String[]{contact.Email});
        singleEmailMessage.setSubject('Salesforce Apex Email');
        
        String msg = '<b style=\'color:red\'>Hello '+contact.Name+'</b><br/>Your registration successfully completed';
        
        singleEmailMessage.setHtmlBody(msg);
        
        singleEmailMessage.setPlainTextBody(msg);
        
        //	email attachment
        
        Messaging.EmailFileAttachment emailFileAttachment = new Messaging.EmailFileAttachment();
        emailFileAttachment.setFileName(attachment.Name);
        emailFileAttachment.setBody(attachment.Body);
        
        Messaging.EmailFileAttachment[] attachments = new Messaging.EmailFileAttachment[]{emailFileAttachment};
        
        singleEmailMessage.setFileAttachments(attachments);
        
        Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.Email[]{singleEmailMessage});
        if(result[0].success){
            System.debug('email send successfully');
        } else {
            System.debug('Error : '+result[0].errors[0].message);
        }
   	}
    
    //	00X5g000000I4Bp
    
    //	send mail with email template
    public static void sendEmail5(){        
        Contact contact = [SELECT id, Name, Email FROM Contact where id = '0035g000003BY1ZAAW'];
        EmailTemplate emailTemplate = [Select id FROM EmailTemplate where id = '00X5g000000I4Bp'];
        
        Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
        
        // 	singleEmailMessage.setToAddresses(new String[]{contact.Email});
        
        singleEmailMessage.setTargetObjectId(contact.Id);
        
        singleEmailMessage.setTemplateId(emailTemplate.Id);
        
        Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.Email[]{singleEmailMessage});
        if(result[0].success){
            System.debug('email send successfully');
        } else {
            System.debug('Error : '+result[0].errors[0].message);
        }
        
    }
}