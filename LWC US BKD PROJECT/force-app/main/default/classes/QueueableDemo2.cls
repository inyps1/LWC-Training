public with sharing class QueueableDemo2 implements Queueable{
    List<Account> accList;
    public QueueableDemo2(List<Account> accList) {
        this.accList = accList;
    }

      public void execute(QueueableContext qc) {
        for(Account acc: accList) {
            acc.Type = 'Customer';
        }
        try {
             update accList;
             //call another queueable or future and viceversa
        } catch(DmlException ex) {
            System.debug(ex.getMessage());
        }
    } 
}