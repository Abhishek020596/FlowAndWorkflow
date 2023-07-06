public class AccountDataHandler {
    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        String key = '%' + searchKey + '%';
        System.debug('__________key__________'+key);
        return [
            SELECT Id, Name
            FROM Account
            WHERE Name LIKE :key
            LIMIT 10
        ];
    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunityRelatedToAccount(String accId) {
        system.debug('____________accId__________' + accId);
        List<Opportunity> listValue = [SELECT Id, Name, AccountId, StageName, ExpectedRevenue from Opportunity where AccountId = :accId]; 
        system.debug('____________listValue____________' + listValue);
        return listValue;
    }
}