public class BulkInsertStudentDetails {
    public List<Student__c> studentsList{get;set;}
    public Student__c student{get;set;}
    public List<Student__c> addstudentsList{get;set;}
    public List<Student__c> addSelectedstudentsList{get;set;}
    public BulkInsertStudentDetails(){
        student = new Student__c();  
        addstudentsList = new List<Student__c>();
        addSelectedstudentsList = new List<Student__c>();
        studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c];
        for(Integer count=0;count<3;count++){            
            addstudentsList.add(new Student__c());
        }   
    }
    public PageReference cancel(){
        PageReference pg = new PageReference('/a0F/o');
        pg.setRedirect(true);
        return pg;        
    }

    public PageReference addAllRecord(){
        try {
        for(Student__c student : addstudentsList){    
            if((!String.isBlank(student.Name)) && (!String.isBlank(student.Last_Name__c)) && (!String.isBlank(student.Class__c))){
                addSelectedstudentsList.add(student);
            }
        } 
        insert addSelectedstudentsList;
        PageReference pg = new PageReference('/a0F/o');
        pg.setRedirect(true);
        return pg;
    }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return NULL;
    }
}