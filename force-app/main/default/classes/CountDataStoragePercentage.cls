/**
* A class that retrieves daily API request limit information and sends an email
* if the remaining API calls for the day are above a certain percentage.
*/
public class CountDataStoragePercentage implements Schedulable, Database.AllowsCallouts{
    /**
* Sends an HTTP GET request to the Salesforce REST API to retrieve daily API request limits.
* Calculates the percentage of remaining API calls for the day and sends an email
* if the percentage is greater than 10.
*/
    @Future(callout=true)
    public static void gettingValue(){
        try{
            // Create an HTTP GET request to retrieve daily API request limits
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint(
                Url.getSalesforceBaseUrl().toExternalForm()+
                '/services/data/v43.0/limits');
            req.setHeader('Authorization','Bearer '+UserInfo.getSessionId());
            HttpResponse res = new Http().send(req);
            
            // Deserialize the response body to get the daily API request limits
            Map<String, Object> values = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
            Map<String, Object> dailyLimits = (Map<String, Object>)values.get('DailyApiRequests');
            Integer maxCallPerDay = (Integer)dailyLimits.get('Max');
            Integer remainingCallsForToday = (Integer)dailyLimits.get('Remaining');
            
            // Calculate the percentage of remaining API calls for the day
            Decimal percentage = 100-(((Decimal)remainingCallsForToday / (Decimal)maxCallPerDay)*100);
            percentage = percentage.setScale(2);
            
            // Send an email if the percentage is greater than 10
            if(percentage > 10){
                EmailClass.messagingEmailMessage('Data Storage More Than 10%', 'Total percenatge'+ percentage + ' %', new Set<Id>{});
            }
        }catch(Exception e){
            System.debug('ErrorMessage________' + e.getMessage());
        }
    }
    
    /**
* Executes the gettingValue() method when the scheduled job is run.
*/
    public void execute(SchedulableContext SC){
        gettingValue();
    }  
}