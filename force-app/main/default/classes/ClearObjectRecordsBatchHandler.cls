public class ClearObjectRecordsBatchHandler implements Database.Batchable<sObject>, Database.Stateful{
    public List<String> objApiName;
    public String query;
    public Integer objectIndex;

    public ClearObjectRecordsBatchHandler(List<String> sobjectName, Integer previousIndex){
        objApiName = sobjectName;
        objectIndex = previousIndex;
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
        try {
            query = 'SELECT Id FROM ' + objApiName[objectIndex] + ' ORDER BY CreatedDate DESC';
            System.debug('____________index____________' + objectIndex);
            System.debug('____________query____________ ' + query);
        } 
        catch (Exception e) {
            System.debug('+++++exception+++++ ' + e);
        }
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        try {
            List<Database.DeleteResult> deleterecord =  Database.delete(scope);
            AsyncApexJob secondJob = [SELECT Id, 
                                        Status,
                                        JobItemsProcessed,
                                        TotalJobItems, 
                                        NumberOfErrors 
                                        FROM AsyncApexJob WHERE ID =: BC.getJobId()];
            //Creating PE instances
            List<Batch_Event__e> batchIdList = new List<Batch_Event__e>();
            Batch_Event__e batchEvent = new Batch_Event__e();
            batchEvent.ApexJobId__c = BC.getJobId();
            batchEvent.ApexApiName__c = objApiName[objectIndex];
            batchEvent.ApexTotalJobItems__c = secondJob.TotalJobItems;
            batchEvent.ApexJobItemsProcessed__c = secondJob.JobItemsProcessed;
            batchEvent.ApexStatus__c = secondJob.Status;
            batchIdList.add(batchEvent);
            System.debug('+++batchIdList++' + batchIdList);
            // Call method to publish events
            Database.SaveResult[] batchResultList = EventBus.publish(batchIdList); 
        } 
        catch (Exception e) {
        }
    }
    public void finish(Database.BatchableContext BC){
        AsyncApexJob secondJob = [SELECT Id, 
                                        Status,
                                        JobItemsProcessed,
                                        TotalJobItems, 
                                        NumberOfErrors 
        FROM AsyncApexJob WHERE ID =: BC.getJobId()];
        //Creating PE instances
        List<Batch_Event__e> batchIdList = new List<Batch_Event__e>();
        Batch_Event__e batchEvent = new Batch_Event__e();
        batchEvent.ApexJobId__c = BC.getJobId();
        batchEvent.ApexApiName__c = objApiName[objectIndex];
        batchEvent.ApexTotalJobItems__c = secondJob.TotalJobItems;
        batchEvent.ApexJobItemsProcessed__c = secondJob.JobItemsProcessed;
        batchEvent.ApexStatus__c = secondJob.Status;
        batchIdList.add(batchEvent);
        System.debug('+++batchIdList++' + batchIdList);
        // Call method to publish events
        Database.SaveResult[] batchResultList = EventBus.publish(batchIdList); 

        if (objectIndex < objApiName.size()-1){
             System.debug('__________objApiName__________' + objApiName);
             ClearObjectRecordsBatchHandler clearObj = new ClearObjectRecordsBatchHandler(objApiName,++objectIndex);
             Database.executeBatch(clearObj);
         }
    }
}