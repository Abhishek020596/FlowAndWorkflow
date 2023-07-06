public class PostalPincodeHandler {
    @AuraEnabled(cacheable = true)
    public static List<Object> fetchingPincodeValue(String pincode){
        if (pincode.isNumeric()) {
            pincode = 'pincode/'+ pincode;
        } else {
            pincode = 'PostOffice/'+ pincode.replaceAll(' ', '%20');
        }
        Http http = new Http();
        System.debug('_________else part___________' +pincode);
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.postalpincode.in/'+pincode);
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept','application/json');
        request.setMethod('GET');
        System.debug('Request body_________________' +request);
        HttpResponse response = http.send(request);
        System.debug('response_________________' +response);
        System.debug('response__________________'+response.getStatusCode());
        List<Object> results = (List<Object>)JSON.deserializeUntyped(response.getBody());
        System.debug('results__________________'+ results);
        return results;
    }
}