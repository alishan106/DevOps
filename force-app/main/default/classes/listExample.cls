public class listExample {
    public listExample(){
        
        List<String> lst= new List<string> {'Alishan','Zeeshan','Mukesh','alishan','zeeshan','mukesh'};
        List<Integer>lst1=new List<Integer> {1,3,2,5,7,5};
        List<Integer> lst2 = new List<Integer>(lst1);
        lst2.addAll(lst1);
        lst.sort();
        lst1.sort();
        lst2.sort();
        System.debug(lst);
        System.debug(lst1);
        System.debug(lst2);
        
        
        
    }
    
}