public class QueueableApexExample Implements Queueable {
    
    public void execute(QueueableContext qc){
        Account acc = new Account(Name='Queueable Test',Phone='(415) 555-1212');
        insert acc;  
        System.debug('!!'+acc);
    }

}