@isTest
public class ContactBatchClassTest {
    @TestSetup static void testValues(){
        Account acc = new Account();
        acc.Name = 'Abhiiiiiiiiiii';
        INSERT acc;
        
        Contact conn = new Contact();
        conn.AccountId = acc.Id;
		conn.LastName = 'Abhishek';
        INSERT conn;
    }
    @isTest static void testPhoneValue(){
        Test.startTest();
        ContactPhoneSchedulerClass cpsc = new ContactPhoneSchedulerClass();
        String sch = '0 0 0 ? * * *';
        System.schedule('PhoneSchedule', sch, cpsc);
        Test.stopTest();
        
    }
    @isTest static void testEmailValue(){
        Test.startTest();
        ContactEmailSchedulerClass cesc = new ContactEmailSchedulerClass();
        String sch = '0 0 10/1 ? * * *';
        System.schedule('EmailSchedule', sch, cesc);
        Test.stopTest();
        
        Contact conList = [SELECT Id, Name, Description, Phone FROM Contact WHERE Name = 'Abhishek'];
        System.assertEquals('Abhishek', conList.Name);
    }
}