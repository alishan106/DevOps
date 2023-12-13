public class SearchStudentController{
    public List<Student__c> studentsList{get;set;}
    public Student__c student{get;set;}
    public String searchFname {get;set;}
    public SearchStudentController(){
        student = new Student__c();
        studentsList = new List<Student__c>();  
        studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                        Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c];   
    }    
    public void doSearch(){
        if(!String.isBlank(searchFname) && String.isBlank(student.Class__c) && (student.DOB__c==NULL))
        {
            String searchString = '%' + searchFname + '%';
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c 
                            where Name like : searchString or Last_Name__c like : searchString order by Name];
        }
        
        else if(String.isBlank(searchFname) && !String.isBlank(student.Class__c) && (student.DOB__c==NULL))
        {
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c 
                            where Class__c =: student.Class__c order by Name];
        }
        
        else if(!String.isBlank(searchFname) && !String.isBlank(student.Class__c) && (student.DOB__c==NULL))
        {	
            String searchString = '%' + searchFname + '%';
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c 
                            where (Name like : searchString or Last_Name__c 
                                   like : searchString) and Class__c =: student.Class__c  order by Name];
        }
        
        else if(String.isBlank(searchFname) && !String.isBlank(student.Class__c) && (student.DOB__c!=NULL))
        {
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM 
                            Student__c where Class__c =: student.Class__c and DOB__c =: student.DOB__c order by Name];
        }
        else if(String.isBlank(searchFname) && String.isBlank(student.Class__c) && (student.DOB__c!=NULL))
        {
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                        Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c];
        }
        
        else if(!String.isBlank(searchFname) && String.isBlank(student.Class__c) && (student.DOB__c!=NULL))
        {
            String searchString = '%' + searchFname + '%';
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c 
                            where (Name like : searchString or Last_Name__c 
                                   like : searchString) and DOB__c =: student.DOB__c order by Name];
        }
        else if(!String.isBlank(searchFname) && !String.isBlank(student.Class__c) && (student.DOB__c!=NULL))
        {
            String searchString = '%' + searchFname + '%';
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c 
                            where (Name like : searchString or Last_Name__c 
                                   like : searchString) and Class__c =: student.Class__c 
                            and DOB__c =: student.DOB__c order by Name];
        }
        else{
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                        Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c];
            //studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c Where Name like : '%00000%'];
            //delete studentsList;
        }
    }
}