@isTest
class AccountTriggerHandlerTest {
    
    @testsetup
    static void setData() {
        List<Account> accList = Test.loadData(Account.sobjectType, 'accounts');
        System.debug('From setup');
    }
    
	@isTest
    static void testUpdateRatingViaAfterTrigger_Hot() {
        //create an instance of Account, populate fields such as Name, and NumberOfEmployees
        //Perform an insert -> DML -> TRigger -> Handler class -< Updates Rating Field
        //Fire a query to fetch Accounts and check whether the rating has been changed or not as per the requirements
        
        Account acc = new Account(Name='test account', NumberOfEmployees = 5000);
        try {
            insert acc;
        } catch (DmlException ex) {
            System.debug(ex.getMessage()); // never make use error log because error log data wont be commiited
        }
        List<Account> accList = [SELECT Name, Rating FROM Account];
        for(Account acc1: accList) {
            System.assertEquals('Hot', acc1.Rating, 'Please check the logic');
        }
    }
    
    @isTest
    static void testUpdateRatingViaAfterTrigger_Warm() {
        //create an instance of Account, populate fields such as Name, and NumberOfEmployees
        //Perform an insert -> DML -> TRigger -> Handler class -< Updates Rating Field
        //Fire a query to fetch Accounts and check whether the rating has been changed or not as per the requirements
        
        Account acc = new Account(Name='test account', NumberOfEmployees = 1000);
        try {
            insert acc;
        } catch (DmlException ex) {
            System.debug(ex.getMessage()); // never make use error log because error log data wont be commiited
        }
        List<Account> accList = [SELECT Name, Rating FROM Account];
        for(Account acc1: accList) {
            System.assertEquals('Hot', acc1.Rating, 'Please check the logic');
        }
    }
}