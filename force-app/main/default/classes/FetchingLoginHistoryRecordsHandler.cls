public class FetchingLoginHistoryRecordsHandler implements Database.Batchable<sObject>, Database.Stateful{
    Integer conSize;
    Set<Id> logIds = new Set<Id>();
    
    // start method: returns a query locator for the LoginHistory records that have a LoginTime on or after today
    public Database.QueryLocator start(Database.BatchableContext BC){
        DateTime startOfToday = DateTime.now().date();
        return Database.getQueryLocator([SELECT UserId, Id, LoginTime, Status FROM LoginHistory  WHERE LoginTime >= :startOfToday]);
    }
    
    // execute method: adds the UserId of each successful login to a set of Ids
    public void execute(Database.BatchableContext BC, List<LoginHistory> logHistory){
        for(LoginHistory lh : logHistory){
            if(lh.Status == 'Success'){
                logIds.add(lh.UserId);
            }
        }
    }
    
    // finish method: calculates the percentage of active users who have logged in successfully today and sends an email with that information
    public void finish(Database.BatchableContext BC){
        
        AggregateResult result = [SELECT count(Id) total FROM User WHERE isActive = true];
		Integer usercount = (Integer) result.get('total');
        
        Decimal percentage =((Decimal)logIds.size() /usercount) * 100;
        percentage = percentage.setScale(2);
        
        EmailClass.messagingEmailMessage('Login History', 'Total login percenatge'+ percentage + ' %', new Set<Id>{});
    }
}