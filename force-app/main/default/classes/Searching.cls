public with sharing class Searching {
    public Searching() {

    }
    @AuraEnabled
    public static List<Contact> SearchingContact(String input) {

    return [ SELECT Id, Name,  Email, AccountId, Phone, Type__c
             FROM Contact 
             WHERE Name like : '%' + input + '%'
             OR Email like : '%' + input + '%' ]; 
}
}