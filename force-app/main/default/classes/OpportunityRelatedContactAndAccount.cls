public class OpportunityRelatedContactAndAccount{
    @AuraEnabled(cacheable=true)
    public static Account retrieveOpporunityData(integer oppNum){
        String oppId = [SELECT Id, OpportunityNumber__c FROM Opportunity WHERE OpportunityNumber__c =:oppNum].Id;
        System.debug('_____________OpportunityContactRole________________' +[SELECT OpportunityId, ContactId, Id FROM OpportunityContactRole]);
        String conId = [SELECT Id, OpportunityId, ContactId FROM OpportunityContactRole WHERE OpportunityId =:oppId].ContactId;
        System.debug('______________conId__________________'+ conId);
        String accId = [SELECT Id, AccountId from Contact WHERE Id =:conId].AccountId;
        System.debug('______________accId________________' +accId);
        Account acc = [SELECT Id, Password__c, (SELECT OpportunityNumber__c FROM Opportunities) FROM Account WHERE Id =: accId];
        System.debug('_____________AccountId____________'+acc);
        return acc;
    }
}