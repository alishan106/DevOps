public class InsertRecordsController {
    @AuraEnabled(cacheable=true)
    public static List<ObjectDetailsWrapper> getListOfObjDetails() {
        Map<String, SObjectType> mapOfObjs = schema.getGlobalDescribe();
        if(mapOfObjs != null && mapOfObjs.keySet() != null) {
            List<ObjectDetailsWrapper> lstOfObjWrapper 
                = new List<ObjectDetailsWrapper>();
            
            for(String key: mapOfObjs.keySet()) {
                ObjectDetailsWrapper objWrapInst 
                    = new ObjectDetailsWrapper();
                if(mapOfObjs.get(key) != null 
                   && mapOfObjs.get(key).getDescribe() != null)
                    objWrapInst.objLabel 
                    = mapOfObjs.get(key).getDescribe().getLabel();
                objWrapInst.objAPI = key;
                
                lstOfObjWrapper.add(objWrapInst);
            }
            
            return lstOfObjWrapper;
        }
        return null;
    }
    @AuraEnabled(cacheable=true)
    public static List<FieldDetailsWrapper> getFields(String selectedObject){
        
        Map<String, sObjectType> schemaMap = Schema.getGlobalDescribe();
        map<string,SObjectField> fieldMap = schema.getGlobalDescribe().get(selectedObject).getDescribe().fields.getMap();
        
        if(fieldMap != null && fieldMap.keySet() != null) {
            List<FieldDetailsWrapper> lstOfFieldWrapper = new List<FieldDetailsWrapper>();
            for(String key: fieldMap.keySet()) {
                FieldDetailsWrapper fieldWrapInst = new FieldDetailsWrapper();
                if(fieldMap.get(key).getDescribe().isUpdateable() && fieldMap.get(key) != null && fieldMap.get(key).getDescribe() != null)
                    fieldWrapInst.label = fieldMap.get(key).getDescribe().getLabel();
                	fieldWrapInst.apiName = key;
                	fieldWrapInst.isRequired = fieldMap.get(key).getDescribe().isNillable();
                	fieldWrapInst.fieldType = String.valueOf(fieldMap.get(key).getDescribe().getType());
                	System.debug(fieldMap.get(key).getDescribe().getType()+'@@'+key);
                
                lstOfFieldWrapper.add(fieldWrapInst);
            }
            
            System.debug(fieldMap);
            return lstOfFieldWrapper;
        }
        return null;
        
    }
    
    public class ObjectDetailsWrapper {
        @AuraEnabled
        public String objLabel;
        @AuraEnabled
        public String objAPI;
    }
    
    public class FieldDetailsWrapper {
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String apiName;
        @AuraEnabled
        public Boolean isRequired;
        @AuraEnabled
        public String fieldType;
    }
    
}