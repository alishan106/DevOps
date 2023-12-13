public class ProjectTaskToProjectTriggerHelper {
    public static Boolean updateFromTask = false ;      
    
    public static void validateDate(List<Project_Task__c> projectTaskList){
        for(Project_Task__c projectTask : projectTaskList){
            if(projectTask.Completion_Date__c == NULL && projectTask.Completed__c){
                projectTask.Completion_Date__c.addError('Date is required when clicking on your checkbox. ');
            }else if(! projectTask.Completed__c && projectTask.Completion_Date__c != NULL){
                projectTask.Completed__c.addError('Completed Checkbox is Required when date is fill.');
            }
        }
    }
    
    public static List<Project_Task__c> validateNext(List<Project_Task__c> projectTaskList){
        
        Set<Id> projectTaskIdSet = new Set<Id>();
        
        for(Project_Task__c task : projectTaskList){
            projectTaskIdSet.add(task.Id);
        }
        List<Project_Task__c> failedProjectTaskList = [SELECT Id, Previous_Task__c 
                                                       FROM Project_Task__c
                                                       WHERE  Previous_Task__c in : projectTaskIdSet 
                                                       AND Id NOT in : projectTaskIdSet
                                                       AND Completed__c = true];
        return failedProjectTaskList;
    }
    
    public static List<Project_Task__c> validatePreivous(List<Project_Task__c> projectTaskList){
        Set<Id> projectTaskIdSet = new Set<Id>();
        for(Project_Task__c task : projectTaskList){
            projectTaskIdSet.add(task.Id);
        }
        List<Project_Task__c> failedProjectTaskList = [SELECT Id , Previous_Task__r.Completed__c, Type__c
                                                       FROM Project_Task__c
                                                       WHERE  Id in : projectTaskIdSet
                                                       AND Previous_Task__c NOT in : projectTaskIdSet
                                                       AND Type__c  != 'New Task'
                                                       AND Previous_Task__r.Completed__c = false];
        return failedProjectTaskList;
    }
    
    public static List<Project__c> updateProjectStatus(Set<Id> projectIdSet){
        Map<Id, Project__c> updateProjectMap = new Map<Id, Project__c>();
        String[] projectStatus = new String[]{'','New', 'Planning', 'Construction', 'Deployment', 'Signoff'};
            String[] projectTaskType = new String[]{'','New Task', 'Planning Phase', 'Construction Work', 'Completion Step', 'Contract End'};
                List <Project_Task__c> taskList = [SELECT Id, Name, Completed__c, Project__c, Type__c
                                                   From Project_Task__c 
                                                   WHERE Completed__c = true
                                                   AND Project__c in : projectIdSet  
                                                   ORDER BY Name];
        Id currentProjectId;
        if(taskList.size() > 0){
            currentProjectId = taskList.get(0).Project__c;
        }else{
            currentProjectId = Null;
        }
        for(Id projectId : projectIdSet){
            updateProjectMap.put(projectId, new Project__c(
                Id = projectId,
                Status__c = ''
            ));	    
        }
        for(Project_Task__c task : taskList){
            if(currentProjectId != task.Project__c){
                currentProjectId = task.Project__c;
            }
            updateProjectMap.get(currentProjectId).Status__c = projectStatus.get(projectTaskType.indexOf(task.Type__c));  
        }
        return updateProjectMap.values();
    }
    
    
    public static List<Project_Task__c> validateTermsAttachment(List<Project_Task__c> projectTaskList){
        Map <Id, Project_Task__c> taskIdsToListIndexMap = new Map <Id, Project_Task__c>();
        
        for(Project_Task__c task : projectTaskList){
            taskIdsToListIndexMap.put(task.Id, task);
        } 
        for(Project_Task__c task : [SELECT Id, Name, 
                                    (SELECT Description 
                                     FROM Attachments 
                                     WHERE Description = 'Terms & Conditions') 
                                    From Project_Task__c  
                                    WHERE Id in : taskIdsToListIndexMap.keySet()]){
          	if(task.Attachments.size() > 0){
            	projectTaskList.remove(projectTaskList.indexOf(taskIdsToListIndexMap.get(Task.Id)));                           
            }
        }
        return projectTaskList;
    }
    
   /* public static void sendCompletionMail(Set<Id> projectIdsSet){
        Messaging.Email[] mails = new Messaging.Email[]{};
            
        for(Project__c project : [SELECT Id, Name, Project_Owner__c, Project_Owner__r.Email
                             	  FROM Project__c 
                             	  WHERE Id in : projectIdsSet
                                  AND Project_Owner__r.Email != NULL]){
        	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] {project.Project_Owner__r.Email});
            mail.setTargetObjectId(project.Project_Owner__c);
            mail.setWhatId(project.Id);
            mail.setSaveAsActivity(false);
            mail.setTemplateId('00X5g000000IAhQ');   
            mails.add(mail);
        }
        try{
            Messaging.sendEmail(mails);
        }catch(Exception ex){
            system.debug('Mail Exception ' + ex);
        }
    } */
}