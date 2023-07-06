public class CountValue {
    public static void getCountDetails(){
        List<Account> acctList = [SELECT Id, Description,Name,product_count_c__c FROM Account WHERE Name = 'testv2'];
        System.debug('acctList==========>>>>>>>>>>>>'+ acctList);
        
        Map<String, Account> sObjectMap = new Map<String, Account>(acctList);
        System.debug('sObjectMap==========>>>>>>>>>>>>'+ sObjectMap);
        
        Map<String, Object> acctMapValue;
        Map<String, Object> descMapValue;
        Map<String, Object> detailsMap;
        Map<String, Object> attrsMap;
        Map<String, Object> valueMap;
        Map<String, Object> moreDetailsMap;
        Map<String, Object> priceMap;
        
        List<Object> mtdList;
        
        
        for(Account acct : sObjectMap.values()){
            acctMapValue = (Map<String, Object>)JSON.deserializeUntyped((String)(acct.get('Description')));
            if(acctMapValue.containsKey('ATTR_VALUE') && acctMapValue.containsKey('ATTRMDT')){
                mtdList = (List<Object>)acctMapValue.get('ATTRMDT');
                attrsMap = (Map<String, Object>)acctMapValue.get('ATTR_VALUE');
            }
            
        }
        
    } 
}