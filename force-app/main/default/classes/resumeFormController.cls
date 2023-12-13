public class resumeFormController {
    
    public string firstName {get;set;}
    public void resumeFormController(){
        firstName = 'John';
    }
    public void handleFirstName(){
        system.debug('firstName'+firstName);
    }
    public void handleButton(){
    }
    
}