public class AccountOpportunitiesDataHandler {
    @AuraEnabled
    public static List<Account> fetchAccounts(String searchKey) {
        return [SELECT Id, Name FROM Account LIMIT 10];
    }

    @AuraEnabled
    public static List<Opportunity> retrieveOpportunitiesRelatedToAccount(String accId) {
    system.debug('____________accId__________' + accId);
    return [SELECT Id, Name, AccountId, StageName, ExpectedRevenue from Opportunity where AccountId = :accId]; 
    }
}