public class CountFieldUpdate{
    public static Boolean isdisabletrigger = false; 
    public static void updateDescription(List<Account> accts, Map<Id, Account> oldAccount){
        
        //List<Account> acctList = [SELECT Id, Description,Name,product_count_c__c FROM Account WHERE Id =: accIds];
        Map<String, Account> sObjectMap = new Map<String, Account>(accts);
        Map<String, Object> acctMapValue;
        Map<String, Object> descMapValue;
        Map<String, Object> detailsMap;
        Map<String, Object> attrsMap;
        Map<String, Object> valueMap;
        Map<String, Object> moreDetailsMap;
        Map<String, Object> priceMap;
        List<Object> mtdList;
        String finalString;
        
        //old Account values
         Map<String, Object> oldAcctMapValue;
         Map<String, Object> oldAttrsMap;
         List<Object> oldMtdList;
         Map<String, Object> oldDescMapValue;
         Map<String, Object> oldDetailsMap;
         Map<String, Object> oldValueMap;
         Map<String, Object> oldMoreDetailsMap;
         Map<String, Object> oldPriceMap;
         Integer oldProductCount;
        
         for(Account act : oldAccount.values()){
            oldAcctMapValue = (Map<String, Object>)JSON.deserializeUntyped((String)act.get('Description'));
             if(oldAcctMapValue.containsKey('ATTR_VALUE') && oldAcctMapValue.containsKey('ATTRMDT')){
                oldMtdList = (List<Object>)oldAcctMapValue.get('ATTRMDT');
                oldAttrsMap = (Map<String, Object>)oldAcctMapValue.get('ATTR_VALUE');
            }
        }
        
        for(Object obj : oldMtdList){
            oldDescMapValue = (Map<String, Object>)obj;
            if(oldDescMapValue.containsKey('details') && oldDescMapValue.get('brand') == 'iphone'){
                oldDetailsMap = (Map<String, Object>)oldDescMapValue.get('details');
                if(oldDetailsMap.containskey('price') && (oldDetailsMap.get('price') != null)){
                      oldProductCount = Integer.valueOf(oldDetailsMap.get('count'));
                     Integer priceValue = Integer.valueOf(oldDetailsMap.get('price'));
                }
                
            }
        }
        
         if(oldAttrsMap.containsKey('value')){
            oldValueMap = (Map<String, Object>)oldAttrsMap.get('value');
            if(oldValueMap.containsKey('moredetails')){
                oldMoreDetailsMap = (Map<String, Object>)oldValueMap.get('moredetails');
                if(oldMoreDetailsMap.containsKey('price') && oldMoreDetailsMap.get('brand') == 'samsung'){
                    oldPriceMap = (Map<String, Object>)oldMoreDetailsMap.get('price');
                    if(oldPriceMap.containskey('price') && (oldPriceMap.get('price') != null ) ){
                         oldProductCount = Integer.valueOf(oldPriceMap.get('count'));
                        Integer priceValue = Integer.valueOf(oldPriceMap.get('price'));  
                    }
                }
            }
        }

		// New Account values
        for(Account acct : sObjectMap.values()){
            acctMapValue = (Map<String, Object>)JSOn.deserializeUntyped((String)(acct.get('Description')));
            if(acctMapValue.containsKey('ATTR_VALUE') && acctMapValue.containsKey('ATTRMDT')){
                mtdList = (List<Object>)acctMapValue.get('ATTRMDT');
                attrsMap = (Map<String, Object>)acctMapValue.get('ATTR_VALUE');
            }
            
        }
        
        for(Object obj : mtdList){
            descMapValue = (Map<String, Object>)obj;
            if(descMapValue.containsKey('details') && descMapValue.get('brand') == 'iphone'){
                detailsMap = (Map<String, Object>)descMapValue.get('details');
                if(detailsMap.containskey('count')){
                    detailsMap.put('count',accts[0].product_count_c__c );
                }
                if(detailsMap.containskey('price') && (detailsMap.get('price') != null)){
                     Integer productCount = Integer.valueOf(detailsMap.get('count'));
                     Integer priceValue = Integer.valueOf(detailsMap.get('price'));
                     Integer totalPrice = (priceValue/oldProductCount)*Integer.valueOf(productCount);
                     detailsMap.put('price',totalPrice);
                }
                
            }
        }
        
        if(attrsMap.containsKey('value')){
            valueMap = (Map<String, Object>)attrsMap.get('value');
            if(valueMap.containsKey('moredetails')){
                moreDetailsMap = (Map<String, Object>)valueMap.get('moredetails');
                if(moreDetailsMap.containsKey('price') && moreDetailsMap.get('brand') == 'samsung'){
                    priceMap = (Map<String, Object>)moreDetailsMap.get('price');
                    if(priceMap.containskey('count')){
                        priceMap.put('count',accts[0].product_count_c__c );
                    }
                    if(priceMap.containskey('price') && (priceMap.get('price') != null ) ){
                        Integer productCount = Integer.valueOf(priceMap.get('count'));
                        Integer priceValue = Integer.valueOf(priceMap.get('price'));
                        // old map accId= price / Acc.product count = unit price
                        // unit price *new count
                          Integer totalPrice = (priceValue/oldProductCount)*Integer.valueOf(productCount);
                         priceMap.put('price',totalPrice );
                        
                    }
                }
            }
        }
        
        
        finalString = JSON.serialize(acctMapValue);
        List<Account> updatedlist = new List<Account>();
        for(Account acct : accts){
            acct.Description = finalString;
            updatedlist.add(acct);
        }
        isdisabletrigger = true;

    }
}