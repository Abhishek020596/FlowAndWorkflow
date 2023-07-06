public class AccountBatchClass implements Database.Batchable<sObject>, Database.Stateful {
    String field; // The name of the field being processed
    Set<Id> accIds; // The set of Account IDs to process
    // Constructor to set instance variables
    public AccountBatchClass(Set<Id> accIds, String field) {
        this.accIds = accIds;
        this.field = field;
    }
    // Implementation of start method from Batchable interface
    public Database.QueryLocator start(Database.BatchableContext BC) {
        // Query the Account records with IDs in the provided set
        return Database.getQueryLocator([SELECT Id, Name, Email__c, Phone FROM Account WHERE Id IN :accIds]);
    }
    // Implementation of execute method from Batchable interface
    public void execute(Database.BatchableContext BC, List<Account> acclist) {
        try {
            for (Account acc : acclist) {
                accIds.add(acc.Id); // Add Account ID to the set for tracking
                // Check if the field is Phone and if it's null or empty
                if (field == 'Phone' && (acc.Phone == null || acc.Phone == '')) {
                    acc.Description = 'Please Update ' + field; // Set the Account description to prompt user to update the field
                }
                // Check if the field is Email and if it's null or empty
                if (field == 'Email' && (acc.Email__c == null || acc.Email__c == '')) {
                    acc.Description = 'Please Update ' + field; // Set the Account description to prompt user to update the field
                }
            }
            // Update the list of Account records
            UPDATE acclist;
        } catch (Exception e) {
            // Catch any exceptions and output error message to debug log
            System.debug('Exception______________' +e.getMessage());
        }
    }
    // Implementation of finish method from Batchable interface
    public void finish(Database.BatchableContext BC) {
        // This method is empty because we don't need to do anything after the batch has finished processing
    }
}