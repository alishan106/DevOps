/* @RestResource(urlmapping='/upgateAggriment/*')
public class AggrimentCheckController {
    public String recordId {get;set;}
    public Boolean checkBoxValue {get;set;}
    
    public void updateAggriment(){        
        for(Aggriment__c ag : [SELECT id, Accept_Terms__c FROM Aggriment__c WHERE id =:recordId]){
        ag.Accept_Terms__c = checkBoxValue;
        update ag;   
        }        
    } 
}
    
@RestResource(urlmapping='/upgateAggriment/*')
global class AggrimentCheckController {
    public Boolean checkBoxValue {get;set;}
    @HttpPost
    global static void updateAggriment(){
       RestRequest req = RestContext.request;
       RestResponse res = RestContext.response;
        String urlId = req.requestURI.subString(req.requestURI.lastIndexOf('/')+1);
        for(Aggriment__c ag : [SELECT id, Accept_Terms__c FROM Aggriment__c WHERE id =:urlId]){
        ag.Accept_Terms__c = checkBoxValue;
        update ag;   
        }
    }
}

*/

public class AggrimentCheckController {    
        public Boolean checkBoxValue {get;set;}
    	public string recordId {get;set;}
        
    public void updateAggriment(){
        System.debug('-----'+recordId+''+checkBoxValue);
        HttpRequest newReq = New HttpRequest();        
        String endPoint = 'https://ibirdssoftwareservicespv-4e-dev-ed.my.salesforce.com/services/data/v34.0/sobjects/Aggriment__c/'+recordId;        
        newReq.setEndpoint('https://ibirdssoftwareservicespv-4e-dev-ed.my.salesforce.com/services/oauth2/token?grant_type=password&client_id=3MVG9fe4g9fhX0E5CbpaYlDH5XwjBq.AvnYZeYHQmCAla4jtl..c0uZzroqFh7XRLSmatC7VltDyuDVzlykHy&client_secret=5EB7B4CAA8F153032302829B58767DBE0107E165FE0428FDB99A32513CB75B66&username=alishan106@ibirds.com&password=ibirds@123');
        newReq.setMethod('POST');
        Http http = new http();
        HttpResponse res = new HttpResponse();
        res = http.send(newReq);
        Oauth oauthObj = (Oauth)JSON.deserialize(res.getBody(), Oauth.class);
        if(oauthObj.access_token != NUll){
            HttpRequest req = New HttpRequest();
            req.setEndpoint(endPoint);
            req.setMethod('PATCH');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', 'Bearer '+oauthObj.access_token);
            String bodyContent = '{"Accept_Terms__c" : '+checkBoxValue+'}';
            req.setBody(bodyContent);
            System.debug(bodyContent);
            Http http1 = new http();
            HttpResponse res1 = new HttpResponse();
            res1 = http.send(req);
            System.debug('Info -----'+res1.getBody());
        }
    }
    
    public class Oauth{
        public String access_token{get;set;}
        public String instance_url{get;set;}
        public String id{get;set;}
        public String token_type{get;set;}
        public String issued_at{get;set;}
        public String signature{get;set;}
        
    }

}