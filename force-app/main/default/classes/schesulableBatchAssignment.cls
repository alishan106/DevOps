global class schesulableBatchAssignment implements Schedulable
{
    global void execute(SchedulableContext sc)
    {        
        assignAccountIntoContactBatch b = new assignAccountIntoContactBatch ();      
     
        database.executebatch(b,2);
    }
   
}