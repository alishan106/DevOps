import { LightningElement,track, wire} from 'lwc';
import allLeads from '@salesforce/apex/leadAssigments.getAllLeadsImp';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubSub';

export default class AllLeadList extends LightningElement {

    @wire(CurrentPageReference) pageRef;
    @track allLeadList = [];
    // @wire (allLeads) allLeadList({data, error}){
    // if(data){        
    //     console.log(data);
    //     this.allLeadList = data;
    // }
    // else{
    //     console.log(error);
    // }
    // }

connectedCallback() {
    this.handleEvent();
    registerListener('inputChangeEvent', this.handleEvent, this);
}

handleEvent() {
    console.log('pub call');
        allLeads()
        .then(result => {
            this.allLeadList = result;
            console.log('this.allLeadList',this.allLeadList);
        })
        .catch(error => {
            this.error = error;
            console.log('this.error ',this.error );
        });
    
}

disconnectedCallback() {
    unregisterAllListeners(this);
}

}