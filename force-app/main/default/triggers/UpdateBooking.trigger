trigger UpdateBooking on Booking__c (before insert,before update, after insert, after update) {
    if(Trigger.isBefore){
        //adderror('Before Insert');
        //Phone = '987654321';
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        //before
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        //after
    }
}