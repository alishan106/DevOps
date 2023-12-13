public class SubmittleDocumentsController {
    public String currentRecordId {get;set;}
    public Contact conObj {get;set;}
    public List<String> glance {get;set;}
    public SubmittleDocumentsController(){
        conObj = [select Id, FirstName, LastName, Email, AccountId, Birthday__c, Salary__c,  Department, Designation__c, Account_Count__c, Increment__c,Type__c, Phone, Parent_Account_Name__c, Net_Salary__c, Increment_Date__c, Languages__c, Level__c FROM contact WHERE Id = '0035g000005YsapAAC'];
         //currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        glance = new List<String>{'The first element in the collection visibly rendered, where 0 is the index of the first element in the set of data specified by the value attribute. For example, if you did not want to display the first two elements in the set of records specified by the value attribute, set first="2".','An identifier that allows the repeat component to be referenced by other components in the page.','A Boolean value that specifies whether the component is rendered on the page. If not specified, this value defaults to true.','The maximum number of items in the collection that are rendered. If this value is less than the number of items in the collection, the items at the end of the collection are not repeated.','The collection of data that is iterated over.','The name of the variable that represents the current item in the iteration.'};
    }
}