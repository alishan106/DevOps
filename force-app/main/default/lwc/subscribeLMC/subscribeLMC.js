import { LightningElement } from 'lwc';
import {APPLICATION_SCOPE, createMessageContext, publish, subscribe} from 'lightning/messageService';
import MYMESSAGESERVICE from '@salesforce/messageChannel/mainMessageChannel__c';

export default class SubscribeLMC extends LightningElement {

    context = createMessageContext();
    submessage = '';

    connectedCallback(){
        this.subscribeLMC(); 
    }

    subscribeLMC(){
        subscribe(this.context, MYMESSAGESERVICE, (getMessage) => {
            this.handleOutputMessage(getMessage);
        }, {scope : APPLICATION_SCOPE})
    }

    handleOutputMessage(msg){
        this.submessage = msg.recordId;
    }
    handleSendMessage(){
        console.log('msg');
        let msg = this.template.querySelectorAll('.inpfrm')[0].value;
        console.log('msg',msg);
        const payLoad = {
            recordId : msg,
            recordData : this.inpMessage,
            recordSource : 'LMC'
        }
        publish(this.context, MYMESSAGESERVICE, payLoad)
        //this.submessage = '';
    }
}