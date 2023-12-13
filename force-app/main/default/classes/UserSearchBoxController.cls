public class UserSearchBoxController {
    
    @AuraEnabled(cacheable=true)
    public static List<wrapperClass> getUsersList(){
        List<User> userList = [SELECT Id, Name, Email, SmallPhotoUrl FROM User]; 
        List<wrapperClass> wrapperList = new List<wrapperClass>();
            for (User fieldName: userList) 
                {                      
                    wrapperClass wc = new wrapperClass();
                    wc.ids = fieldName.id;
                    wc.label = fieldName.Name;
                    wc.value = fieldName.Email;
                    wc.imageUrl = fieldName.SmallPhotoUrl;
                    wrapperList.add(wc);                    
                }
        system.debug('123'+wrapperList);
        return wrapperList;
    }
    public class wrapperClass {
        @AuraEnabled
        public Id ids;
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String value;
        @AuraEnabled
        public String imageUrl;
    }

}