global class QuickBookCompanyInfo {
    @AuraEnabled(cacheable=true)
    global static List<Account> getCustomterInfo(){
        try {
            return [SELECT Name,QBO_Id__c FROM Account WHERE QBO_Id__c!=NULL];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
}