public with sharing class QueueableDemo  implements Queueable { //same as futrue method . but allows chaining

    @future
    public static void demo(){
        System.debug('I am from future');
    }

    public void execute(QueueableContext qc) {
         List<Account> accList = [SELECT Id, Name, Industry, Type FROM Account WHERE Name LIKE 'Demo%' WITH SECURITY_ENFORCED]; // Best Practice
        for(Account acc: accList) {
            acc.Type = 'Prospect';
        }
        try {
             update accList;
             //call another queueable or future
             demo();
        } catch(DmlException ex) {
            System.debug(ex.getMessage());
        }
    } 

}