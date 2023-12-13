global class ScheduleApexExample Implements Schedulable {
    global void execute(SchedulableContext sc){
        SendMail();
    }
    
    public void SendMail(){
        AggregateResult[] count2 = [SELECT count(Id) from Contact where LastModifiedDate = THIS_WEEK];
        Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
        singleEmailMessage.setToAddresses(new List<String> {'zeeshan106@yopmail.com'});
        singleEmailMessage.setPlainTextBody('Number of Last Week edited Contact '+count2[0].get('expr0')+' next update next week');
        Messaging.sendEmail(new List<Messaging.Email>{singleEmailMessage});
        System.debug('@@@'+count2[0].get('expr0'));
    }

}