@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req){
        try{
            HttpResponse res= new HttpResponse();
            res.setHeader('Content-Type','application/json');
            res.setBody('{"DailyAsyncApexExecutions":{"Max":40960,"Remaining":3090},"DataStorageMB":{"Max":2000,"Remaining":180},"DailyApiRequests":{"Max":50000,"Remaining":4055}}');
            res.setStatusCode(200);
            return res;
            
        }catch(Exception ex){
            System.debug('ERROR Message>>>'+ex.getMessage()+' Error Line Number>>> '+ex.getLineNumber());
        }
        return null;
    }
}