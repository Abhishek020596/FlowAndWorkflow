public class ProductsApiHandler {
    
    @AuraEnabled(cacheable = true)
    public static List<Map<String,Object>> fetchingProducts(){
        List<Map<String,Object>> listValues = new List<Map<String,Object>>();
        for(Integer i=1; i<=5; i++){
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://dummyjson.com/products/'+ i);
            request.setHeader('Content-Type', 'application/json');
            request.setHeader('Accept','application/json');
            request.setMethod('GET');
            System.debug('Request body_________________' +request);
            HttpResponse response = http.send(request);
            System.debug('response_________________' +response);
            System.debug('response__________________'+response.getStatusCode());
            Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            System.debug('results__________________'+ results);
            listValues.add(results);
        }
        return listValues;
    }
}