@isTest
public class TestLogDetailsBatchClass {
    static testMethod void testLogData(){
        Log__c c = new Log__c();
        c.Name = 'Test1';
        c.ObjectName__c = 'Account';
        c.Error_Message__c = 'Null Pointer';
        
        INSERT c;
        
        Log__c c2 = new Log__c();
        c2.Name = 'Test2';
        c2.ObjectName__c = 'Contact';
        c2.Error_Message__c = 'Null Pointer';
        
        INSERT c2;
        
        Test.startTest();
        LogDetailsBatchClass log = new LogDetailsBatchClass();
        Database.executeBatch(log);
        Test.stopTest();
        System.assertEquals('Account', [SELECT Id, ObjectName__c, Error_Message__c FROM Log__c WHERE ObjectName__c = 'Account'].ObjectName__c, 'Error!!!');
        System.assertEquals('Contact', [SELECT Id, ObjectName__c, Error_Message__c FROM Log__c WHERE ObjectName__c = 'Contact'].ObjectName__c, 'Error!!!');

    }
}