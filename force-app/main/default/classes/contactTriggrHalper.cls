public class contactTriggrHalper{
    
    public static void updateContactEmail(List<Contact> conNewList, List<Contact> conOldList, Map<Id,Contact> conOldMap){
        
        Set<Id> setIdCon = new Set<Id>();
        for(Contact con:conNewList){
            if(conOldMap != NULL){
                if(con.Email != conOldMap.get(con.Id).Email){
                    setIdCon.add(con.AccountId);
                }
            }
            else{
                setIdCon.add(con.AccountId);
            }
        }
        List<Contact> conList = [Select Id, Name, Email, AccountId from Contact Where AccountId IN: setIdCon];
        Map<String, Id> mapIds = new Map<String, Id>();
        for(Contact con:conList){
            mapIds.put(con.Email, con.AccountId);
        }
        Set<Id> setId = new Set<Id>();        
        for(Contact con:conNewList){
            if(mapIds.containsKey(con.Email)){
                setId.add(con.AccountId);
                con.addError('Duplicate Email');
            }	
        }
        /*List<Account> accList = [select Id, Name from Account where Id IN:setId];
        
        for(Account acc:accList){
            system.debug('acc'+acc.Id);
            acc.addError('Duplicate Email');
        }*/
	}
}