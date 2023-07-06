public class SearchCustomLabelHandler {
    @AuraEnabled
    public static List<String> retrieveCustomData(){
        List<String> newList = new List<String>();
        System.debug('--------------newList---------------'+ newList);
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        for(String objectName :gd.keySet()){
            Schema.SObjectType result=gd.get(objectName);
            if(result.getDescribe().isCustomSetting(----------------------------){
                System.debug('_____________________'+objectName);
                String query = 'SELECT';
                // Grab the fields from the describe method and append them to the queryString one by one.
                Map<String, Schema.SObjectField> objectFields =result.getDescribe().fields.getMap();
                for(String s : objectFields.keySet()) {
                    query += ' ' + s + ',';
                }
                if (query.subString(query.Length()-1,query.Length()) == ','){
                    query = query.subString(0,query.Length()-1);
                }
                // Add FROM statement
                query += ' FROM ' + objectName;
                System.debug('__________________query___________________'+query );
                System.debug('________Database.query(query)_____________'+Database.query(query));//Query and Display Sobject or show on VP
                newList.add(objectName);
                System.debug('___________________newlist__________________'+newList);
            }
        }
        return newList;
    }

    @AuraEnabled
    public static sObject retrieveSelectedCustomDataName(String selectedDropValues){
        // System.debug('_________________from JS____________________' +selectedDropValues);
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        for(String objectName :gd.keySet()){
            Schema.SObjectType result=gd.get(objectName);
        
            if(objectName.equalsIgnoreCase(selectedDropValues)){
                System.debug('obj name======='+ objectName);
                System.debug('__________selected class log___________'+result);
                String query = 'SELECT';
                Map<String, Schema.SObjectField> objectFields =result.getDescribe().fields.getMap();
                for(String s : objectFields.keySet()) {
                    query += ' ' + s + ',';
                }
                if (query.subString(query.Length()-1,query.Length()) == ','){
                    query = query.subString(0,query.Length()-1);
                }
                query += ' FROM ' + objectName; 
                System.debug('__________________query___________________'+query );
                return Database.query(query);
            }
        }
        return null; 
    }
    @AuraEnabled
    public static String updateCustomDataValue(String acc, String row){
        System.debug('________________acc_________________'+ acc);
        System.debug('________________row_________________'+ row);
        customdata__c cs = [SELECT id,Name__c, isTriggerFire__c  FROM customdata__c];
        cs.isTriggerFire__c = 'Com';
        UPDATE cs;
        return 'success';
    }
}