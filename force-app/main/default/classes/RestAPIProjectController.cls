public class RestAPIProjectController {
    public String recordId {get;set;}
    public String selectedMethod {get;set;}
    public String selectedObject {get;set;}
    public String result {get;set;}
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--NONE--'));
        options.add(new SelectOption('getRecord','GET Records'));
        options.add(new SelectOption('insertRecords','Insert Records'));
        options.add(new SelectOption('updateRecords','Update Records'));
        return options;
    }
    
    public List<SelectOption> getobjItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','--NONE--'));
        options.add(new SelectOption('Account','Account'));
        options.add(new SelectOption('Contact','Contact'));
        options.add(new SelectOption('Lead','Lead'));
        return options;
    }
    
    
    public void updateAggriment(){
        HttpRequest newReq = New HttpRequest();        
        String endPoint = 'https://ibirdsservices-d-dev-ed.lightning.force.com/services/data/v34.0/sobjects/'+selectedObject+'/'+recordId;        
        newReq.setEndpoint('https://ibirdsservices-d-dev-ed.lightning.force.com/services/oauth2/token?grant_type=password&client_id=3MVG9fe4g9fhX0E6IvFng3YupDsxWe8zjEgu4wA0VllOCCl7nrV0B6k6GaN.zxNB39tlz0pcWx2wWdMoiCRbj&client_secret=C4822181C7D35E642F9AE797EB9F4A362D92CCA075833B9756FAE324862C05C9&username=shanibirds106@ibirds.com&password=ibirds@123');
        newReq.setMethod('POST');
        Http http = new http();
        HttpResponse res = new HttpResponse();
        res = http.send(newReq);
        System.debug('-----'+res.getBody());
        Oauth oauthObj = (Oauth)JSON.deserialize(res.getBody(), Oauth.class);
        if(oauthObj.access_token != NUll){
            HttpRequest req = New HttpRequest();
            req.setEndpoint(endPoint);
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', 'Bearer '+oauthObj.access_token);
            /*String bodyContent = '{"Accept_Terms__c" : '+checkBoxValue+'}';
            req.setBody(bodyContent);
            System.debug(bodyContent);*/
            Http http1 = new http();
            HttpResponse res1 = new HttpResponse();
            res1 = http.send(req);
            result = res1.getBody();
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