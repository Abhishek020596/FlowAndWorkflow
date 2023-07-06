public class EmailClass {
    public static void messagingEmailMessage(String subject, String body, Set<Id> files){
        List<String> configEmail = label.SampleCustomLabel.split(',');
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(configEmail);
            mail.setSenderDisplayName('Using BatchHandler');
            mail.setSubject(subject);
            mail.setPlainTextBody(body);
                
        if(!files.isEmpty()){
            List<ContentVersion> allDocuments = [SELECT Id, Title, FileType, VersionData FROM ContentVersion WHERE Id IN :files];
            List<Messaging.Emailfileattachment> mailList = new List<Messaging.Emailfileattachment>();
            for(ContentVersion con : allDocuments){
                Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                efa.setFileName(con.Title+'.'+con.FileType);  
                efa.setBody(con.VersionData);
                mailList.add(efa);
            }
            mail.setFileAttachments(mailList);
            
        }
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
         
    }   
}