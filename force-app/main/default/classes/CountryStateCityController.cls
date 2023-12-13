public class CountryStateCityController {
    public String countryValue{get;set;}
    public String stateValue{get;set;}
    public String cityValue{get;set;}
    public List<String> countryNameList{get;set;}
    public List<Country__c> countryList{get;set;}
    List<SelectOption> countryOptionList{get;set;}
    public String pinCode{get;set;}
    public List<SelectOption> stateOption;
    public List<SelectOption> cityOption;
    public Map<String,Map<String,Map<String,List<String>>>> countryMap{get;set;}
   
    public CountryStateCityController(){
        stateOption = new List<SelectOption>();
        cityOption = new List<SelectOption>();
		countryNameList = new List<String>();
        countryList = [SELECT Name, State_Name__c, City_Name__c, Pin_Code__c FROM Country__c order by Name,State_Name__c,City_Name__c ];
        countryMap = new Map<String,Map<String,Map<String,List<String>>>>();
        for(Country__c con : countryList){
            Map<String,Map<String,List<String>>> stateMap = new Map<String,Map<String,List<String>>>();
            Map<String,List<String>> cityMap = new Map<String,List<String>>();
            List<String> pincodeList = new List<String>();
            if(countryMap.containsKey(con.Name)){                    
                stateMap = countryMap.get(con.Name);
                if(stateMap.containsKey(con.State_Name__c)){
                    cityMap = stateMap.get(con.State_Name__c);  
                    if(cityMap.containsKey(con.City_Name__c)){
                        pincodeList = cityMap.get(con.City_Name__c);
                    }
                    else{
                        pincodeList = new List<String>();
                    }
                } else {                
                    cityMap = new Map<String,List<String>>();                    
                }
            } else {
                stateMap = new Map<String,Map<String,List<String>>>();
                cityMap = new Map<String,List<String>>();                                
            }
            pincodeList.add(con.Pin_Code__c);
            cityMap.put(con.City_Name__c,pincodeList);
            stateMap.put(con.State_Name__c,cityMap);
            countryMap.put(con.Name,stateMap);
        }
        countryNameList.addAll(countryMap.keySet());
    }
   public List<SelectOption> getCountry(){
        List<SelectOption> countryOptionList = new List<SelectOption>();
       
        for(String countryName : countryMap.keySet()){
            countryOptionList.add(new SelectOption(countryName,countryName));
        }
        return countryOptionList;
    }
    public void showState(){  
        stateValue = '';
        pinCode = '';
        if(String.isBlank(countryValue)){
            stateOption.clear();
            cityOption.clear();
        } else {
            stateOption = new List<SelectOption>();
            cityOption = new List<SelectOption>();
            for(String state : countryMap.get(countryValue).keySet()){
                stateOption.add(new SelectOption(state,state));
            }
        }
    }
    public List<SelectOption> getState(){
        return stateOption;
    }
   
    public void showCity(){        
        cityValue = '';
        pinCode = '';
        if(String.isBlank(stateValue)){
            cityOption.clear();
        } else {
            cityOption = new List<SelectOption>();
            for(String city : countryMap.get(countryValue).get(stateValue).KeySet()){
                cityOption.add(new SelectOption(city,city));
            }
        }
    }
    public List<SelectOption> getCity(){
        return cityOption;
    }   
    public void showPin(){
        pinCode = '';
        for(Country__c count : countryList){
            if(count.Name == countryValue && count.State_Name__c == StateValue && count.City_Name__c == cityValue ){
                pinCode = count.Pin_Code__c+'';
                //System.debug('%%%%%%'+count.Pin_Code__c);
            }
            //System.debug('####'+count.Pin_Code__c);
        }   
    }
}