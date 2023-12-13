public class ProjectToTaskToProjectTriggerHelper {
    
    public static void ProjectTaskUpdate(List<Project_Task__c> projectTask){
        
        for(Project_Task__c project : projectTask){
            if(project.Completed__c){
                Project__c projectStatus = [SELECT Id, Name, Status__c FROM Project__c WHERE Id =: project.Project__c];
                if(project.Type__c == 'New Task'){
                    projectStatus.Status__c = 'New';
                }else if(project.Type__c == 'Planning Phase'){
                    projectStatus.Status__c = 'Planning';
                }else if(project.Type__c == 'Construction Work'){
                    projectStatus.Status__c = 'Construction';
                }else if(project.Type__c == 'Completion Step'){
                    projectStatus.Status__c = 'Deployment';
                }else if(project.Type__c == 'Contract End'){
                    projectStatus.Status__c = 'Signoff';
                }
                UPDATE projectStatus;
            }
        }
        
    }
    
}