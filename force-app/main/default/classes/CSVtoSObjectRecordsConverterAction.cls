/*Sricharan Puligundla Added the class for Agent Dashboard Management
Updated the class for Loading multiple records */
public class CSVtoSObjectRecordsConverterAction {

    public class ActionInput{
        @InvocableVariable(label='Object API Name' required=true)
        public string objectApiName;
        
        @InvocableVariable(label='CSV File ID' required=true)
        public string contentDocuemtId;
    }

    public class ActionOutput{
        @InvocableVariable(label='List(collection) of Records')
        public sObject[] records;
    }

    public class FlowCustomException extends Exception{}

    @InvocableMethod(label='CSV to SObject records Converter')
    public static ActionOutput[] csvToSObjectsRecordsConverter(ActionInput[] inputs) {
        if(inputs.size() > 1) {
            throw new FlowCustomException('This action is only supported in Screen flows.');
        }

        SObjectType sObjType = ((SObject)Type.forName(inputs[0].objectApiName).newInstance()).getSObjectType();
        map<String,SObjectField> fieldMap = sObjType.getDescribe().fields.getMap();
        
        Blob csvBlobContent = getCsvContent(inputs[0].contentDocuemtId);
        String csvStringContent = blobToString(csvBlobContent, 'ISO-8859-1');
        csvStringContent = csvStringContent.replaceAll('(\r\n|\r)','\n');
        
        String[] csvRows = csvStringContent.split('\n');
        String[] fields = csvRows[0].split(','); //Gives all the API names of the fields from the 1st CSV row
        csvRows.remove(0);
        map<String,Schema.DisplayType> fieldToFieldTypeMap = new map<String,Schema.DisplayType>();
        for (String field : fields) {
            fieldToFieldTypeMap.put(field, getFieldType(fieldMap, field));
        }

        ActionOutput[] lstOutput = new ActionOutput[]{};
        ActionOutput output = new ActionOutput();
        output.records = new SObject[]{};
        for(String row : csvRows) {
            SObject obj = sObjType.newSObject();
            String[] fieldInputValues = row.split(',',10000);
            System.debug('fieldvalues are' +fieldInputValues);
            for (Integer i = 0; i < fields.size(); i++) {
            //added below if condition to fix the error
                //if (fieldInputValues.size() > 0){
                String fieldValue = fieldInputValues[i];
                Schema.DisplayType fieldType = fieldToFieldTypeMap.get(fields[i]);
                obj.put( fields[i], getConvertedFieldValue(fieldType, fieldValue));
               // }//added this condition to fix the error
            }
            output.records.add(obj);
        }
        lstOutput.add(output);
        return lstOutput;
    }

    static Blob getCsvContent( String contentDocuemtId) {
        
        ContentVersion csvFile = [SELECT 
                                   VersionData 
                                   FROM ContentVersion 
                                   WHERE ContentDocumentId = :contentDocuemtId 
                                         AND IsLatest = true
                                 ];
        return csvFile.VersionData;
    }

    /* Converting the CSV file input(BLOB format) to a string */
    static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    } 

    static Object getConvertedFieldValue(Schema.DisplayType fieldType, String fieldValue){
        Object convertedFieldValue;
        switch on fieldType {//Setting Field value based on the field data type
            when BOOLEAN {
                convertedfieldValue = String.isEmpty(fieldValue) ? false : Boolean.valueOf(fieldValue);
            }
            when DOUBLE {
                convertedfieldValue = String.isEmpty(fieldValue) ? null : Decimal.valueOf(fieldValue);
            }
            when CURRENCY {
                convertedfieldValue = String.isEmpty(fieldValue) ? null : Decimal.valueOf(fieldValue);
            }
            when INTEGER {
                convertedfieldValue = String.isEmpty(fieldValue) ? null : Integer.valueOf(fieldValue);
            }
            when else { 
                convertedfieldValue = fieldValue;
            }
        }
        return convertedFieldValue;
    }

    @TestVisible
    static Schema.DisplayType getFieldType(map<String, SObjectField> fieldMap, String fieldApiName) {
        if(fieldMap.get(fieldApiName) == null) {
            throw new FlowCustomException('Invalid Field Error: '+fieldApiName + '. Please double check the API name of the field.');
        }
        return fieldMap.get(fieldApiName).getDescribe().getType();
    }
}