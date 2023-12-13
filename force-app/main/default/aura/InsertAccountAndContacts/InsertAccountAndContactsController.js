({
    doInit : function(component, event, helper) {
      var contactList1 = component.get("v.newAccount");
        contactList1.push({
            'Name': '',
            'Type': '',
            'Phone': '',
            'Contacts':[]
        });
        component.set("v.newAccount",contactList1);  
        helper.getPicklistValues(component, event);
    },
    
    addContactBox : function(component, event, helper) {
        console.log('addContact',event.target);
        console.log('addContact',event.getSource().get("v.name"));
        let index2 = event.getSource().get("v.name");
        console.log('addContact'+index2);
        try{
        var accountList = JSON.parse(JSON.stringify(component.get("v.newAccount")));
        let newContact = {
            'FirstName': '',
            'LastName': '',
            'Email': ''};        
            accountList[index2].Contacts.push(newContact);
            component.set("v.newAccount",JSON.parse(JSON.stringify(accountList)));  
        }catch(ex){
            console.log('Error= ',ex);
        }
        console.log("my array= ",component.get("v.newAccount"));
        
    },
    addAccountBox : function(component, event, helper) {
        var accountList = component.get("v.newAccount");
        accountList.push({            
            'Name': '',
            'Type': '',
            'Phone': '',
            'Contacts':[]
        });
        component.set("v.newAccount",accountList);
    },
    
    insertRecords : function(component, event, helper) {
        helper.insertRecordshelp(component, event, helper);
        
    },
    handleOnChange : function(component, event, helper) {
        var industry = component.get("v.newAccount.Type");
    },
    
    getCountryCode : function(component, event, helper) { 
        //var industry = component.get("v.newAccount.Type");
        console.log('event.getParam()');
        var i = '+'+event.getParam('phoneData').fullNumber;
        console.log(i);
    }
})