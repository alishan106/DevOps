public class AaccountContactInlineController {
    public List<checkBoxWrapper> wrapperConList{get;set;}
    public List<checkBoxWrapper> contactList{get;set;}
    public Integer index{get;set;}
    public Id conId;
    
    public AaccountContactInlineController(ApexPages.StandardController controller){
        conId=controller.getId();
        contactList = new List<checkBoxWrapper>();
        wrapperConList = new List<checkBoxWrapper>();
        for(Contact con :[select id,Name,AccountId ,Phone from Contact where AccountId = NULL]){
            wrapperConList.add(new CheckBoxWrapper(false,con));
        }
    }
    public void selectedRecords(){
        // Integer size = wrapperConList.size();
        
        for(CheckBoxWrapper wrapObj : wrapperConList){
            if(wrapObj.flag){
                contactList.add(new CheckBoxWrapper(true,wrapObj.conObj));
                //system.debug('!!!!!!');
            }
        }
        wrapperConList.remove(index);
    }
    public void putBackWrap(){
        for(CheckBoxWrapper wrapObj : contactList){
            if(!wrapObj.flag){
                wrapperConList.add(new CheckBoxWrapper(false,wrapObj.conObj));
                system.debug('!!!!!!');
            }
        }
        contactList.remove(index);  
    }
    
    public void mergeAccount(){
        List<Contact> conObj = new List<Contact>();
        for(CheckBoxWrapper accMerg : contactList){
            accMerg.conObj.AccountId = conId;
            conObj.add(accMerg.conObj);
        }
        if(contactList.size()>0){
            update conObj;
        }
    }
        public class CheckBoxWrapper{
        public Boolean flag{get;set;}
        public Contact conObj{get;set;}
        
        public CheckBoxWrapper(Boolean flagValue,Contact conObj){
            this.flag = flagValue;
            this.conObj = conObj;
        }
    }
}