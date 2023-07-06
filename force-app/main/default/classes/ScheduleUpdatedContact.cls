public with sharing class ScheduleUpdatedContact implements Schedulable{
    public void execute(SchedulableContext SC) {
        UpdatedContacts batch = new UpdatedContacts();
        Database.executeBatch(batch);
    }
}