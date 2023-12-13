public class InlineVfContactAttachment {
	public Id contactId;
    public List<Attachment> attachmentList{get;set;}
    public Boolean hideBlock{get;set;}
    
    public InlineVfContactAttachment(ApexPages.StandardController controller){
        contactId = controller.getId();
        hideBlock = false;
        attachmentList = [select id from attachment where ParentId =: contactId and contentType Like 'image%%'];
        if(attachmentList.size()>0){
            hideBlock = true;
        }
    }
	
}