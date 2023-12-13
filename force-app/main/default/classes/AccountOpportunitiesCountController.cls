public class AccountOpportunitiesCountController {
    public List<Account> accountList {get;set;}
    
    public AccountOpportunitiesCountController(){
    accountList = [SELECT Name, (SELECT id FROM opportunities) FROM Account];
    }
}