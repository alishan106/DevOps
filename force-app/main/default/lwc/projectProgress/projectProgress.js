import { LightningElement, track , api, wire } from 'lwc';
import { getRecord }from 'lightning/uiRecordApi';

export default class ProjectProgress extends LightningElement {
    @api recordId;
    @track selectedStep;
    @wire(getRecord , {
        recordId : '$recordId',
        fields : ['Project__c.Status__c']
    }) details({ data }){
        if(data){
            status = data.fields.Status__c.value;
            
            if(status === 'New'){
                this.selectedStep = 'Step2';
            }
            else if(status === 'Planning'){
                this.selectedStep = 'Step3';
            }
            else if(status === 'Construction'){
                this.selectedStep = 'Step4';
            }
            else if(status === 'Deployment'){
                this.selectedStep = 'Step5';
            }
            else if(status === 'Signoff'){
                this.selectedStep = 'Step6';
            }
            else if(status === 'null'){
                    this.selectedStep = 'Step2';
            };
        }        
    };

}