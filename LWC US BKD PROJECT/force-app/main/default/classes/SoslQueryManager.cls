public class SoslQueryManager {
    public static void soslDemo() {
        List<List<sObject>> records = [FIND 'Acme*' RETURNING Account(Name, Type), Contact(FirstName, LastName), Opportunity(Name, StageName where Amount > 50000)];
    }
}