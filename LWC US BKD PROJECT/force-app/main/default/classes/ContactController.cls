public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        try {
            return [SELECT ID, FirstName, LastName, Email, Phone FROM Contact With SECURITY_ENFORCED];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}