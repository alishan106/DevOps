/**
 * @description       : This class is used for create account records by CSV file.
 * @coverage          : Test.cls | @CC100%
 * @author            : techdicerkeeplearning@gmail.com
 * @group             : Techdicer
 * @last modified on  : 05-27-2023
 * @last modified by  : techdicerkeeplearning@gmail.com
 * Modifications Log
 * Ver   Date         Author                                    Modification
 * 1.0   05-27-2023   techdicerkeeplearning@gmail.com            Initial Version | Story Number | @CC100%
 **/
public class AccountDataCreateByCSV {
    /**
    * @description create account records by CSV file.
    * @author techdicerkeeplearning@gmail.com | 05-27-2023 | Story Number
    * @param base64Data
    * @return List<Account> returns the provided list of accounts
    **/
    @AuraEnabled
    public static List<Account> createAccountRecords(String base64Data) {
        String data = JSON.deserializeUntyped(base64Data).toString();
        List<Account> accList = new List<Account>();
        List<String> lstCSVLines = data.split('\n');
		Map<String, String> emailPhoneMap = new Map<String, String>();
        Set<String> emailSet = new Set<String>();
        Set<String> phoneSet = new Set<String>();
        for(Integer i = 1; i < lstCSVLines.size(); i++){
            Account acc = new Account();
            String csvLine = lstCSVLines[i];
            String prevLine = csvLine;
            Integer startIndex;
            Integer endIndex;
            
            while(csvLine.indexOf('"') > -1){
                if(startIndex == null){
                    startIndex = csvLine.indexOf('"');
                    csvLine = csvLine.substring(0, startIndex) + ':quotes:' + csvLine.substring(startIndex+1, csvLine.length());
                }else{
                    if(endIndex == null){
                        endIndex = csvLine.indexOf('"');
                        csvLine = csvLine.substring(0, endIndex) + ':quotes:' + csvLine.substring(endIndex+1, csvLine.length());
                    }
                }
                
                if(startIndex != null && endIndex != null){
                    String sub = csvLine.substring(startIndex, endIndex);
                    sub = sub.replaceAll(',', ':comma:');
                    csvLine = csvLine.substring(0, startIndex) + sub + csvLine.substring(endIndex, csvLine.length());
                    startIndex = null;
                    endIndex = null;
                }
            }
            
            List<String> csvRowData = new List<String>();
            for(String column : csvLine.split(',')){
                column = column.replaceAll(':quotes:', '').replaceAll(':comma:', ',');
                csvRowData.add(column);
            }
            if(csvRowData[0] != NULL && !String.isBlank(csvRowData[0])){
                emailSet.add(csvRowData[0]);
                System.debug('csvRowData[0]'+csvRowData[0]);
            }
            if(csvRowData[1] != NULL && !String.isBlank(csvRowData[1])){
                phoneSet.add(csvRowData[1]);
                System.debug('csvRowData[1]'+csvRowData[1]);
            }
            /*
            acc.Email = csvRowData[0];
            acc.Phone = csvRowData[1];
            acc.AccountNumber = csvRowData[2];
            acc.Type_Description__c = csvRowData[3];
            accList.add(acc);
            */
             }

        if(!emailPhoneMap.isEmpty()){
            /*
            System.debug(accList[0]);
            List<Database.SaveResult> rs = Database.insert(accList,false);  
            string header = 'Record Id, Success , Error \n';
            string finalstr = header ;
            for(Database.SaveResult r:rs){
                string recordString = r.getId()+','+r.isSuccess()+','+r.getErrors()+'\n';                
                finalstr = finalstr +recordString;
            }
            
            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            blob csvBlob = Blob.valueOf(finalstr);
            string csvname= 'Result.csv';
            csvAttc.setFileName(csvname);
            csvAttc.setBody(csvBlob);
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            String[] toAddresses = new list<string> {'alizeeshan106@gmail.com'};
                String subject ='Result CSV';
            email.setSubject(subject);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody('Result CSV ');
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            System.debug('rs'+rs);
            */
        }
        System.debug('phoneSet'+phoneSet);
        System.debug('emailSet'+emailSet);
        if(phoneSet.size() > 0 || emailSet.size() > 0){
            accList = [Select id, Name, Email_Gmail__c,phone from Account Where Email_Gmail__c IN:emailSet OR phone IN:phoneSet];
        }
        return accList;
    }
}