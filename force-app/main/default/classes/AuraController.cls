public class AuraController 
{   
    @AuraEnabled
    public static void saveAccountList(List<Account> accList) 
	{        
        Insert accList;
    }
}