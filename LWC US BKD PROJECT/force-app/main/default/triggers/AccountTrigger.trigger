trigger AccountTrigger on Account (after insert, after update) {
    //Store the Ids in a set and pass them to the method
    
    Set<Id> accIdSet = new Set<Id>();
    
    for(Account acc: TRigger.new) {
        accIdSet.add(acc.Id);
    }
    
    AccountTriggerHandler.updateRatingViaAfterTrigger(accIdSet);
   //AccountTriggerHandler.updateRatingCommonApproach(Trigger.new);
   //AccountTriggerHandler.updateRating();
}