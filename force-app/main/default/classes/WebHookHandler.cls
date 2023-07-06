@RestResource(urlMapping='/WebHookHandler/*')
global class WebHookHandler {
    
    @HttpPost
    global static void handlerWebHook(){
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;

        String xIntuitSignature = request.headers.get('x-intuit-signature');
        System.debug('=====>>>>>'+xIntuitSignature);
        response.addHeader('Content-Type','application/json');

        String requestBody = RestContext.request.requestBody.toString();

        Map<String,Object> webhookData = (Map<String,Object>)JSON.deserializeUntyped(requestBody);
        List<object> eventNotification = (List<Object>) webhookData.get('eventNotifications');
        Map<String,Object> eventJSON = (Map<String,Object>) eventNotification[0];
        MAP<String,Object> dataChangeEvent = (Map<String,Object>) eventJSON.get('dataChangeEvent');
        List<Object> changedEntity = (List<Object>) dataChangeEvent.get('entities');
        Map<String,Object> entityData = (Map<String,Object>)changedEntity[0];

        String name = (String) entityData.get('name');
        String id = (String) entityData.get('id');
        String op = (String) entityData.get('operation');
        String realmId = (String) eventJSON.get('realmId');

        QBCallout.getDataFromQB(name,realmId,id);
        System.debug('realmId'+realmId);
        System.debug('name'+name);
        System.debug('id'+id);

        response.responseBody = Blob.valueOf('{success:true}');
        response.statusCode = 200;

        String expectedVerifierToken = '6ee20110-c84a-4dd2-abbb-edcecad278c8';

        if(xIntuitSignature!= expectedVerifierToken){
            response.statusCode = 401;
            return;
        }
    }
    @HttpGet
    global static String doGet(){
        return '{"Message":"Welcome"}';
    }
}