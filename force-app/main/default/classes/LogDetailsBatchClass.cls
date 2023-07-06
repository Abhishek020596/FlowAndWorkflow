public class LogDetailsBatchClass implements Database.Batchable<sObject> , Database.Stateful{
    String AccountfileDetails = '';
    String ContactfileDetails = '';
    String FileTitle = 'LogId,ObjectName,ErrorMessage';
    
    public Database.QueryLocator start(Database.BatchableContext BC){ 
        return Database.getQueryLocator([SELECT Id, ObjectName__c, Error_Message__c FROM  Log__c]);
	}
    
    public void execute(Database.BatchableContext BC, List<Log__c> logList){
        List<Log__c> updatedName = new List<Log__c>();
        try{
            for(Log__c logs : logList){
                if(logs.ObjectName__c == 'Account'){
                    AccountfileDetails += logs.Id+ ',' + logs.ObjectName__c + ',' + logs.Error_Message__c + '\n';
                }else{
                    ContactfileDetails += logs.Id+ ',' + logs.ObjectName__c + ',' + logs.Error_Message__c + '\n';
                }
            }
        }catch(Exception e){
            System.debug('exception> '+e);
        }
        UPDATE updatedName;
    }
            
     public void finish(Database.BatchableContext BC){
		List<ContentVersion> files = new List<ContentVersion>();
         
         ContentVersion objCV1 = new ContentVersion(
             Title = 'AccountLogData',
             PathOnClient = 'AccountLogData.csv',
             VersionData =  Blob.valueOf(FileTitle+ '\n' + AccountfileDetails)
         );
         files.add(objCV1);
        
         ContentVersion objCV2 = new ContentVersion(
             Title = 'ContactLogData',
             PathOnClient = 'ContactLogData.csv',
             VersionData =  Blob.valueOf(FileTitle+ '\n' + ContactfileDetails)
         );
         files.add(objCV2);
         
         INSERT files;  
         
         EmailClass.messagingEmailMessage('NullPointer','NullPointer', new Set<Id>{files[0].Id, files[1].Id});
     	}
           
         
    }