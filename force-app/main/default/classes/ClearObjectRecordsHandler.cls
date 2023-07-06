public class ClearObjectRecordsHandler {
    @AuraEnabled(cacheable=true)
    public static List<Object> retrieveAllObject(){
        List<Schema.SObjectType> gd = Schema.getGlobalDescribe().Values();
        List<Object> objName = new List<String>();
        for(Schema.SObjectType f : gd){
            objName.add(f.getDescribe().getName()); 
        }
        return objName;
    }
    @AuraEnabled
    public static void retrieveObjectRecords(List<String> objName){ // Account, Task , Case
        ClearObjectRecordsBatchHandler clearObj = new ClearObjectRecordsBatchHandler(objName, 0);
        ID firstBatchId = Database.executeBatch(clearObj);
    }
}