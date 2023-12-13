({        
        doInit: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'Account name', fieldName: 'Name', type: 'text'},
            {label: 'Contact Email', fieldName: 'Email_Gmail__c', type: 'email'},
            {label: 'Contact Phone', fieldName: 'Phone', type: 'phone'},
            {label: 'Website', fieldName: 'Website', type: 'url', typeAttributes: { target: '_self'}}
        ]);
            
            var action = cmp.get("c.getAccount");
        	action.setCallback(this, function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                cmp.set('v.data', response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
		
	}
    
    
})