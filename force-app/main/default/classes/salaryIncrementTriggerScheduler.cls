global class salaryIncrementTriggerScheduler implements Schedulable
{
    global void execute(SchedulableContext sc)
    {        
        List<Contact> allConList = [SELECT FirstName, Id, Net_Salary__c, Increment_Date__c, Increment_Check__c, Increment__c, Salary__c FROM Contact where Increment_Check__c = true];      
        List<Contact> newConList = new List<Contact>();
        for(Contact con :allConList){
            con.Increment_Check__c = false;
            con.Increment__c = null;
            newConList.add(con);
        }
        if(newConList.size() > 0){
            Update newConList;
        }
    }
    
}