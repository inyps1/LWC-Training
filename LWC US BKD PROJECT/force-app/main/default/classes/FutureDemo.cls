public with sharing class FutureDemo {
    //Async -> Higher Gov Limit -> 12MB Heap, 60k cpu cycle, 200 soql limit
    //1. Future annotation
    //update 10k accounts, 10k contacts, 10k opportunities
    //2. queueable => chaining
    //3. Millions of records to handle -> Batch APEX -> 50M
    //4.Schedule


    //fetch Demo Accounts and update type to 'Customer'
    @future
    public static void updateAccountType() {
        List<Account> accList = [SELECT Id, Name, Industry, Type FROM Account WHERE Name LIKE 'Demo%' WITH SECURITY_ENFORCED]; // Best Practice
        for(Account acc: accList) {
            acc.Type = 'Customer';
        }
        try {
             update accList;
        } catch(DmlException ex) {
            System.debug(ex.getMessage());
        }
       
    }
}