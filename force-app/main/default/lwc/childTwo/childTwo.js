import { LightningElement,api } from 'lwc';
export default class ChildTwo extends LightningElement {
@api
childMethod() {
     console.log('final call');
}
}