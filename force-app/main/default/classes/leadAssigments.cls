public with sharing class leadAssigments {
    
    @Auraenabled
    public static List<Lead> getTodayLeads(){
        try {
            return [select id, Name, Company,CreatedDate,Status, Email, Phone FROM Lead where CreatedDate = today];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @Auraenabled
    public static List<Lead> getAllLeadsImp(){
        try {
            return [select id, Name, Company,CreatedDate,Status, Email, Phone FROM Lead];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @Auraenabled
    public static void saveLead(Lead lead){
        INSERT lead;
    }
}