// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

FutureDemo.updateAccountType();

System.enqueueJob(new QueueableDemo());

List<Account> accList = [SELECT Id, Name, Industry, Type FROM Account WHERE Name LIKE 'Demo%' WITH SECURITY_ENFORCED]; // not good approach, use only forl less than 100, we are loosin g heap given by async, etc....
System.enqueueJob(new QueueableDemo2(accList));

Database.executeBatch(new BatchableDemo(), 500);

SchedulableDemo demo = ne SchedulableDemo();
String cronExp = '0 0 12 * * ?';
System.schedule('DemoJob', cronExp, demo);

String RecordTypeName = 'Customer Account';
Id varRecordTypeId = [SELECT Id FROM RecordType where Name = :RecordTypeName].Id;

//Fetch all the Accounts with this recordTypeId
List<Account> accList = new List<Account>();
for(Account acc : [SELECT ID, Name from Account WHERE recordTypeId = : varRecordTypeId]) {
    acc.Sales_Message__c = 'Hey... Avail 40% Discount now';
    accList.add(acc);
}
update accList;
