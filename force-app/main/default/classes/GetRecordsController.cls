public class GetRecordsController {
    
    @AuraEnabled(cacheable=true)
    public static List<wrapperClass> getFields(String Obj){
       Obj = 'Case';
       List<SelectOption> fieldNames = new List<SelectOption>();
        List<wrapperClass> wrapperList = new List<wrapperClass>();
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType ObjSchema = schemaMap.get(Obj);
            Map<String, Schema.SObjectField> fieldMap = ObjSchema.getDescribe().fields.getMap();
            for (String fieldName: fieldMap.keySet()) 
                {                      
                    wrapperClass wc = new wrapperClass();
                    if(fieldMap.get(fieldName).getDescribe().isUpdateable()){
                    wc.label = fieldMap.get(fieldName).getDescribe().getLabel();
                    wc.value = fieldName;
                    wrapperList.add(wc);
                    }
                }
        return wrapperList;
    }    
    public class wrapperClass {
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String value;
    }


}