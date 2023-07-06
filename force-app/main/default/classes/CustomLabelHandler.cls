public class CustomLabelHandler {
    @AuraEnabled
    public static List<String> retrieveCustomValue(String searchkey){
        List<String> customList = new List<String>();
        List<Object> jsonList = new List<Object>();
        Map<String, Object> recordMap = new Map<String, Object>();
        System.debug('___________searchKey____________' +searchKey);
        String key = searchKey;
        
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        String domainUrl=URL.getSalesforceBaseUrl().toExternalForm();
        system.debug('__________domainUrl____________:'+domainUrl);
        req.setEndpoint(domainUrl+'/services/data/v57.0/tooling/query/?q=Select+id,Name,Value+from+CustomLabel+WHERE+Name+LIKE+\''+key+'\'');
        req.setMethod('GET');
        
        Http h = new Http();
        HttpResponse res = h.send(req);
        // string responseBody = res.getBody();
        // system.debug('__________responseBody____________:'+responseBody); 
        Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        system.debug('__________responseBody____________:'+jsonMap);
        jsonList = (List<Object>)jsonMap.get('records');
        system.debug('__________newresponseBody____________:'+ jsonList);
        for(Object obj  :  jsonList){
            recordMap = (Map<String, Object>)obj;
        }
        System.debug('+++++recordMap+++++ ' + recordMap);
        System.debug('+++++recordMap+++++ ' + recordMap.get('Id'));
        System.debug('+++++recordMap+++++ ' + recordMap.get('Name'));
        
        customList.add(String.valueOf(recordMap.get('Name')));
        System.debug('____________customList_________________:'+ customList);
        return customList;
    }  
    /*@AuraEnabled
    public static boolean createCustomLabel(string csname,string value,boolean isProtected){
        List<MetadataService.Metadata> allMetadataList = new List<MetadataService.Metadata>();
        MetadataService.MetadataPort service = createService();
        MetadataService.CustomLabel csLabel = new MetadataService.CustomLabel();
        csLabel.fullName = csname;
        csLabel.protected_x  = isProtected;
        csLabel.value=value;
        allMetadataList.add(csLabel);
        List<MetadataService.SaveResult> results = service.createMetadata(allMetadataList);
        for(MetadataService.SaveResult result: results){
            system.debug('update custom label results success='+result.success);
        }
        return results[0].success;
    }*/
    /* @AuraEnabled
    public static boolean updateCustomLabel(string csname,string language,string value,boolean isProtected){
        List<MetadataService.Metadata> allMetadataList = new List<MetadataService.Metadata>();
        MetadataService.MetadataPort service = createService();
        MetadataService.CustomLabel csLabel = new MetadataService.CustomLabel();
        csLabel.fullName = csname;
        csLabel.language = language;
        csLabel.protected_x  = isProtected;
        csLabel.value=value;
        allMetadataList.add(csLabel);
        List<MetadataService.SaveResult> results = service.updateMetadata(allMetadataList);
        for(MetadataService.SaveResult result: results){
            system.debug('update custom label results success='+result.success);
        } 
        return results[0].success;
    } */
    @AuraEnabled
    public static void updateField()
    {
        MetadataService.MetadataPort service = createService();
        MetadataService.CustomField customField = new MetadataService.CustomField();
        customField.fullName = 'Test__c.TestField__c';
        customField.label='New Test Field Label';
        List<MetadataService.SaveResult> results =
            service.updateMetadata(
                new MetadataService.Metadata[] { customField });
        // handleSaveResults(results[0]);
    }
    private static MetadataService.MetadataPort createService(){ 
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId(); 
        return service;     
    }
}