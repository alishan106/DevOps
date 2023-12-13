global class countContactBatch implements Database.Batchable<sObject>, Database.Stateful{
    
    String whereCondition;
    global Integer Count = 0;
    
    public countContactBatch(String con) {        
        this.whereCondition = con;       
    }
    public Database.QueryLocator start(Database.BatchableContext context) {        
        String query = 'Select id,(select Id from MessagingSessions),(select ContactId from Cases),(select whoid from Tasks),(select ContactId from LiveChatTranscripts) from contact WHERE '+whereCondition;
        return Database.getQueryLocator(query);        
    }
    public void execute(Database.BatchableContext context, List<Contact> scope) {        
        for(Contact co:scope){
            if(co.Tasks.Size() <= 0 && co.Cases.Size() <= 0 && co.MessagingSessions.Size() <= 0 && co.LiveChatTranscripts.Size() <= 0){
                Count+=1;
            }
        }        
    }    
    public void finish(Database.BatchableContext context) {        
        // Handle post-processing tasks if needed
        System.debug('Count : '+Count);        
    }    
}