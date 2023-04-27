public with sharing class OpportunityController {
    //with sharing, run on user mode, system mode ignore sharing rule and OWD
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getAllOpportunites(){
        try {
            return [SELECT Name, StageName, CloseDate, Amount FROM Opportunity With SECURITY_ENFORCED]; //best practice to use SECURITY ENFORCED
            // Security_enforced give records if profile has read access on fetched fields
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteOpportunity(String sid){
        try {
           Opportunity opp = [SELECT Name FROM Opportunity WHERE Id =: sid WITH SECURITY_ENFORCED];
           delete opp;
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}