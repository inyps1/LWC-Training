public with sharing class SchedulableDemo implements Schedulable{
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new BatchableDemo(), 250);
    }
}