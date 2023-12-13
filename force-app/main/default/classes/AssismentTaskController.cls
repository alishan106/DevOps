public class AssismentTaskController {

    @auraEnabled(cacheable=true)
    public static List<Account> fetchAccount()
    {
        List<Account> accList=[SELECT Id,Name FROM Account LIMIT 10000];
        return accList;
    }
    @auraEnabled
    public static List<Contact> getContacts(String accountId)
    {
        List<Contact> conList=[SELECT Id,LastName,FirstName,AccountId FROM Contact WHERE AccountId=:accountId LIMIT 10000];
        return conList;
    }
    @auraEnabled
    public static List<Task> fetchTask(String contactId)
    {
        List<Task> taskList =[SELECT Id, WhoId, Subject, CreatedBy.Name, ActivityDate,Status from Task where WhoId =:contactId LIMIT 10000];
        return taskList;
    } 

}