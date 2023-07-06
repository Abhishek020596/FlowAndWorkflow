public class DeleteObjectUsingBatchClass implements Database.Batchable<sObject>,Database.Stateful{
    public String objApiName;
    public String query;
    public Integer jobCount = 0;
    public Integer failedJobs = 0;

    public DeleteObjectUsingBatchClass(String sObjectName){
        objApiName = sObjectName;
    } 
    public Database.QueryLocator start(Database.BatchableContext BC){
        try{
            query = 'SELECT Id FROM ' + objApiName;

        }catch(Exception ex){
            System.debug('_________Exception__________' +ex);
        }
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        try {
            jobCount += scope.size();
            System.debug('___________jobCount______________'+ jobCount);
            List<Database.DeleteResult> deleterecord =  Database.delete(scope);
        } catch (Exception e) {
            System.debug('___________Exception_____________' +e.getMessage());                
        }                           
    }
    public void finish(Database.BatchableContext BC){
        ClearLogDetails__c logDetails = new ClearLogDetails__c();
            logDetails.BatchId__c = BC.getJobId();
            logDetails.JobCount__c = jobCount;
            logDetails.ObjectName__c = objApiName;
            logDetails.ProcessTime__c = System.now();
            logDetails.FailedJobs__c = failedJobs;
        INSERT logDetails;
    }   
}