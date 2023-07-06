// Define a public class that implements Database.Batchable and Database.Stateful interfaces
public class ContactBatchClass implements Database.Batchable<sObject>, Database.Stateful{

    // Define variables to hold account Ids, query and field to update
    public Set<Id> accIds = new Set<Id>();
    public String query;
    public String field;
    
    // Constructor to set the query and field values
    public ContactBatchClass(String query, String field){
        this.query = query;
        this.field = field;
    }
    
    // Start method to return the query locator
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(this.query);
    }
    
    // Execute method to update the contact records and add account Ids to the set
    public void execute(Database.BatchableContext BC, List<Contact> contactList){
        for(Contact con : contactList){
            accIds.add(con.AccountId);
            con.Description = 'Please update '+ this.field; // Add a message to the contact description
        }
        UPDATE contactList; // Update the contact records with the modified description
    }
    
    // Finish method to execute a batch job for the account records
    public void finish(Database.BatchableContext BC){
        Database.executeBatch(new AccountBatchClass(accIds,field)); // Execute a batch job for the account records
    }
    
}