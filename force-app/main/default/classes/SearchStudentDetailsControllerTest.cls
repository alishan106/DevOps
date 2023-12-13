@isTest
public class SearchStudentDetailsControllerTest {
	
    public String searchFname {get;set;}
    
    public static testMethod void SearchStudent(){
        
        Student__c stuList = new Student__c();
        stuList.Name='Alfaz';
        stuList.Gender__c='Male';
        stuList.DOB__c=date.parse('12/27/2000');
        stuList.Email_ID__c='alfa@gmail.com';
        Test.startTest();
        insert stuList;
        Student__c stu = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c where Name=:'Alfaz'];
        
        System.assert(stu!=NULL);
       
        SearchStudentDetailsController SearchStudentDetailsControllerObj = new SearchStudentDetailsController();
        SearchStudentDetailsControllerObj.doSearch(); 
        String searchFname = '%'+stu.Name+'%';
        if(!String.isBlank(searchFname) && (stu.DOB__c==NULL)){
            try{
        Student__c serStu = [SELECT Id, Name, DOB__c, Email_ID__c,Marital_Status__c,
                            Phone__c,Last_Name__c,Class__c, Gender__c FROM Student__c where Name Like : searchFname];
            }
            catch
                (System.DmlException ex)
            {
            }
        }
        Test.stopTest();
    }
    
}