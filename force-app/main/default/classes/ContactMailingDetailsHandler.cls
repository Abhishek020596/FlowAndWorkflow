public class ContactMailingDetailsHandler {
    @AuraEnabled(cacheable = true)
    public static List<Contact> gettingContactList(){
        return [SELECT Id, Name, MailingCity, MailingStreet, 
                    MailingPostalCode, MailingState, MailingCountry
                        FROM Contact LIMIT 10];
    }
}