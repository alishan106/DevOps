({
	fetchContacts : function(component, event, helper) {
    var action = component.get("c.ConList");
        action.setCallback(this, function(response){
         var state = response.getState();
        if(state === 'SUCCESS'){
            var contactList = response.getReturnValue();
            console.log(JSON.stringify(contactList));
            component.set("v.conList",contactList);
        }
        else{
            alert('Error while getting data');
        }
});
        $A.enqueueAction(action);
    }
    
})