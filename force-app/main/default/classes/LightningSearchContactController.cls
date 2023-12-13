/*
    Name		: LightningSearchContactController
    Date		: 22 May, 2021
    Author		: Zeeshan Ali
    Description : controller for search contacts. 
                  With the help of this class we have implemented searching
                  in contacts based on user input and user also view records according to their selection.
*/ 

public with sharing class LightningSearchContactController {
    public LightningSearchContactController() {   

    }
    
    @AuraEnabled
    public static List<Contact> searchContacts(String searchInput){
        String searchString = '%'+ searchInput + '%';
        return [SELECT Id, Name, Email, Account.Name, Phone, Type__c 
               FROM Contact 
               WHERE Name LIKE : searchString OR Email LIKE : searchString];
    }
 }