trigger ProjectToProjectTaskTrigger on Project__c (after insert, before insert, before update) {
    
    List <Project__c> projectList = Trigger.new;
    if(Trigger.isInsert && Trigger.isBefore){
        for(Project__c project :projectList){
            if(! String.isEmpty(project.Status__c)){
                project.Status__c.addError('You cannot selected status directly.');
            }
        }
    }
    
    if(Trigger.isInsert && Trigger.isAfter){
        ProjectToProjectTaskTriggerHelper.insertNewProject(Trigger.new);
    }
    
    if(Trigger.isUpdate && Trigger.isBefore){
        if(! ProjectTaskToProjectTriggerHelper.updateFromTask){
            for(Project__c project : projectList){
                if( project.Status__c != Trigger.oldMap.get(project.Id).Status__c ){
                    project.Status__c.addError('You cannot selected status directly.');
                }
            }
        }
    }
}