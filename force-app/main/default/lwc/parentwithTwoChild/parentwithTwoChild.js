import { LightningElement } from 'lwc';
export default class ParentwithTwoChild extends LightningElement {

    callFromChild(){
        console.log('child 1 click');
        this.template.querySelector('c-child-two').childMethod();
    }

}