import { LightningElement,api } from 'lwc';
export default class ChildTest extends LightningElement {
    childButton = true
    @api parentMessage;
    
    hideChild(){
    this.childButton = false;
    }

    sendMessagetoParent() {
        this.dispatchEvent(new CustomEvent('callparent', {
            detail: {
                message: 'Hello Jaanu i\m talking from Child'
            }
        }));
    }
}