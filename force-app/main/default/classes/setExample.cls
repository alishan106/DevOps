public class setExample {
    public setExample(){
        Set<Integer> setVer= new Set<Integer>{1,4,2,3,6,1,8,9,0,8,7,5};
        List<Integer> lstVer= new List<Integer>{11,14,12,13,16,11,18,19,10,18,17,15};
        Set<String> setVer3 = new Set<String>{'a','g','e','c','s','z','A','W','V','S','Q','G','S','R','e','a','S','V'};
        Set<Integer> setVer1= new Set<Integer>(setVer);   
        Set<Integer> setVer2= new Set<Integer>(lstVer); 
        boolean result=setVer.isEmpty();
        System.debug(result);
        System.debug(setVer1);
        System.debug(lstVer);
        System.debug(setVer2);
        System.debug(setVer3);
    }

}