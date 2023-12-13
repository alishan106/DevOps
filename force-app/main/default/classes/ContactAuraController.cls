public with sharing class ContactAuraController {
    @AuraEnabled
    public static List<Contact> getContactList(){
        try {
            return [select Id, LastName, Email, Phone from Contact];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void saveContact(Contact con){
        try {
            if(con.LastName != null){
                insert con;
            }
        } catch (Exception e) {
            System.debug(e);
        }

    }
}