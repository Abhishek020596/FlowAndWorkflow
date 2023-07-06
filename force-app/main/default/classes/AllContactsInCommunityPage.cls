public class AllContactsInCommunityPage {
    @AuraEnabled(cacheable=true)
    public static List<Contact> retrieveContacts(){
        System.debug('___________________________________________________');
        return [SELECT Id, FirstName, LastName, Phone, Email FROM Contact];
    }
}


