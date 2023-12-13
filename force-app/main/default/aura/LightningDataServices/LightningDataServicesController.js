({
	doInit : function(component, event, helper) {
        
		component.find("recordCreator").getNewRecord(
            "Account", 
            null,      
            false,    
            $A.getCallback(function() {
                var rec = component.get("v.recordObject");
                var error = component.get("v.recordCreateError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                }
                else {
                    console.log("Record inserted sucessfully");
                    //alert('Record inserted sucessfully');
                }
            })
        );
	},
    
    onSave : function(component, event, helper) {
        component.find('recordCreator').saveRecord(function(saveResult){
        if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Order Placed",
                    "message": "Your Order has been successfully placed.",
                    "type" : "success"
                });
                resultsToast.fire();
            } else if (saveResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                console.log('Problem saving contact, error: ' + 
                            JSON.stringify(saveResult.error));
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Error While Placing Your Order.",
                    "message": JSON.stringify(saveResult.error),
                    "type" : "success"
                });
                resultsToast.fire();
            } else {
                console.log('Unknown problem, state: ' + saveResult.state +
                            ', error: ' + JSON.stringify(saveResult.error));
            }
               })
        
        
    }
})