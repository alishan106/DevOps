public class MergeAttachmentController{
    
    public List<selectOption> objOptionList {get;set;}
    public List<attachmentWrapperClass> attachmentWrapperList {get;set;}  
    public List<objectWrapperClass> objectWrapperList {get;set;} 
    public String[] objName = new String[]{'Account', 'Contact', 'Opportunity', 'Product2'};
    public String selectedObject {get;set;}
    public Boolean showAttachment {get;set;}
    public Boolean isHeaderChecked {get;set;}
    public Boolean isMerge {get;set;}
    public Boolean isCopy {get;set;}
    public Boolean showPopup {get;set;}
    public String mergeObject {get;set;}
    
    public MergeAttachmentController(){ 
        objOptionList = new List<selectOption>();
        for(String name: objName){
            objOptionList.add(new selectOption(name , name));
        } 
    }
    
    public void getAttachments(){
        if(!String.isEmpty(selectedObject)){
            String query ='SELECT Id FROM ';
            query += selectedObject;
            Integer index = 1;
            Map <Id,sObject> objectRecord = new Map<Id,sObject>(Database.query(query));
            List<Attachment> attachmentList = [SELECT Id, Name, ContentType, IsPrivate, BodyLength, Body, 
                                               Description FROM Attachment WHERE
                                               ContentType LIKE 'image%%' AND
                                               ParentId in : objectRecord.keySet()];
            attachmentWrapperList = new List<AttachmentWrapperClass>();
            for(Attachment obj : attachmentList){
                attachmentWrapperList.add(new AttachmentWrapperClass(index++, obj) );
            }
            if(attachmentWrapperList.size() > 0){
                showAttachment = true;
            }
        }
        else{
            showAttachment = false;
        }
    }
    
    public void getObjectRecords(){
        if(!String.isEmpty(mergeObject)){
            String query ='SELECT Id,Name FROM ';
            query += mergeObject;
            List<sObject> objectList = Database.query(query);
            objectWrapperList = new List<ObjectWrapperClass>();
            Integer index = 1;
            for(sObject obj : objectList){
                objectWrapperList.add(new ObjectWrapperClass(index++, obj));
            } 
        }
        else{
            objectWrapperList = new List<ObjectWrapperClass>();
        }
    }
    
    public void checkboxHeader(){
        for(AttachmentWrapperClass obj : attachmentWrapperList){
            obj.isChecked = isHeaderChecked;
        }  
        if(isHeaderChecked){
            isMerge = true;
        }
        else{
            isMerge = false;
        }
    }
    
    public void unselectHeader(){
        isHeaderChecked = true;
        for(AttachmentWrapperClass obj : attachmentWrapperList){
            if(! obj.isChecked){
                isHeaderChecked = false;
                break;
            }
        }
        Integer count = 0;
        for(AttachmentWrapperClass obj : attachmentWrapperList){
            if(obj.isChecked){
                count++;
            }
        }
        if(count > 0){
            isMerge = true;
        }else{
            isMerge = false;
        }
    }
    
    public void copyButton(){
        for(ObjectWrapperClass obj : objectWrapperList){
            if( obj.isChecked){
                isCopy = true;
                break;
            }else{
                isCopy = false;
            }   
        }
    }
    
    public PageReference copy(){
        List<Attachment> checkedAttachmentList = new  List<Attachment>();
        List<sObject> checkedObjectList = new  List<sObject>();
        List<Attachment> insertAttachmentList = new  List<Attachment>();
        
        for(AttachmentWrapperClass obj : attachmentWrapperList){
            if(obj.isChecked){
                obj.attachmentObj.Id = NULL;
                checkedAttachmentList.add(obj.attachmentObj);	
            }
        }
        for(ObjectWrapperClass obj : objectWrapperList){
            if(obj.isChecked){
                for(Attachment attach : checkedAttachmentList){
                    insertAttachmentList.add(new Attachment(ParentId = obj.recordObj.Id, Name = attach.Name,body = attach.Body
                                                            ,ContentType = Attach.ContentType));
                }
            }
        }
        
        if(insertAttachmentList.size() > 0){   
            INSERT insertAttachmentList;      
        } 
        return new PageReference('/apex/merge_attachment').setRedirect(true);
    }
    
    public PageReference cancel(){
        return new PageReference('/apex/merge_attachment').setRedirect(true);
    }
    
    public void mergePopup(){
        showPopup = true;
    }
    
    public class AttachmentWrapperClass{
        
        public Attachment attachmentObj {get;set;}
        public Integer rowNumber {get;set;}
        public Boolean isChecked {get;set;}
        
        public AttachmentWrapperClass(Integer sno, Attachment obj){
            attachmentObj = obj;
            rowNumber = sno;
        }
    }
    
    public class ObjectWrapperClass{
        public sObject recordObj {get;set;}
        public Id      recordId  {get;set;}
        public Integer rowNumber {get;set;}
        public Boolean isChecked {get;set;}
        
        public ObjectWrapperClass(Integer sno, sObject sObj){
            recordObj = sObj;
            rowNumber = sno;
        } 
    }
}