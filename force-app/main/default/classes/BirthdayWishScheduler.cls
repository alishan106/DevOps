global class BirthdayWishScheduler Implements Schedulable {
    global void execute(SchedulableContext sc){
        BirthdayWishBatch batch = new BirthdayWishBatch();
        database.executebatch(batch);
    }    
}