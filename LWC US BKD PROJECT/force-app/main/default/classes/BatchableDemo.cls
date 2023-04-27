public with sharing class BatchableDemo implements Database.Batchable<sobject>, Database.Stateful{ //sobject gives 50M, account etc gives 50k
    //QueryLocator -> 50M
    //Iterable -> 50K

    Integer numberOfRecordsProcessed = 0; // will work with the help of Database.Statefull interface, otherwise it will be 0 at the begining every chuck of batch process
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name FROM Account WHERE Name Like \'Demo%\'';
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext bc, List<Account> accList) {
        for(Account acc: accList) {
            acc.Type = 'Customer';
            numberOfRecordsProcessed ++;
        }
        try {
             update accList;
             //call another queueable or future and viceversa
        } catch(DmlException ex) {
            System.debug(ex.getMessage());
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('The number of records processed : '+ numberOfRecordsProcessed);
    }

}