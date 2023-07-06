/*
Author                         					 : Abhishek
Date                           					 : 17-03-2023
Class Name                    					 : AccountCustomMetaBatchClass
________________________________________________________________________________
CustomMetaData									 : AccountCustomMetaData
CustomLabel										 : AccountDateMetaData
*/

public class AccountCustomMetaBatchClass implements Database.Batchable<sObject>, Database.Stateful{
    String[] lastNDay = Label.AccountDateMetaData.split(',');
    Integer days = Integer.valueOf(lastNDay[0].split('-')[1]);
    Integer dateDifference = Integer.valueOf(lastNDay[1].split('-')[1]);
    Datetime createdStartDate = Date.today().addDays(- days);
    Datetime createdEndDate = Date.today().addDays(- (days + dateDifference));
    
    String query = 'SELECT Id, '; 
    String whereClause = '';
    
    public AccountCustomMetaBatchClass(){
        System.debug('___createdStartDate___' +createdStartDate);
        System.debug('___createdEndDate_____' +createdEndDate);
        AccountCustomMetaData__mdt accList = [SELECT Id,Fields__c FROM AccountCustomMetaData__mdt LIMIT 1];
        for(String abc : accList.Fields__c.split(',')){         
            query += abc+' ,';
            whereClause+= abc+ ' !=null OR ';
        }
        query = query.removeEnd(',');
        query += 'FROM Account ';
        query += 'WHERE ( '+whereClause.removeEnd('OR ');
        query += ') AND createdDate <= : createdStartDate AND createdDate > :createdEndDate';
        System.debug(query);
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);  
    }
    public void execute(Database.BatchableContext BC, List<Account> scope){
        List<Account> accc = new List<Account>();
        for(Account acc : scope){
            accc.add(acc);
        }
        System.debug('scope__________________'+accc);
    }
    public void finish(Database.BatchableContext BC){
        
    } 
    
}