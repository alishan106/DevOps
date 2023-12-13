public class MergeContactController {
    public List<CheckBoxWrapper> wrapperConList{get;set;}
    public Account account {get;set;}
    public Id selectedAccId{get;set;}
    public List<Contact> checkedContactList{get;set;}
    //public List<Account> accList {get;set;}
    
    public MergeContactController(){
        wrapperConList = new List<checkBoxWrapper>();
        for(Contact acc :[select id,Name,phone,email,AccountId from Contact where AccountId = NULL]){
            wrapperConList.add(new CheckBoxWrapper(acc));
        }
    }
    public List<SelectOption> getAccountNames() {
        List<SelectOption> accOptions= new List<SelectOption>();
        system.debug(selectedAccId);
        accOptions.add( new SelectOption('','--Select--'));
        for(Account acc : [select Id,name from Account ] ) {
            accOptions.add(new SelectOption(acc.Id,acc.name));
        }
        return accOptions;
    }
    
    public PageReference selectedRecords(){
        CheckedContactList = new List<Contact>();
        for(CheckBoxWrapper wrapObj : wrapperConList){
            if(wrapObj.flag && selectedAccId != Null){
                    wrapObj.conObj.AccountId = selectedAccId;
                    checkedContactList.add(wrapObj.conObj);
                }
        }
        if(checkedContactList.size() > 0){
            update checkedContactList;
        }
                
        PageReference pgref = new PageReference('/apex/merge_contact');
        pgref.setRedirect(true);
        return pgref; 
    }
    
    public void accountSelect(){
       // accList = new List<Account>();
        if(selectedAccId != null){
        account = [Select Id, Name, Phone, Email_Gmail__c from Account where id =:selectedAccId];
        }
       // system.debug('!!'+accList);
    }
    
    public class CheckBoxWrapper{
        public Boolean flag{get;set;}
        public Contact conObj{get;set;}
       
        public CheckBoxWrapper(Contact conObj){
            this.conObj = conObj;
        }
    }
}