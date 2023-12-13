({
    executeEvent : function(component, event, helper) {
        var comEvent = component.getEvent('SourceComponent');
        alert('Source Event');
        comEvent.fire();
    }
})