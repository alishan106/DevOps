import { LightningElement } from 'lwc';
import {APPLICATION_SCOPE, createMessageContext, publish, subscribe} from 'lightning/messageService';
import MYMESSAGESERVICE from '@salesforce/messageChannel/mainMessageChannel__c';

export default class LMC_Publish extends LightningElement {
    
    context = createMessageContext();
    message = '';

    connectedCallback(){
        this.subscribeLMC();
    }

    subscribeLMC(){
        subscribe(this.context, MYMESSAGESERVICE, (getMessage) => {
            this.handleOutputMessage(getMessage);
        }, {scope : APPLICATION_SCOPE})
    }

    handleOutputMessage(msg){
        this.message = msg.recordId;
    }

    handleSendMessage(){
        const payLoad = {
            recordId : '',
            recordData : this.inpMessage,
            recordSource : 'LMC'
        }
        publish(this.context, MYMESSAGESERVICE, payLoad);
    }

}