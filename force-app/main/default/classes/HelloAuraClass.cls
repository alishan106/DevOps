public class HelloAuraClass {
	@AuraEnabled
    public static List<Contact> ConList(){
        
        List<Contact> contactList = [select FirstName, LastName,Phone,Email from Contact Limit 2];
        return contactList;
    }
}