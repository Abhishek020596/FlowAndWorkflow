public class ContactPhoneSchedulerClass implements Schedulable{
    public void execute(SchedulableContext ctx){
        String queryPhone = 'SELECT Id, Name, Phone, AccountId FROM Contact WHERE Phone = NULL';
        System.debug('queryPhone_______________' +queryPhone);
        
        ContactBatchClass batch = new ContactBatchClass(queryPhone , 'Phone');
        Database.executeBatch(batch);
    }
}