public class SendEmailAccountsController {
    public List<String> accMailList {get;set;}
    public List<wrapAccount> wrapAccountList {get; set;}
    public List<Account> selectedAccounts{get;set;}
    public Boolean headerCheck {get;set;}
    public String inputSubject {get;set;}
    public String inputBody {get;set;}
    public Boolean attCkeck {get;set;}
    
    public SendEmailAccountsController(){
        accMailList = new List<string>();
        wrapAccountList = new List<wrapAccount>();
        for(Account accObj: [select id, name, phone,Email_Gmail__c,(select id,Name from Attachments) from Account]) {
            wrapAccountList.add(new wrapAccount(accObj));
        }
    }
        
        public void processSelected() {
            for(wrapAccount wrapAccountObj : wrapAccountList) {
                wrapAccountObj.selected = headerCheck;
                if(wrapAccountObj.selected && wrapAccountObj.acc.Email_Gmail__c != NULL && !accMailList.contains(wrapAccountObj.acc.Email_Gmail__c)){
                   accMailList.add(wrapAccountObj.acc.Email_Gmail__c); 
                }else if(headerCheck == false){
                    accMailList.clear();
                }
            }
        }
    public void singleChecked(){
        for(wrapAccount wrapAccountObj : wrapAccountList) {
            if(!wrapAccountObj.selected && accMailList.contains(wrapAccountObj.acc.Email_Gmail__c)){
               Integer indexNo = accMailList.indexOf(wrapAccountObj.acc.Email_Gmail__c);
               accMailList.remove(indexNo); 
            }else if(wrapAccountObj.selected && !accMailList.contains(wrapAccountObj.acc.Email_Gmail__c)){
               accMailList.add(wrapAccountObj.acc.Email_Gmail__c); 
            }
            
        }
    }
        
        public PageReference mailSend(){
            List<Messaging.SingleEmailMessage> masterEmail = new List<Messaging.SingleEmailMessage>();
            
        if(!accMailList.isEmpty() && String.isNotBlank(inputBody) && String.isNotBlank(inputSubject)) 
        {
           Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            
            for(integer i=0; i<accMailList.size(); i++){
            
            email.setToAddresses(accMailList);
            email.setSubject(inputSubject);
            email.setPlainTextBody(inputBody);
            masterEmail.add(email);
            }
            //Messaging.sendEmail(masterEmail);
            System.debug('@@@@@'+masterEmail);
            
            PageReference pageRef = new PageReference('/apex/send_email_accounts');
            pageRef.setRedirect(true);
            return pageRef;
            
        }
        else{
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'To,Subject and Body are Required Field'));
        }
        return null;		
    }  
    	public class wrapAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
        
            public wrapAccount(Account accObj) {
                acc = accObj;
                selected = false;
        }
    }
}