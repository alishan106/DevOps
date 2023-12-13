trigger ContactTrigger on Contact (after update) {
    if(RecurtionController.flag){
        RecurtionController.flag = False;
        if(Trigger.isAfter && Trigger.isUpdate){
            if(Trigger.newMap != Trigger.oldMap){
                List<Contact> conRecords = new List<Contact>();
                System.debug('Trigger.new'+Trigger.newMap.equals(Trigger.oldMap));
                System.debug('Trigger.oldMap'+Trigger.oldMap);
                for(Contact conRec : Trigger.new){
                    Contact con = new Contact();
                    con.Id = conRec.Id;
                    con.LastName = 'Zeeshan Ali';
                    conRecords.add(con);
                }
                if(conRecords.size() > 0){
                    UPDATE conRecords;
                } 
            }
        }
    }
}

/*Map<String,Id> accountNameToAccID = new Map<String,Id>();
Set<String> setOfNames = new Set<String>();
for(Contact con : trigger.new){
setOfNames.add(con.LastName); 
}

system.debug('###'+setOfNames);

List<Account> accList = [SELECT Id, Name FROM Account where Name in :setOfNames];
for(Account acc : accList){
accountNameToAccID.put(acc.Name,acc.Id);
}

system.debug('$$$'+accountNameToAccID);

for(Contact con : trigger.new){
if(accountNameToAccID.containsKey(con.LastName)){
con.AccountId = accountNameToAccID.get(con.LastName);                
}  
}
system.debug('@@@'+trigger.new);   
} */

/*
if(Trigger.isInsert && Trigger.isBefore){
for(Contact con : Trigger.new){
if(con.Increment_Check__c){
con.Increment_Check__c.addError('field can not be checked');
system.debug('con.Salary__c'+con.Salary__c);
}
else if(con.Salary__c == null){
con.Salary__c.addError('field can not be empty');
}
else if(con.Increment__c != null){
con.Increment__c.addError('field should be empty');                 
}
else if(con.Increment_Date__c != date.today()){
con.Increment_Date__c.addError('date should be today\'s date');                 
}else{                
con.Net_Salary__c = con.Salary__c;
}
}        
}

if(Trigger.isUpdate && Trigger.isBefore){
Map<Id, Contact> oldMap = Trigger.oldMap; 
for(Contact con : Trigger.new){
if(!oldMap.get(con.Id).Increment_Check__c){
if(!con.Increment_Check__c){
con.Increment_Check__c.addError('Check required');
}
else if(con.Increment__c == null){
con.Increment__c.addError('field can not be empty');                 
}
else if(con.Salary__c == null){
con.Salary__c.addError('field can not be updatable');
}
else if(!(con.Increment_Date__c > oldMap.get(con.Id).Increment_Date__c.addDays(364))){
con.Increment_Date__c.addError('date should be one year later from privious increment date');                 
}
else{
con.Net_Salary__c = con.Salary__c + (con.Salary__c * con.Increment__c)/100;
con.Salary__c = con.Net_Salary__c; 
}
}
}        
}
*/
/*
Map<id, Contact>  accContactMap = new  Map<id, Contact>();
if(Trigger.isInsert){
for(Contact con : Trigger.new){        
if(con.Update_Sibling_Address__c && con.AccountId != null){
if(accContactMap.containsKey(con.AccountId)){
accContactMap.put(con.AccountId, con);            
}else{
accContactMap.put(con.AccountId, con);
}           
}              
}
}
if(Trigger.isUpdate){
Map<Id, Contact>  oldMap = new Map<Id, Contact>();
oldMap = Trigger.oldMap;
for(Contact con : Trigger.new){ 
Contact conObj = new Contact();
conObj = Trigger.oldMap.get(con.Id);
if(con.MailingCity != conObj.MailingCity ||
con.MailingCountry != conObj.MailingCountry ||
con.MailingState != conObj.MailingState ||
con.MailingPostalCode != conObj.MailingPostalCode){
system.debug('con'+con);
if(con.Update_Sibling_Address__c && con.AccountId != null){
if(accContactMap.containsKey(con.AccountId)){
accContactMap.put(con.AccountId, con);            
}else{
accContactMap.put(con.AccountId, con);
}           
}
}
}
}
List<Contact> allContactList = [SELECT Id ,AccountId, MailingCity, MailingCountry, MailingPostalCode, MailingState From Contact];
List<Contact> contactForUpdate = new List<Contact>();
for(Contact conUpdate : allContactList){
if(accContactMap.containsKey(conUpdate.AccountId)){
conUpdate.MailingCity = accContactMap.get(conUpdate.AccountId).MailingCity;
conUpdate.MailingState = accContactMap.get(conUpdate.AccountId).MailingState;
conUpdate.MailingCountry = accContactMap.get(conUpdate.AccountId).MailingCountry;            
conUpdate.MailingPostalCode = accContactMap.get(conUpdate.AccountId).MailingPostalCode;
contactForUpdate.add(conUpdate);
}         
}
if(contactForUpdate.size() > 0){
UPDATE contactForUpdate;
}

trigger contactTrigger on Contact (after insert,after update, after delete) {
if(RecursiveTriggerHandler.isFirstTime){
RecursiveTriggerHandler.isFirstTime = false;
List<Contact> newCon = new List<Contact>();
if((trigger.isUpdate && trigger.isAfter ) || (trigger.isInsert && trigger.isAfter )){
newCon = trigger.new;
}
if(trigger.isDelete && trigger.isAfter){
newCon = trigger.old;
}
Set<Id> setOfAccountId = new Set<Id>();
Map<Id,Integer> accMap = new Map<Id,Integer>();
for(Contact con : newCon){
if(con.AccountId != null){
setOfAccountId.add(con.AccountId);
}
}
List<Account> listOfAccount = [SELECT ID,(SELECT Id from Contacts) from Account WHERE Id in : setOfAccountId];
for(Account acc : listOfAccount){
System.debug('acc.contacts.size()'+acc.contacts.size());
accMap.put(acc.Id,acc.contacts.size());
}
List<Contact> conList = [SELECT Id, AccountId FROM Contact WHERE AccountId IN : setOfAccountId];
System.debug('conList'+conList.size());
List<Contact> conList1 = new  List<Contact>();
for(Contact cont : conList){
system.debug('contains'+accMap.containsKey(cont.AccountId));
system.debug('cont>id'+cont.Id);
if(accMap.containsKey(cont.AccountId)){
cont.Account_Count__c = accMap.get(cont.AccountId);
}
}
if(conList.size()>0){
UPDATE conList;
}
// }
}

if(trigger.isAfter && trigger.isUpdate){
for(Contact con : Trigger.new){
RenderAsPdf.renderMethod(con.Id);

new SubmittleDocumentsController().SubmittleDocuments(con.Id);
if(con.Type__c == 'Completed'){
PageReference PDf =  Page.submittalDocumentVF;//Replace attachmentPDf with the page you have rendered as PDF
PDf.setRedirect(true);
Attachment attach = new Attachment();
Blob b ;
b = PDf.getContent();
attach.Body = b;
attach.Name = 'E-HealthJobs Submittal 1 '+con.LastName+'.pdf';
attach.IsPrivate = false;
attach.ParentId = con.Id;
insert attach;
}

}
}

}*/


/*
trigger contactTriggr on Contact(before insert, before update){

	if(trigger.isBefore && (trigger.isUpdate || trigger.isInsert)){	
		contactTriggrHalper.updateContactEmail(trigger.new, trigger.old, trigger.oldMap);	
	}
}
*/