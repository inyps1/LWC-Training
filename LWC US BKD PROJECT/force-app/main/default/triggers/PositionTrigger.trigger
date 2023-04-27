trigger PositionTrigger on Position__c (before insert, before delete, after insert, before update, after update) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            PositionTriggerHandler.createAnInterViewer(Trigger.new);
        }else if(Trigger.isUpdate || Trigger.isInsert) {
            PositionTriggerHandler.sharePositionWithHM(Trigger.new);
        }
    }
    
    if(Trigger.isBefore){
        if(Trigger.isDelete) {
            PositionTriggerHandler.preventDeletionOfOpenPosition(TRigger.old);
        }
        if(Trigger.isInsert || Trigger.isUpdate) {
            PositionTriggerHandler.validateStartDate(Trigger.new);
        }
        if(Trigger.isUpdate) {
            PositionTriggerHandler.updateStatusDescriptionForClosedPositions(Trigger.new, TRigger.oldMap);
        }
    }
    
}