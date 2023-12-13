global class GetPicklistValue {
    /*
    @InvocableMethod(callout=true label='Get Contact Id')
    public static List<String> CheckValues(List<string> values) {
        List<String> finalLst = new List<String>();
        if(!(values.isEmpty())){            
            for (String tStr : values[0].split(';')) {
                System.debug('tStr'+tStr);
                finalLst.add(tStr);
            }
            System.debug('finalLst'+finalLst);  
            return finalLst;
        }
        return NULL;
    }*/
    
      @InvocableMethod(callout=true label='Get Contact Id')
    public static List<List<Contact>> getVehicleType(List<string> values){        
        if(!(values.isEmpty())){  
            List<List<Contact>> ListPicklistType = new List<List<Contact>>();
            List<String> VehicleType = new List<String>();
            for(String obj : values[0].split(';')) {
                
                if(obj != null) {
                    VehicleType.add(obj);
                }
                System.debug('');                
            }
            List<Contact> conList = [SELECT Id, IsDeleted, MasterRecordId, AccountId, LastName, FirstName, Salutation, Name, RecordTypeId, OtherStreet, OtherCity, OtherState, OtherPostalCode, OtherCountry, OtherStateCode, OtherCountryCode, OtherLatitude, OtherLongitude, OtherGeocodeAccuracy, OtherAddress, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, MailingStateCode, MailingCountryCode, MailingLatitude, MailingLongitude, MailingGeocodeAccuracy, MailingAddress, Phone, Fax, MobilePhone, HomePhone, OtherPhone, AssistantPhone, ReportsToId, Email, Title, Department, AssistantName, LeadSource, Birthdate, Description, EmailBouncedReason, EmailBouncedDate, IsEmailBounced, PhotoUrl, Jigsaw, JigsawContactId, CleanStatus, IndividualId, Level__c, Languages__c, Experiance__c, Subjects__c, Designation__c, Salary__c, Type__c, Parent_Account_Name__c, Birthday__c, Update_Sibling_Address__c, Increment__c, Account_Count__c, Increment_Check__c, Increment_Date__c, Net_Salary__c, Location__Latitude__s, Location__Longitude__s, Location__c FROM Contact WHERE Id IN : VehicleType];
            ListPicklistType.add(conList);
            System.debug('ListPicklistType'+ListPicklistType);
            return ListPicklistType;
        }
        return NULL;
    }
       
   /* @InvocableMethod
    public static List<FlowOutput> CheckValues(List<string> values) {
        //List<List<String>> lst = new List<List<String>>();
        List<FlowOutput> flowOutput = new List<FlowOutput>();
        FlowOutput output = new FlowOutput();
        output.listOfCancelOptions = values[0].split(';');
        flowOutput.add(output);
        System.debug('flowOutput'+flowOutput);
        return flowOutput;
        
       /* List<String> finalLst = new List<String>();
        if(!(values.isEmpty())){            
            for (String tStr : values[0].split(';')) {
                System.debug('tStr'+tStr);
                finalLst.add(tStr);
            } 
        }
        System.debug('result'+[SELECT Id,Name from Contact where Id IN: finalLst LIMIT 200].size());
        //return NULL;
        //
    }
    
    public class FlowOutput{
    @InvocableVariable()
    public List<String> listOfCancelOptions;
}
*/
        
}