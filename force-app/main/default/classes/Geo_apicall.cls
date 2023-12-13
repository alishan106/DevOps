public class Geo_apicall {
    @future(callout=true)
    public static void parseJSONResponse() {     
        String address='Kharadi+Pune+Maharastra';
        String key='AIzaSyC5Z3twwN_hX_uP1JrDnY_726nH26Zb058';
        Http httpProtocol = new Http();
        // Create HTTP request to send.
        HttpRequest request = new HttpRequest();
        // Set the endpoint URL.
        String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?address='+address+'&key='+key;
        request.setEndPoint(endpoint);
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        // The response is in JSON format.
        HttpResponse response = httpProtocol.send(request);
        System.debug('####Body : '+response.getBody());
   
    }   
}