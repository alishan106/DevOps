@RestResource(urlmapping='/getAccountInfo/*')
global class FirstWebServicesApex {	
    @HttpGet
    global static Account getAccount(){
       RestRequest req = RestContext.request;
       RestResponse res = RestContext.response;
        String urlId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        Account Id = [SELECT Id, Name from Account where Id =: urlId];
        return Id;
    }

}