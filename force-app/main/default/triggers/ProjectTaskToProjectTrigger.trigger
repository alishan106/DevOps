trigger ProjectTaskToProjectTrigger on Project_Task__c (before update, after update) {
    
    List <Project_Task__c> projectTasksToNextValidateList = new List<Project_Task__c>();
    Set <Id> projectIdsToUpdateSet = new Set <Id>();
    List <Project_Task__c> validateProjectTasksList = new List<Project_Task__c>();
    
    for(Project_Task__c task : Trigger.new){
        Boolean oldCompleted = Trigger.oldMap.get(task.Id).Completed__c;
         
        if(task.Completed__c != oldCompleted && Trigger.isBefore){
            if(task.Completed__c ){
               validateProjectTasksList.add(task);
            }else{
                projectTasksToNextValidateList.add(task);
            }
        }
        if(task.Completed__c != oldCompleted && Trigger.isAfter){
               projectIdsToUpdateSet.add(task.Project__c);
           }
    }
    
    if(Trigger.isBefore){
        
        ProjectTaskToProjectTriggerHelper.validateDate(Trigger.new);
        
        if(projectTasksToNextValidateList.size() > 0){
            projectTasksToNextValidateList = ProjectTaskToProjectTriggerHelper.validateNext(projectTasksToNextValidateList);
            String errorMessage = 'Cannot Uncheck completion if next task is completed.';
            for(Project_Task__c task : projectTasksToNextValidateList){
                Trigger.newMap.get(task.Previous_Task__c).Completed__c.addError(errorMessage);
            }
       }
       if(validateProjectTasksList.size() > 0){
            String errorMessage = 'Cannot complete this task if preivous task is not completed.';
            for(Project_Task__c task : ProjectTaskToProjectTriggerHelper.validatePreivous(validateProjectTasksList)){
                Trigger.newMap.get(task.Id).Completed__c.addError(errorMessage);
            }
            errorMessage = 'Cannot complete this task without terms & conditions attached.';
            for(Project_Task__c task : ProjectTaskToProjectTriggerHelper.validateTermsAttachment(validateProjectTasksList)){
                Trigger.newMap.get(task.Id).Completed__c.addError(errorMessage);
            }
        } 
    }
    
    if(projectIdsToUpdateSet.size() > 0 && Trigger.isAfter){
        ProjectTaskToProjectTriggerHelper.updateFromTask = true;
        List<Project__c> projectsToUpdateList = ProjectTaskToProjectTriggerHelper.updateProjectStatus(projectIdsToUpdateSet);
        UPDATE projectsToUpdateList;
        
        projectIdsToUpdateSet.clear();
        for(Project__c project : projectsToUpdateList){
            if(project.Status__c == 'Signoff'){
                projectIdsToUpdateSet.add(project.Id);
            }
        } 
       /* if(projectIdsToUpdateSet.size() > 0){
            ProjectTaskToProjectTriggerHelper.sendCompletionMail(projectIdsToUpdateSet);
        } */
    }
    
}