trigger CountTrigger on Account (before update) {
    Map<Id,Account> oldAccountMap = Trigger.oldMap;
    Map<Id,Account> newAccountMap = Trigger.newMap;
    
    for(Id accountId : newAccountMap.keySet()){
        Account oldAccount = oldAccountMap.get(accountId);
        Account newAccount = newAccountMap.get(accountId);
        
        if(oldAccount.product_count_c__c != newAccount.product_count_c__c){
            if(!CountFieldUpdate.isdisabletrigger){
                CountFieldUpdate.updateDescription(Trigger.new, oldAccountMap);
            }
        }
    }
}