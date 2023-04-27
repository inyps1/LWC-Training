public class AccountTriggerHandler {
    
    static boolean isUpdated = false;
    
    public static void updateRatingViaAfterTrigger(Set<Id> accIdSet) {
        
        if(isUpdated == false) {
            List<Account> accList = [SELECT Id, Name, NumberOfEmployees FROM Account WHERE Id IN : accIdSet];
            
            for(Account acc: accList) {
                if(acc.NumberOfEmployees >= 5000) {
                    acc.Rating = 'Hot';
                } else {
                    acc.Rating = 'Warm';
                }
            }
            isUpdated = true;
            update accList; //  keeping try catch
        }
        
    }
    
    public static void updateRatingCommonApproach(List<Account> accList){
      for(Account acc: accList) {
        if(acc.NumberOfEmployees >= 5000) {
            acc.Rating = 'Hot';
        } else {
            acc.Rating = 'Warm';
        }
     }
    }
    
    public static void updateRating(){
      for(Account acc: (List<Account>)Trigger.new) {
        if(acc.NumberOfEmployees >= 5000) {
            acc.Rating = 'Hot';
        } else {
            acc.Rating = 'Warm';
        }
     }
    } 
}