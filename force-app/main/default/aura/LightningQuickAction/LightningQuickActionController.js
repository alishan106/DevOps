({
    clickAdd: function(component, event, helper) {

        var n1 = component.find('fname').get("v.value");
        var n2 = component.find('lname').get("v.value");
        
         var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": "Full Name " ,
            "message": "The Full Name is: " + n1+" "+n2 + "."
        });
        resultsToast.fire();
        //closeQuickAction
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
    }

})