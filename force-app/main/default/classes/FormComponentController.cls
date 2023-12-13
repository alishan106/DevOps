public class FormComponentController{
    public String city{get;set;}
    public String name{get;set;}
    public String gender{get;set;}
    public String hobby{get;set;}
    public List<String> nameList{get;set;}
    public List<String> friends{get;set;}
    //	public List<SelectOption> nameOptionList{get;set;}
    public FormComponentController(){
        city = 'jaipur';
        nameList = new List<String>();
        nameList.add('Amit');
        nameList.add('Amita');
        nameList.add('Sumita');
        nameList.add('Sumit');
        nameList.add('Kavita');
        
        friends = new List<String>();
        
        /*	nameOptionList = new List<SelectOption>();
        for(String name : nameList){
        	nameOptionList.add(new SelectOption(name,name));			//	Value , Label
       	}	*/
    }
    
    public List<SelectOption> getNameOptionList(){
        List<SelectOption> nameOptions = new List<SelectOption>();
        nameOptions.add(new SelectOption('','- None -'));
        for(String name : nameList){
        	nameOptions.add(new SelectOption(name,name));			//	Value , Label
       	}
        return nameOptions;
    }
    
    public void onShowCity(){
        System.debug('@@ '+city);
    }
    
    public void onShowName(){
        System.debug('Method Called');
    }
    public void onShowFriends(){
        System.debug('## '+friends);
    }
   
    public void onShowgender(){
        System.debug('## '+gender);
    }
}