public class ContactEmailSchedulerClass implements Schedulable {
    public void execute(SchedulableContext ctx){
        String queryEmail = 'SELECT Id, Name, AccountId, Email FROM Contact WHERE Email = NULL';
        System.debug('queryEmail_______________' +queryEmail);
        
        ContactBatchClass batch = new ContactBatchClass(queryEmail , 'Email');
        Database.executeBatch(batch);
    }
}