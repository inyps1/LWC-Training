public with sharing class ContactSearchController {
    
    public String searchText {get; set;}
    public List<Contact> conList {get; set;}
    
    public PageReference doSearch() {
        List<List<sobject>> records = [FIND :searchtext IN ALL FIELDS RETURNING Contact (FirstName, LastName, Email)];
        
        conList = records[0];
        return null;
    }
}