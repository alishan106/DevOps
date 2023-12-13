({
	saveCon : function(component, event, helper) {
        var fName = component.get("v.firstName");
        var lName=component.get("v.lastName");
        var email=component.get("v.email");
        var phone=component.get("v.phone");
        if(!fName || !lName || !email || !phone){
            //alert(fName);
            //var input = component.find("myFirst").getElement().focus();
            //component.find('myFirstName').reportValidity();
            var scrollOptions = {
            left: 0,
            top: 10,
            behavior: 'smooth'
        }
            //component.find("focus").getElement().focus();
            //this.superAfterRender();
            //var scroller = component.find('focus').getElement();
            //scroller.scrollTop=0;
        	//scroller.scrollTo(0,0);
            //window.onload = document.getElementById('myFirstName').scrollIntoView(true);
            //component.find('myFirst').scrollIntoView(true);
        	window.scrollTo(scrollOptions);
            
            
            var allValid = component.find('myFirstName').reduce(function (validSoFar, inputCmp) {
                inputCmp.reportValidity();
                return validSoFar && inputCmp.checkValidity();
            }, true);
        }
            //var fName = component.find("fNameFrm").getSource();
            //fName.setCustomValidity("field missing");
        //}else if(lName){
            //alert(fName);
        //}else if(email){
            //alert(email);
        //}else if(phone){
           // alert(phone);
        //}
        
	}
})