public class ProjectToProjectTaskTriggerHelper {
    
    public static void insertNewProject(List<Project__c> projectTask){
        
        String[] projectTaskType = new String[]{'New Task', 'Planning Phase', 'Construction Work', 'Completion Step', 'Contract End'};
            List<Project_Task__c> projectTaskList = New List<Project_Task__c>();
        
        for(Project__c project : projectTask){            
            for(Integer index = 0; index < 5; index++){
                projectTaskList.add(new Project_Task__c(Type__c = projectTaskType[index], Project__c = project.Id));  
            }                  
        }        
        insert projectTaskList;
        
        for(Integer index = 0; index < projectTaskList.size(); index++){
            if(projectTaskList.get(index).Type__c != 'New Task'){
                projectTaskList.get(index).Previous_Task__c = projectTaskList.get(index - 1).Id;
            }
        }
        update projectTaskList;
    }
}