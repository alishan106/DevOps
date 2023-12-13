trigger TotalRatingAccountTrigger on Account (after insert, after update, after delete, after undelete) {
    
    if(TotalRatingAccountTriggerHelper.isFirstTime){
        TotalRatingAccountTriggerHelper.isFirstTime = false;
        TotalRatingAccountTriggerHelper.setRatingCount(Trigger.new);
    }

}