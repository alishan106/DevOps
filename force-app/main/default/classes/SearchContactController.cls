/*
    Name		: SearchContactController
    Date		: 17 May, 2021
    Author		: Zeeshan Ali
    Description : This class is an custom controller for search_contacts. 
    With the help of this class we have implemented searching
    in contacts based on user input and user also view records according to their selection.
*/    
public class SearchContactController {      
    public String searchValue {get;set;}
    public Integer totalRecords {get;set;}
    public Integer recordSize {get;set;}    
    public List<Contact> contactList;
    Integer totalPages;
    Integer offsetValue;
    Integer pageNumber;
    
    //constructor for this class
    public SearchContactController(){ 
        searchValue = '';
        doSearch(); //action for search contacts        
    }     
    
    //return the value of record size
    public List<SelectOption> getSelectList(){        
        List<SelectOption> selectList = new List<SelectOption>();
        selectList.add(new SelectOption(''+totalRecords,'All'));
        selectList.add(new SelectOption('5','5'));
        selectList.add(new SelectOption('10','10'));        
        selectList.add(new SelectOption('15','15'));
        selectList.add(new SelectOption('20','20'));        
        return selectList;
    }    
    ////query records of all contact and also according to their search input
    public void doSearch(){
        offsetValue = 0;
        recordSize = 5;
        pageNumber = 1;        
        String searchString = '%' + searchValue + '%';
        contactList = [SELECT Name, Email, AccountId, Phone, Type__c
                       FROM Contact WHERE Name LIKE : searchString 
                       OR Email LIKE : searchString];
        totalRecords = contactList.size();
        totalNoOfPages(); //method to get the total number of pages.
    }
    //records of all contact and set according to select options
    public List<Contact> getContactList(){
        List<Contact> contacts = new List<Contact>();
        Integer length;
        if((offsetValue + recordSize) < totalRecords){
            length = (offsetValue + recordSize);
        }
        else{
            length = totalRecords;
        }
        for(Integer index = offsetValue; index < length; index++){
            contacts.add(contactList[index]);
        }
        return contacts;
    } 
    
    //method to get the total number of pages.
    public void totalNoOfPages(){
        totalPages = (Integer)math.ceil(totalRecords/recordSize);
        offsetValue = 0;
        pageNumber = 1;
        if(math.mod(totalRecords,recordSize) != 0){
            totalPages += 1;
        }
    }    
    //action call for last page to set page no
    public void first(){
        offsetValue = 0;
        pageNumber = 1;
    }
    //action call for previous page to set page accordingly
    public void previous(){
        offsetValue -= recordSize;
        pageNumber -= 1;        
    }
    //action call for next page to set page accordingly
    public void next(){        
        offsetValue += recordSize;
        pageNumber += 1;
    }    
    //action call for last page to set page accordingly
    public void last(){
        if(math.mod(totalRecords, recordSize) == 0){
            offsetValue = (totalRecords - recordSize);
        }
        else{
            offsetValue = totalRecords - math.mod(totalRecords, recordSize);
        }
        pageNumber = totalPages;
    }
    
    //enable or disable pagination button basis of records
    public boolean getpreviousDisable(){
        if(pageNumber == 1 || totalRecords == 0){
            return true;
        }else{
            return false;   
        }
    }
    
    //enable or disable pagination button basis of records
    public boolean getNextDisable(){
        if(pageNumber == totalPages || totalRecords == 0){
            return true;
        }else{
            return false;   
        }
    }
}