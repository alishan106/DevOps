import { LightningElement, wire, track, api } from 'lwc';
import getFieldList from '@salesforce/apex/InsertRecordsController.getFields';

export default class RecordInsertAssignmentParent extends LightningElement {
    @api newObj = [];
    @track fieldsResult = '';
    @api objectApiName = '';
hanldeProgressValueChange(event) {
    this.fieldsResult = '';
    this.objectApiName = event.detail;
    console.log('r222');
    console.log(this.objectApiName);
    getFieldList({ selectedObject: this.objectApiName})
    .then(result => {
        console.log(JSON.stringify(result));
        
        for(var i=0; i<result.length; i++) {   

            this.fieldsResult = result;             
        }
        console.log('@@@@@'+JSON.stringify(this.fieldsResult));
        this.objError = undefined;
    })
    .catch(error => {
        this.objError = error;
        this.fieldsResult = undefined;
    })
}

ondragHandle(event){
    event.dataTransfer.setData("fieldApiName", event.currentTarget.dataset.id);
    event.dataTransfer.setData("fieldType", event.currentTarget.dataset.value);
}

ondropHandle(event){
    console.log(event.dataTransfer.getData("fieldApiName"));
    console.log(event.dataTransfer.getData("fieldType"));
    this.template.querySelector("c-assignment-input-box").handleValueChange();
    
    newObj.push({label : event.dataTransfer.getData("fieldType"), value: event.dataTransfer.getData("fieldApiName")});
}
alloDrop(event){
    event.preventDefault();
}

handleRemove(){
    alert('Field Can not be remove !!');
}
}