public class PositionTriggerHandler {
    
    //Req: Capture the timestamp of 'Closed' positions
    public static void updateStatusDescriptionForClosedPositions(List<Position__c> posList, Map<Id, POsition__c> oldMap) {
        for(Position__c pos : posList) {
            Position__c oldRecord = oldMap.get(pos.Id);
            if(oldRecord.Status__c == 'Open' && pos.Status__c == 'Closed') {
                pos.Status_DEscription__c = 'As of now '+ System.now()+ ' this position has been closed';
            }
        }
    }
    
    //Req: Hiring Manager should get 'Read only' access on 'Closed' positions, and
    //read/Write access on 'open ' position
    public static void sharePositionWithHM(List<Position__c> posList){
    	List<Position__Share> posShareList = new List<Position__Share>();
        for(Position__c pos: posList) {
            Position__Share posShare = new Position__Share();
            posShare.ParentId = pos.Id;
            posShare.UserOrGroupId= pos.Hiring_Manager__c;
            posShare.RowCause = Position__Share.RowCause.Buddy__c;
            if(pos.Status__c == 'Open') {
                posShare.AccessLevel = 'Edit';
            } else if( pos.Status__c == 'Closed') {
                posShare.AccessLevel = 'Read';
            }
            posShareList.add(posShare);
        }
        try{
            insert posShareList;
        } catch(DmlException ex) {
            System.debug(ex.getMessage());
        }
	}
    
    //start date of a position can not be on a company holiday
     public static void validateStartDate(List<Position__c> posList){
         List<Holiday> companyHolidayList = [SELECT Id, Name, ActivityDate FROM Holiday];
         set<Date> activityDateSet = new Set<Date>();
         for(Holiday companyHoliday: companyHolidayList) {
             activityDateSet.add(companyHoliday.ActivityDate);
         }
         for(Position__c pos: posList) {
             if(activityDateSet.contains(pos.Start_Date__c)){
                 pos.Start_Date__c.addError('Start Date cannot be on a company holiday');
             }
        }
    }
    
    //Trigger is best way to achieve this requirement
    public static void preventDeletionOfOpenPosition(List<Position__c> posList){
         for(Position__c pos: posList) {
             if(pos.Status__c == 'Open') {
                 //Prevent deletion
                 pos.addError('Cannot delete an open Position');
             }
        }
    }
    
    public static void createAnInterViewer(List<Position__c> posList) {
        List<Interviewer__c> interviewerList = new List<Interviewer__c>();
        for(Position__c pos: posList) {
            Interviewer__c interviewer = new InterViewer__c();
            interviewer.Employee__c = pos.Hiring_Manager__c;
            interviewer.Position__c = pos.Id;
            interviewerList.add(interviewer);
        }
        
        if(interviewerList.size() > 0) {
            try{
                insert interviewerList;
            }catch(DmlException ex) {
                System.debug(ex.getMessage());
            }
        }
    }
}