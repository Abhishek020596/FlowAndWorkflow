@isTest
public class CountDataStoragePercentageTest {
    @isTest static void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Test.startTest();
            CountDataStoragePercentage cs = new CountDataStoragePercentage();
            String cron = '0 0 3/3 ? * * *';
            System.schedule('Class Schedule', cron, cs);
        Test.stopTest();
    }
}