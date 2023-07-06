public class SearchObjectUsingCustomMetaDataHandler {
	@AuraEnabled(cacheable=true)
    public static List<SearchingObjects__mdt> retrieveMetaValue(){
        List<SearchingObjects__mdt> queryValues = [SELECT Id,Fields__c,ObjectName__c, SearchFieldName__c from SearchingObjects__mdt];
        System.debug('____________queryValues____________'+queryValues);
        return queryValues;
    }
    @AuraEnabled(cacheable=true)
    public static List<sObject> getAllRecords(String searchKey, String objectName, String fields){
        System.debug('__________searchKey__________'+ searchKey);
        if(searchKey == null || searchKey == ''){
            System.debug('_________Inside IF___________'+searchKey);
            return new List<sObject>();
        }
        String key = '%'+ searchKey + '%';
        String query = 'SELECT ' + fields + ' FROM ' + objectName + ' WHERE Name LIKE :key';
        System.debug('___________queryObjectValues____________' +query);
        return Database.query(query); 
    }
}