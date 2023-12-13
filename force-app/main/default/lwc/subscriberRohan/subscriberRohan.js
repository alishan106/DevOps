import { LightningElement, track, wire } from 'lwc';
import {fireEvent, registerListener, unregisterAllListeners} from 'c/pubSub'
import {CurrentPageReference} from 'lightning/navigation'

export default class SubscriberRohan extends LightningElement {
    value=[];
    @track description=[];
    @track grandTotal = 0;
    @track showAmount=false;
    @track isChecked=false;
    @wire(CurrentPageReference) pageRef;
    connectedCallback(){
        registerListener("showMessage",this.showMessage,this);
        registerListener("showUpdatedList",this.showUpdatedList,this);
    }

    showMessage(message){
        this.grandTotal +=message.quantity*message.amount;
        this.description.push(message);
        if(this.description.length>0){
            this.showAmount=true;
        }
    }

    showUpdatedList(updatedList){
        this.description=[];
        this.grandTotal=0;
        this.description=updatedList;
        for(let i=0;i<this.description.length;i++){
            this.grandTotal+=parseInt(this.description[i].quantity)*parseInt(this.description[i].amount);
        }
        this.isChecked=false;
    }

    handleCheckboxChange(event){
        this.isChecked = event.target.checked;
        if(this.isChecked ==  true){
            const data = this.description;
            fireEvent(this.pageRef,"showList",data);
        }
        else if(this.isChecked == false){
            const data = [];
            fireEvent(this.pageRef,"showList",data);
        }
    }

    disconnectedCallback(){
        unregisterAllListeners(this);
    }
}