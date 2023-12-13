({
    handleClick : function (component, event, helper) {
        //alert("You clicked: " + event.getSource().get("v.label"));
        console.log(''+component.get("v.inpVal"));
        var message = {
            recordId: component.get("v.inpVal"),
            recordData : 'Aura Data'
        }
        component.find("mainMessageChannel").publish(message);
        //component.set("v.msg", event.getParam("recordData").value);
    }
    
});

({
  handleMessage: function(cmp, event, helper) {
    // Read the message argument to get the values in the message payload
    if (event != null && event.getParams() != null) {
      let params = event.getParams();
      cmp.set("v.recordValue", JSON.stringify(params, null, "\t"));
    }
  }
});