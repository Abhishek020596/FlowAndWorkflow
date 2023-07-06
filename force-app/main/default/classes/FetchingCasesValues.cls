public class FetchingCasesValues implements Database.Batchable<sObject>, Database.Stateful{
    String fileData = '';
    String header='CaseID,CaseEventName';
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([SELECT Id, CaseNumber, Subject, Description FROM Case]);
    }
    
    public void execute(Database.BatchableContext BC, List<Case> caseList){
		Set<Id> caseIds = new Set<Id>();
        Map<String, String> caseValues = new Map<String, String>();
        Map<String, Object> acctMapValue = new Map<String, Object>();
        Map<String, Object> txcnMapValue = new Map<String, Object>();
        Map<String, Object> eventMapValue = new Map<String, Object>();
        List<Object> objList = new List<Object>();
        
        try{
            for(Case cass : caseList){
                if(cass.Subject == 'case1'){
                    caseValues.put(cass.id, cass.Description);
                }
            }
            for(String act : caseValues.values()){
                acctMapValue = (Map<String, Object>)JSON.deserializeUntyped(act);
                if(acctMapValue.containskey('SalesforceCPQ')){
                    objList = (List<Object>)acctMapValue.get('SalesforceCPQ');
                    
                    for(Object obj : objList){
                        txcnMapValue = (Map<String, Object>)obj;
                        if(txcnMapValue.containsKey('TransactionInfo')){
                            eventMapValue = (Map<String, Object>)txcnMapValue.get('TransactionInfo');
                            if(eventMapValue.containsKey('status')&& eventMapValue.get('status')=='CriticalEptFailed'){
                                fileData += String.valueOf(eventMapValue.get('cpq_id') + ' , ' +String.valueOf(eventMapValue.get('event_name'))+'\n ');
                                System.debug('fileData========' + fileData);
                            }
                        }
                    }
                }
            }
        }catch(Exception e){
            System.debug('Exception' +e);
        }
        
    }
    
    public void finish(Database.BatchableContext BC){

        ContentVersion objCV = new ContentVersion(
            Title = 'CaseValueFile',
            PathOnClient = 'CaseValueFile.csv',
            VersionData =  Blob.valueOf(header+ '\n' + fileData) 
        );
        INSERT objCV;
        
        EmailClass.messagingEmailMessage('CaseValueFile', 'Successful', new Set<Id>{objCV.Id}); 
    }
}