public class CheckUncheckAllCntrl {
    public Boolean mainBoxValue{get;set;}
    public List<CheckBoxWrapper> wrapperAccList{get;set;}
    public List<Account> accountList{get;set;} 
    
    public CheckUncheckAllCntrl(){
        wrapperAccList = new List<checkBoxWrapper>();
        for(Account acc :[select id,Name,Email_Gmail__c ,Phone from Account]){
            wrapperAccList.add(new CheckBoxWrapper(false,acc));
        }
    }
    
    public void checkUncheckAll(){
        for(CheckBoxWrapper wrapObj : wrapperAccList){
            wrapObj.flag = mainBoxValue;
        }
    }
    public void checkUncheckMainValue(){
        Integer count = 0;
        for(CheckBoxWrapper wrapObj : wrapperAccList){
            if(wrapObj.flag){
                count+=1;
            }
        }
        if(count == wrapperAccList.size()){
            mainBoxValue = true;
        }
        else{
            mainBoxValue = false;
        }
    }
    public class CheckBoxWrapper{
        public Boolean flag{get;set;}
        public Account accObj{get;set;}
        
        public CheckBoxWrapper(Boolean flagValue,Account accObj){
            this.flag = flagValue;
            this.accObj = accObj;
        }
    }
    public void selectedRecords(){
        accountList = new List<Account>();
        for(CheckBoxWrapper wrapObj : wrapperAccList){
            if(wrapObj.flag){
                accountList.add(wrapObj.accObj);
            }
        }
    }
}