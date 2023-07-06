public class ClearLogdetailsHandler {
    @AuraEnabled
    public static void searchingAllObjects(String label){
        try {
            Database.executeBatch(new DeleteObjectUsingBatchClass(label));
            System.debug('_____________label_________________'+ label);
        }catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<ClearLogDetails__c> retrieveCustomObjectData(){
        try {
            return [SELECT Id, BatchId__c, ObjectName__c, JobCount__c, ProcessTime__c, FailedJobs__c FROM ClearLogDetails__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}