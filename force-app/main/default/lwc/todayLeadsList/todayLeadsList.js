import { LightningElement, track, wire } from 'lwc';
import todayLeadsImp from '@salesforce/apex/leadAssigments.getTodayLeads';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubSub';
export default class TodayLeadsList extends LightningElement {

    @wire(CurrentPageReference) pageRef;
    @track leadList = [];

    connectedCallback() {
        registerListener('inputChangeEvent', this.handleEvent, this);
        this.handleEvent();
    }

    handleEvent() {
        console.log('pub call');
            todayLeadsImp()
            .then(result => {
                this.leadList = result;
                console.log('this.leadList',this.leadList);
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