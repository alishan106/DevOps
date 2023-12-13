({
    doInit: function (component, event, helper) {
        var action = component.get('c.getContactList');
        var map = [];
        for (var i = 0; i < 5; i++) {
            map.push({
                key: i,
                value: 'test' + i
            })
        }
        action.setParams({

        });
        action.setCallback(this, function (resopnse) {
            var respon = resopnse.getReturnValue();
            component.set('v.object', respon)
        }, 'SUCCESS');
        $A.enqueueAction(action, false);
        component.set('v.mapName', map);
    }
    ,
    saveCon: function (component, event, helper) {

        var action = component.get('c.saveContact');
        console.log(JSON.stringify(component.get('v.sObject')));
        action.setParams({
            con: component.get('v.sObject')
        });

        var validateCon = component.find('conFrm').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            inputCmp.set('v.validity', { valid: false, badinput: true });
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        if (validateCon) {
            action.setCallback(this, function (resopnse) {
                var respon = resopnse.getState();
                alert(respon);
            }, 'ALL');
            $A.enqueueAction(action);
        }
        // else{
        //     alert('required field missing');
        // }
    },
    getMyId: function (component, event, helper) {
        var ids = event.getSource('').get('v.value');
        component.set('v.recordId', ids);
        component.set('v.isModalOpen', true);

    },
    navigateUrl: function (component, event, helper) {
        var ids = event.getSource('').get('v.value');
        component.set('v.recordId', ids);
        console.log('ids', ids);
        var pageRef = component.find('navigation');
        var nav = {
            type: 'standard__recordPage',
            attributes: {
                recordId: ids,
                actionName: 'view'
            }
        };
        event.preventDefault();
        pageRef.navigate(nav);
    },

    closeModel: function (component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
    },

    submitDetails: function (component, event, helper) {
        // Set isModalOpen attribute to false
        //Add your code to call apex method or do some processing
        component.set("v.isModalOpen", false);
    },
})