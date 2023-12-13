public class StudentListController{
    public List<Student__c> studentsList{get;set;}
    public Student__c student{get;set;}
    public String searchName {get;set;}
    public String searchEmail{get;set;}
    public String searchPhone{get;set;}
    public StudentListController(){
        student = new Student__c();
        studentsList = new List<Student__c>();  
        studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                        Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c];   
    }    
    public void doSearch(){
        if(!String.isBlank(searchName) && String.isBlank(searchEmail) && String.isBlank(searchPhone))
        {
            String searchString = '%' + searchName + '%';
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c 
                            where Name like : searchString or Last_Name__c like : searchString order by Name];
        }
        
        else if(String.isBlank(searchName) && !String.isBlank(searchEmail) && String.isBlank(searchPhone))
        {
            String searchEString = '%' + searchEmail + '%';
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c 
                            where Email_ID__c like : searchEString order by Name];
        }
        
        else if(!String.isBlank(searchName) && !String.isBlank(searchEmail) && String.isBlank(searchPhone))
        {	
            String searchString = '%' + searchName + '%';
            String searchEString = '%' + searchEmail + '%';
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c 
                            where (Name like : searchString or Last_Name__c 
                                   like : searchString) and Email_ID__c like : searchEString  order by Name];
        }
        
        else if(String.isBlank(searchName) && !String.isBlank(searchEmail) && !String.isBlank(searchPhone))
        {
            String searchEString = '%' + searchEmail + '%';
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM 
                            Student__c where Email_ID__c like : searchEString and Phone__c =: searchPhone order by Name];
        }
        else if(String.isBlank(searchName) && String.isBlank(searchEmail) && String.isBlank(searchPhone))
        {
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                        Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c]; 
        }
        else if(String.isBlank(searchName) && String.isBlank(searchEmail) && !String.isBlank(searchPhone))
       {
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                        Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c where Phone__c =:searchPhone]; 
        }
        
        else if(!String.isBlank(searchName) && String.isBlank(searchEmail) && !String.isBlank(searchPhone))
        {
            String searchString = '%' + searchName + '%';
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c 
                            where (Name like : searchString or Last_Name__c 
                                   like : searchString) and Phone__c =: searchPhone order by Name];
        }
        else if(!String.isBlank(searchName) && !String.isBlank(searchEmail) && !String.isBlank(searchPhone))
        {
            String searchString = '%' + searchName + '%';
            String searchEString = '%' + searchEmail + '%';
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c 
                            where (Name like : searchString or Last_Name__c 
                                   like : searchString) and Email_ID__c like : searchEString 
                            and Phone__c =: searchPhone order by Name];
        }
        else{
            studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                        Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c];
            //studentsList = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c Where Name like : '%00000%'];
            //delete studentsList;
        }
    }
}