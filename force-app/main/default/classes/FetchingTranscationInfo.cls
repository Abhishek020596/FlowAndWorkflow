/*
Author                         					 : Abhishek
Date                           					 : 23-03-2023
Class Name                    					 : FetchingTranscationInfo
________________________________________________________________________________
*/

public class FetchingTranscationInfo implements Database.Batchable<sObject>, Database.Stateful {
    String successFileData = '';
    String failedFileData = '';
    String successheader = 'ServiceName,SVCID,OrderID,CaseID';
    String failedheader = 'ServiceName,SVCID,OrderID';
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([SELECT Id, Description__c, Error_Message__c FROM Log__c]);
    }
    public void execute(Database.BatchableContext BC, List<Log__c> scope){
        Set<Id> caseIds = new Set<Id>();
        Map<String, String> caseValues = new Map<String, String>();
        Map<String, Object> acctMapValue = new Map<String, Object>();
        Map<String, Object> txcnMapValue = new Map<String, Object>();
        Map<String, Object> eventMapValue = new Map<String, Object>();
        Map<String, Object> attributeMapValue = new Map<String, Object>();
        Map<String, String> keyMapValue = new Map<String, String>();
        List<Object> objList = new List<Object>();
        List<Object> attributeList = new List<Object>();
        Set<String> successStatusValue = new Set<String>();
        Set<String> failStatusValue = new Set<String>();
        
        try{
            for(Log__c cass : scope){
                caseValues.put(cass.id, cass.Description__c);
            }
            for(String act : caseValues.values()){
                String cpqId ='';
                acctMapValue = (Map<String, Object>)JSON.deserializeUntyped(act);
                if(acctMapValue.containskey('SalesforceCPQ')){
                    objList = (List<Object>)acctMapValue.get('SalesforceCPQ');
                    for(Object obj : objList){
                        txcnMapValue = (Map<String, Object>)obj;
                        if(txcnMapValue.containsKey('TransactionInfo')){
                            eventMapValue = (Map<String, Object>)txcnMapValue.get('TransactionInfo');
                            if(eventMapValue.containsKey('attributes')){
                                cpqId = String.valueOf(eventMapValue.get('cpq_id'));
                                cpqId = cpqId.split('_')[0];
                                attributeList = (List<Object>)eventMapValue.get('attributes');
                                String statusVal = (String)eventMapValue.get('status');
                                if(statusVal == 'SUCCESS'){
                                    successStatusValue.add(cpqId);
                                }else{
                                    failStatusValue.add(cpqId);
                                }
                            }
                        }
                    }
                    for(Object obb : attributeList){
                        attributeMapValue = (Map<String, Object>)obb;
                        if(cpqId.startsWith('ON')){
                            if(attributeMapValue.containsKey('Key') && attributeMapValue.get('Key') == 'SERVICE_ID'){
                                keyMapValue.put((String)attributeMapValue.get('Key'),(String)attributeMapValue.get('Value')); 
                            }
                        }
                        else if(attributeMapValue.containsKey('Key') && attributeMapValue.get('Key') == 'FAILUREPOINT'){
                            keyMapValue.put(cpqId, (String)attributeMapValue.get('Value')); 
                        }
                    }
                }
            }
            //System.debug('____________keyMapValue1______________' +keyMapValue); 
            getSVCId(keyMapValue);
           // System.debug('successStatusValue_______________' +successStatusValue);
           // System.debug('failStatusValue_______________' +failStatusValue);
            getSuccess(successStatusValue);
            getFailed(failStatusValue);
        }catch(Exception e){
            System.debug('Exception' +e);
        }
    }
    public void getSVCId(Map<String, String> svcid){
        List<ServiceRequest__c> serviceList = [SELECT Id, SVCId__c, Error_Message__c FROM ServiceRequest__c WHERE SVCId__c IN: svcid.keySet()];
        for(ServiceRequest__c service : serviceList){
            service.Error_Message__c = svcid.get(service.SVCId__c);
        }
        UPDATE serviceList;
    }
    public void getSuccess(Set<String> svcid){
        Set<Id> orderIds = new Set<Id>();
        Set<Id> caseIds = new Set<Id>();
        List<ServiceRequest__c> serviceList = [SELECT Id, Name, Order__c, CaseValue__c FROM ServiceRequest__c WHERE SVCId__c IN: svcid];
       // System.debug('_________________serviceList___________' +serviceList);
        for(ServiceRequest__c service : serviceList){
            if(service.Order__c != null){
                orderIds.add(service.Order__c);
            }
            if(service.CaseValue__c != null){
                caseIds.add(service.CaseValue__c);
            }
            successFileData += service.Name + ',' + service.Id+ ',' + service.Order__c + ',' + service.CaseValue__c + '\n';
            //System.debug('_____________successFileData_________________' +successFileData);
        }
        List<Order> orderList = [SELECT Id, Status FROM Order WHERE id IN: orderIds];
       // System.debug('_____________orderList___________' +orderList);
        for(Order org: orderList){
            org.status = 'Completed';
        }
        List<Case> caseList = [SELECT Id, Status FROM Case WHERE id IN: caseIds];
       // System.debug('_____________caseList___________' +caseList);
        for(Case cas: caseList){
            cas.status = 'Closed';
        }
        try{
            UPDATE caseList;
            UPDATE orderList;
        }catch(Exception e){
            System.debug('Exception'+ e.getMessage());
        }
    }
    public void getFailed(Set<String> svcid){
        Set<Id> orderIds = new Set<Id>();
        List<ServiceRequest__c> serviceList = [SELECT Id, Name, Order__c, CaseValue__c FROM ServiceRequest__c WHERE SVCId__c IN: svcid];
       // System.debug('_________________serviceList___________' +serviceList);
        for(ServiceRequest__c service : serviceList){
            if(service.Order__c != null){
                orderIds.add(service.Order__c);
            }
            failedFileData += service.Name + ',' + service.Id+ ',' + service.Order__c + '\n';
           // System.debug('_____________failedFileData_________________' +failedFileData);
        }
        List<Order> orderList = [SELECT Id, Status FROM Order WHERE id IN: orderIds];
       // System.debug('_____________orderList___________' +orderList);
        for(Order org: orderList){
            org.status = 'FAILED';
        }
        try{
            UPDATE orderList;
        }catch(Exception e){
            System.debug('Exception'+ e.getMessage());
        }
    }  
    public void finish(Database.BatchableContext BC){
        List<ContentVersion> files = new List<ContentVersion>();
        ContentVersion objSuccess = new ContentVersion(
            Title = 'SuccessFileData',
            PathOnClient = 'success.csv',
            VersionData =  Blob.valueOf(successheader+ '\n' + successfileData) 
        );
        files.add(objSuccess);
        
        ContentVersion objFailed = new ContentVersion(
            Title = 'FailedFileData',
            PathOnClient = 'failed.csv',
            VersionData =  Blob.valueOf(failedheader+ '\n' + failedfileData) 
        );
        files.add(objFailed);
        INSERT files;
        
        EmailClass.messagingEmailMessage('FetchingTransactionInfo','FileData', new Set<Id>{files[0].Id, files[1].Id});   
    } 
}