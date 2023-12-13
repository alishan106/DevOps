({
  handleMessage: function(cmp, event, helper) {
    if (event != null && event.getParams() != null) {
      let params = event.getParams().recordId;
      cmp.set("v.recordValue", params);
    }
  }
});