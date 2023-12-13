({
    insertRecordshelp : function(component, event, helper) {
        console.log('QQQQQ');    
        var account = component.get("v.newAccount");
        console.log(JSON.stringify(account));
        var toastEvent = $A.get('e.force:showToast');
        var createAction = component.get("c.InsertAccCon");
        createAction.setParams({
            acc : JSON.stringify(account)
        });
        console.log('QQQQQ1');
        createAction.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var dataMap = response.getReturnValue();
                if(dataMap.status == 'success'){
                    toastEvent.setParams({
                        'title':'Success',
                        'type':'success',
                        'mode':'dismissable',
                        'message':dataMap.message                        
                    });
                    toastEvent.fire();
                    window.location.reload();
                }
                else if(dataMap.status == 'error'){
                 toastEvent.setParams({
                        'title':'Error',
                        'type':'error',
                        'mode':'dismissable',
                        'message':dataMap.message                        
                    });   
                    toastEvent.fire();
                }
            }else{
                alert('Error in Inserting');
            }
            });
        console.log('QQQQQ2');
      $A.enqueueAction(createAction);
    },
    getPicklistValues: function(component, event) {
        var action = component.get("c.getIndustryFieldValue");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var fieldMap = [];
                for(var key in result){
                    fieldMap.push({key: key, value: result[key]});
                }
                component.set("v.fieldMap", fieldMap);
            }
        });
        $A.enqueueAction(action);
    },
})