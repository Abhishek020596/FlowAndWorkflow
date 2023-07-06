@isTest
public class TestHandlerUpdatedContacts {
    static testMethod void testMethod1() 
    {
        List<Contact> gettingContact = new List<Contact>();
        for(Integer i=0; i<5; i++)
        {
            Contact con = new Contact();
            con.Lastname ='Abhishek'+i;
            gettingContact.add(con);
        }
        INSERT gettingContact;
        
        Test.startTest();
        UpdatedContacts batch = new UpdatedContacts();
        Database.executeBatch(batch);
        Test.stopTest();
        
        Contact conList = [SELECT Id, Name from Contact where Name = 'Abhishek1'];
        System.assertEquals('Abhishek1', conList.Name);
    }
}