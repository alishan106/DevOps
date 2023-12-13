public class HireFormTriggerHelper {
    public static void insertContactWithForm(Map<Id,Hire_Form__c> formMap){
        Map <Id,Contact> contactMap = new Map<Id,Contact>();
        for(Id id : formMap.keySet()){
            Contact contact = new Contact();
            Hire_Form__c formObj = formMap.get(id);
            
            contact.FirstName = formObj.First_Name__c;
            contact.LastName = formObj.Name;
            contact.Phone = formObj.Phone__c;
            contact.Email = formObj.Email__c;
            
            contactMap.put(id,contact);
        }
        
        INSERT contactMap.values();
        
        List<Hire_Form__c> hireFormList = new List<Hire_Form__c>();
        List<Case> caseList = new List<Case>();
        
        for(Id id : contactMap.keySet()){
            Hire_Form__c formObj = new Hire_Form__c();
            Contact contact = contactMap.get(id);
            Case caseObj = new Case();
            
            caseObj.ContactId = contact.Id;
            caseObj.Origin = 'Web';
            caseObj.Status = 'New';
            formObj.Id = id;
            formObj.Candidate__c = contact.Id;
            
            hireFormList.add(formObj);
            caseList.add(caseObj);
        }
        INSERT caseList;
        UPDATE hireFormList; 
    }
    
    public static List<Id> filterHireForms(List<Hire_Form__c> hireFormList){
        List <Id> contactIds = new List<Id>();
        for(Hire_Form__c formObj : hireFormList){
            if(formObj.Status__c == 'Completed'){
                contactIds.add(formObj.Candidate__c);
            }
        }
        return contactIds;
    }
    
    
    public static void caseStatusUpdate(List<Id> contactIds){
        List <Case> caseList = [SELECT Id, Status FROM Case WHERE ContactId in: contactIds ];
        
        for(Case caseObj : caseList){
            caseObj.Status = 'Closed';
        }
        UPDATE caseList;
    }
}