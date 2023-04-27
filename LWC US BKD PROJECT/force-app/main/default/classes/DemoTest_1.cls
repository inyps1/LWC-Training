@isTest
public class DemoTest_1 {
	/* @testsetup
    static void setData() {
        List<Account> accList = Test.loadData(Account.sobjectType, 'accounts');
        System.debug('From setup '+ accList.size());
    }*/
    
    @isTest
    static void method1() {
        Integer counter = [SELECT count() from Account];
        System.debug('from method 1 '+ counter);
    }
    
    @isTest(seeAllData=true)
    static void method2() {
        Integer counter = [SELECT count() from Account];
        System.debug('from method 2 '+ counter);
    }
}