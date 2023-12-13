import { LightningElement } from 'lwc';
export default class ParentTest extends LightningElement {
    childTrue = false;
    message = 'Hello JAAN I\'m talking from Parent';
    childMessage = 'No message from child';
    parentButton = true;
    viewChild(){
        this.childTrue = true;
        this.parentButton = false;
    }
    updateMessage(event) {
        this.childMessage = event.detail.message;
    }

}