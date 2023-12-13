public class mapExample {
    public mapExample(){
        Map<Integer,String> mapVer= new Map<Integer,String>();
        mapVer.put(1,'Alishan');
		mapVer.put(2,'Zeeshan');
		System.debug(mapVer);
        
        Map<String, String> colorCodes = new Map<String, String>();
        
        colorCodes.put('Red', 'FF0000');
        colorCodes.put('Blue', '0000A0');
        
        String myColor = colorCodes.remove('Blue');
        String code2 = colorCodes.get('Blue');
        
        System.debug(colorCodes);        
        
        
    }

}