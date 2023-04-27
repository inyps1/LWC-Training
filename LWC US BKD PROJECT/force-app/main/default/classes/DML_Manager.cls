public class DML_Manager {
    
    public static void knowYourLimits() {
    	List<Account> accList = [SELECT Name FROM Account WHERE Name LIKE 'Demo%'];
        
        accList = [SELECT Name FROM Account WHERE Name LIKE 'Demo%'];
        
        accList = [SELECT Name FROM Account WHERE Name LIKE 'Demo%'];
        
        Integer usedRows = Limits.getQueryRows();
        Integer maxRows = Limits.getLimitQueryLocatorRows();
        Integer leftRows = maxRows - usedRows;
        System.debug('used : '+ usedRows+ ' ::left '+ leftRows+ ' :: maxRows '+ maxRows);
    }
    
    public static void scenariolBestPracticeWithLoops() {
        //Good: Utilizes only 1 DML
        //BAD: May need more heap
        //Fetch Demo records and update
        List<Account> accList = [SELECT Name FROM Account WHERE Name LIKE 'Demo%'];
        
        for(Account acc: accList) {
            acc.Rating = 'Cold';
        }
        
        update accList; // write a try catch
    }
    
    public static void scenariol2BestPracticeWithLoops() {
        //Good: Less Heap
        //BAD: May need more DML
        //Fetch Demo records and update batching approach
        
        //List<Account> accList in forloop force batch
        Integer counter = 0;
        for(List<Account> accList: [SELECT Name FROM Account WHERE Name LIKE 'Demo%']) { //brings only 200 records at a time for Processing Server
            for(Account acc: accList) {
                acc.Rating = 'Hot';
            }
            update accList;
            counter++;
        }
        System.debug('Number of batches '+ counter);
    }
    
    public static void createBulkAccounts() {
        List<Account> accList = new List<Account>();
        for(Integer i = 1; i<= 1000; i++) {
            Account acc = new Account(Name='Demo'+i);
            accList.add(acc);
            
        }
        
        if(accList.size() > 0) {
            try{
                insert accList;
            }catch(DmlException ex) {
                 Error_Log__c log = new Error_Log__c();
                log.Trace__c = ex.getMessage()+' :: '+ ex.getStackTraceString();
                insert log;
            }
        }
    }
    public static void standaloneDML_Demo() {
        Contact c1 = new Contact(FirstName='John', LastName='Doe');
        Contact c2 = new Contact(FirstName='Smith');
        List<Contact> conList =  new List<Contact>{c1,c2};
        
            try{
                insert conList;
            }catch(DmlException ex){
                System.debug(ex.getMessage());
                Error_Log__c log = new Error_Log__c();
                log.Trace__c = ex.getMessage()+' :: '+ ex.getStackTraceString();
                insert log;
            }
    }
    
    public static void databaseDML_Demo() {
        Contact c1 = new Contact(FirstName='John', LastName='Doe');
        Contact c2 = new Contact(FirstName='Smith');
        List<Contact> conList =  new List<Contact>{c1,c2};
           
        List<Database.SaveResult> saveResultList = Database.insert(conList, false);
        for(Database.SaveResult saveResult : saveResultList) {
            if(saveResult.isSuccess()) {
                System.debug('Contact has been created '+ saveResult.getId());
            } else {
                for(Database.Error err: saveResult.getErrors()) {
                    System.debug(err.getMessage());
                }
            }
        }
    }
}