public class QBCallout {
    // private String accessToken{get;set;}
    // private String refreshToken{get;set;}

    public static void getDataFromQB(String objectName, String companyId, String id){
        String accessToken = getAccessToken();
        System.debug('Entering getCompanyDetails Method::::');
        String endPoint = 'https://sandbox-quickbooks.api.intuit.com/v3/company/'+companyId+'/'+objectName.toLowercase()+'/'+id;
        // String endPoint = 'https://sandbox-quickbooks.api.intuit.com/v3/company/4620816365268580490/customer/77';

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint(endPoint);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer '  + accessToken);
        req.setheader('Accept', 'application/json');
        res = h.send(req);
        System.debug('res===>'+res.getBody());
        
        Map<String, Object> webhookData = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

        JSON2Apex custorData = JSON2Apex.parse(res.getBody());
        Map<String, Object> outputData = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        Map<String, Object> cusData = (Map<String, Object>) outputData.get('Customer');
        System.debug('Output' +outputData.get('Customer'));
        System.debug('cusData'+ cusData.keySet());
        System.debug('cusData'+ cusData.get('DisplayName'));

        
        if(objectName == 'account'){
            QB_Transaction__c qbojb = new QB_Transaction__c();
            Map<String, Object> subacc = (Map<String, Object>)webhookData.get('Account');
            qbojb.Account_AccountSubType__c = (String) subacc.get('AccountSubType');
            qbojb.Account_AccountType__c = (String) subacc.get('AccountType');
            qbojb.Account_Name__c = (String) subacc.get('Name');
            System.debug('Qbo===>'+qbojb);
            
            INSERT qbojb;
        }

        else if(objectName == 'customer')
        {
            QB_Transaction__c qbojb = new QB_Transaction__c();
            Map<String, Object> customerData = (Map<String, Object>)webhookData.get('Customer');
            qbojb.Customer_Id__c = (String) customerData.get('Id');
            qbojb.Customer_DisplayName__c = (String) customerData.get('DisplayName');
            System.debug('Qbo===>'+qbojb);
            
            INSERT qbojb;
        }
    }

    public static String getAccessToken(){

        QB_Credentials__mdt qbCredential = [SELECT endPoint__c, client_id__c, secretId__c, refresh_token__c FROM QB_Credentials__mdt];
        String endPoint = qbCredential.endPoint__c;
        String clientId = qbCredential.client_id__c;
        String secretId = qbCredential.secretId__c;
        String refresh_token = qbCredential.refresh_token__c;
        String header = 'Basic '+ EncodingUtil.base64Encode(Blob.valueOf(clientId + ':' + secretId));
        String body = 'grant_type=refresh_token&refresh_token=' + refresh_token;
        System.debug('Header:::::----' +header);

        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setEndpoint(endPoint);
        req.setBody(body);
        req.setMethod('POST');
        req.setHeader('Authorization', header);
        req.setheader('Content-Type', 'application/x-www-form-urlencoded');
        res = h.send(req);
        System.debug('res===>'+res.getBody());

        Map<String, Object> jsonString = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        String accessToken;

        for(String key:jsonString.keySet()){
            System.debug('key>>>>>'+key);
            if(key=='access_token'){
                System.debug('key>>>access_token>>>>'+jsonString.get(key));
                accessToken = (String)jsonString.get(key);
            }
        }
        System.debug('jsonString>>>>>>>>' +jsonString);
        return accessToken;
    }
    public QBCallout(){
    }
}