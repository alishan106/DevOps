public class InsertAccountContactController {
    
    @AuraEnabled
    public static Map<String, String> InsertAccCon(String acc){
        Map<String, String> newMap = new Map<String, String>();
        try{
            
            List<Object> listObject = (List<Object>)JSON.deserializeUntyped(acc);
            System.debug('ListObj  = '+listObject);
                        
            Map<Integer,List<Contact>> accountContactIndexMap = new Map<Integer,List<Contact>>();
            List<Account> newAccountList = new List<Account>();
            Integer accountIndex = 0;
            for(Object obj : listObject){
                Map<String,Object> accMap = (Map<String,Object>)obj;
                Account acc1 = new Account();
                acc1.Name = (String)accMap.get('Name');
                acc1.Type = (String)accMap.get('Type');
                acc1.Phone = (String)accMap.get('Phone');
                
                List<Contact> conList= new List<Contact>();
                List<Object> conLst = (List<Object>)accMap.get('Contacts');
                
                for(Object obj1 : conLst){ 
                    Map<String,Object> accMap1 = (Map<String,Object>)obj1;
                    Contact con1 = new Contact();
                    con1.FirstName = (String)accMap1.get('FirstName');
                    con1.LastName = (String)accMap1.get('LastName');
                    con1.Email = (String)accMap1.get('Email');
                    conList.add(con1);
                    system.debug('1234567'+con1);
                    system.debug('asdfghjkl'+conList);
                } 
                system.debug(conList);
                newAccountList.add(acc1);
                accountContactIndexMap.put(accountIndex, conList);
                accountIndex=+1;             
            }
            
            if(!newAccountList.isEmpty()){
                insert newAccountList;
                System.debug('Account insert');
            }
            
            List<Contact> contacts = new List<Contact>();
            for(Integer key : accountContactIndexMap.keySet()){
                for(Contact con : accountContactIndexMap.get(key)){
                	con.AccountId = newAccountList.get(key).Id;
                    contacts.add(con);
            	}
            }
                       
            if(!contacts.isEmpty()){
                insert contacts;
                System.debug('contact insert');
            }
            newMap.put('status', 'success');
            newMap.put('message', 'Contact Inserted Successfully');
        }
        catch(exception e){
            newMap.put('status', 'error');
            newMap.put('message', e.getMessage());
        }
        return newMap;
    }
    
     @AuraEnabled 
    public static Map<String, String> getIndustryFieldValue(){
        Map<String, String> options = new Map<String, String>();
        
        Schema.DescribeFieldResult fieldResult = Account.Type.getDescribe();
        
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            
            options.put(p.getValue(), p.getLabel());
        }
        System.debug(options);
        return options;
    }

}