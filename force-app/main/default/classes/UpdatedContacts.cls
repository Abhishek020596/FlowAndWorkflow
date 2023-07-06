public class UpdatedContacts implements Database.Batchable<sObject>, Database.Stateful {
    Integer conSize;
    String fileData = '';
    String header='ContactID,ContactFirstName,ContactLastName';
    
    public Database.QueryLocator start(Database.BatchableContext BC){ 
        String configDays = label.DaysCustomLabel;
        Integer myInt = Integer.valueOf(configDays);
        
        return Database.getQueryLocator('SELECT Id, FirstName, LastName, CreatedDate FROM Contact WHERE LastModifiedDate = LAST_N_DAYS:'  + myInt);
    }
    
    public void execute(Database.BatchableContext BC, List<Contact> conList){
        System.debug('Execute------'+conList);
        Set<Id> conIds = new Set<Id>();
        List<Contact> updatedName = new List<Contact>();
        try{
            for(Contact conn : conList){
                conIds.add(conn.Id);
                Contact c  = new Contact();
                c.Id = conn.Id;
                c.Names__c = conn.FirstName+ ' , ' +conn.LastName;
                fileData += conn.Id+ ',' + c.Names__c + '\n';
                updatedName.add(c);
            }
        }catch(Exception e){
            System.debug('exception> '+e);
        }
        if(updatedName.size()>0){
            UPDATE updatedName;
            conSize = updatedName.size();
            System.debug('ConSize'+ conSize);
        }
    }
    
    public void finish(Database.BatchableContext BC){
        ContentVersion objCV = new ContentVersion(
            Title = 'Test',
            PathOnClient = 'test.csv',
            VersionData =  Blob.valueOf(header+ '\n' + fileData) 
        );
        INSERT objCV;
        
        List<ContentVersion> allDocuments = [SELECT Id, Title, FileType, VersionData FROM ContentVersion WHERE Id =:objCV.Id];
        List<String> configEmail = label.SampleCustomLabel.split(',');      
        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
        efa.setFileName('test.csv');  
        efa.setBody(allDocuments[0].VersionData);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(configEmail);
        mail.setSenderDisplayName('Using Batch to Update Contact');
        mail.setSubject('Updated Contact Size');
        mail.setPlainTextBody('Contact Update Size:-'+conSize);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[]{efa});  
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
    }
    
}