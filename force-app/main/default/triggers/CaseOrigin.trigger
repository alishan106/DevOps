trigger CaseOrigin on Case (before insert) {
    for(Case c : trigger.new){
        if(c.Origin == 'email'){
            c.Status = 'New';
            c.Priority = 'Medium';
        }
    }
  

}