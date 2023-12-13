public class ContactTriggerHalper {
    
    public static void siblingInsertUpdate(List<Contact> triggerNew){
        Map<id, Contact>  accContactMap = new  Map<id, Contact>();
        for(Contact con : triggerNew){        
            if(con.Update_Sibling_Address__c && con.AccountId != null){
                if(accContactMap.containsKey(con.AccountId)){
                    accContactMap.put(con.AccountId, con);            
                }else{
                    accContactMap.put(con.AccountId, con);
                }           
            }              
        }
    }
    
    public static void siblingUpdate(List<Contact> triggerList, Map<Id, Contact> oldMap){ 
        Map<id, Contact>  accContactMap = new  Map<id, Contact>();
        for(Contact con : triggerList){ 
            Contact conObj = new Contact();
            conObj = oldMap.get(con.Id);
            if(con.MailingCity != conObj.MailingCity ||
               con.MailingCountry != conObj.MailingCountry ||
               con.MailingState != conObj.MailingState ||
               con.MailingPostalCode != conObj.MailingPostalCode){
                   if(con.Update_Sibling_Address__c && con.AccountId != null){
                       if(accContactMap.containsKey(con.AccountId)){
                           accContactMap.put(con.AccountId, con);            
                       }else{
                           accContactMap.put(con.AccountId, con);
                       }           
                   }
              }
        }
    }
    
}