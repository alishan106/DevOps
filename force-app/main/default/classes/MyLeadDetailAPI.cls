@RestResource(urlmapping='/getLeadInfo/*')
global class MyLeadDetailAPI {	
    @HttpGet
    global static Lead getLead(){
       RestRequest req = RestContext.request;
       RestResponse res = RestContext.response;
        String urlId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        Lead Id = [SELECT Id, Name, Email, Industry from Lead where Id =: urlId];
        return Id;
    }

}