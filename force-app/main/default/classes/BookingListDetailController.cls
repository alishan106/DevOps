public class BookingListDetailController {
    public List<BookingWrapper> bookingList {get;set;}
    public Integer index {get;set;}
    public Id bookingId{get;set;}
    public BookingListDetailController(){
        Integer index = 1;
        bookingList = new List<BookingWrapper>();
        for(Booking__c booking : [SELECT Id, Name,Customer__r.Name, Room_No__c, Customer__c, Status__c, Total_Hours__c, Amount__c, 
                                  Customer_Email__c,Check_In_Time__c, Check_Out_Time__c FROM Booking__c]){
                                      if(booking.Total_Hours__c!= NULL){
                                          bookingList.add(new BookingWrapper(booking,index++));
                                      }          
                                  }
        System.debug('list---'+bookingList);
    }
    
    public pageReference switch() {
        PageReference pageRef = new PageReference('http://www.google.com');
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference savePdf(){
        System.debug('id  '+index);
        BookingWrapper booking = bookingList.get(index-1);
        System.debug('----'+booking);
        bookingId = booking.booking.Id;
        PageReference pdf = new PageReference('/apex/booking_invoice_file?id='+booking.booking.Id);
        Blob bill = pdf.getContentAsPDF();
        booking.attachments.Name = booking.booking.Customer__r.Name + ' bill.pdf';
        booking.attachments.body = bill;
        booking.attachments.contentType = 'application/pdf';
        booking.attachments.ParentID = booking.booking.Id;
        try{
            insert booking.attachments;
        }
        catch(Exception e){
            System.debug('Sharma'+e.getMessage());
        }
        booking.renderSend = true;
        //pdf.setRedirect(true);
        return null;
    }
    
    public void sendEmail(){
        BookingWrapper booking = bookingList.get(index-1);
        Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
        
        singleEmailMessage.setToAddresses(new String[]{booking.booking.Customer_Email__c});
        singleEmailMessage.setSubject('Bill Of Your Hotel Room');
        singleEmailMessage.setPlainTextBody('Please Find Your Bill Attachment Below');
        Messaging.EmailFileAttachment emailFileAttachment = new Messaging.EmailFileAttachment();
        emailFileAttachment.setFileName(booking.attachments.Name);
        
        emailFileAttachment.setBody(booking.attachments.Body);
        
        Messaging.EmailFileAttachment[] attachments = new Messaging.EmailFileAttachment[]{emailFileAttachment};
            
            singleEmailMessage.setFileAttachments(attachments);
        
        Messaging.SendEmailResult[] result = Messaging.sendEmail(new Messaging.Email[]{singleEmailMessage});
        if(result[0].success){
            System.debug('email send successfully');
        } else {
            System.debug('Error : '+result[0].errors[0].message);
        }
    }
    
    public class BookingWrapper{
        public Booking__c booking {get;set;}
        public Integer index {get;set;}
        public Boolean renderSend{get;set;}
        public Attachment attachments {get;set;}
        public BookingWrapper(Booking__c booking,Integer index){
            this.attachments = new Attachment();
            this.booking = booking;
            this.index = index;
        }
    }
}