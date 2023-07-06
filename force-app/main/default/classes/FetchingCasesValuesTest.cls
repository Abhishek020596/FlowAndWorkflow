@isTest
public class FetchingCasesValuesTest {
    @isTest static void testCaseValues(){
        Case cass = new Case();
        cass.Subject = 'case1';
        cass.Description = '{"SalesforceCPQ":[{"TransactionInfo":{"event_name":"TERTIO","cpq_id":"SVC-005889656","action":"Status_Update","status":"CriticalEptFailed","status_desc":"NsnNtHlr5NE1:NEFailureFATAL { :ErrorCode:3504 ErrorMessage:Object imsi=502121301163085,dc=IMSI,dc=C-NTDB already exists., ErrorCode:3503 ErrorMessage:The object: msisdn=601112456062,dc=MSISDN,dc=C-NTDB - was not found in the One-NDS.}","attributes":[{"Key":"USERNAME","Value":"MSISDN"},{"Key":"USERPASSWORD","Value":"MSISDN"},{"Key":"PROVISIONINGDATETIME","Value":"2022-10-27T09:19:55"}]}}]}';
        INSERT cass;
        
        Test.startTest();
        FetchingCasesValues fcv = new FetchingCasesValues();
        Database.executeBatch(fcv); 
        Test.stopTest();
    }
}