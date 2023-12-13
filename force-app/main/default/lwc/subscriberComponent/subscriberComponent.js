import { LightningElement,wire,track } from 'lwc';
import { registerListener,unregisterAllListeners,fireEvent } from 'c/pubSub';
import { CurrentPageReference } from 'lightning/navigation';
export default class SubscriberComponent extends LightningElement {

    @wire (CurrentPageReference) pageRef;
    @track unitDetailSub=[];
    @track grandTotal=0;

    connectedCallback(){
            registerListener("qtyMethod",this.addProducts,this);
        }
        addProducts(unitDetail){
            this.unitDetailSub.push(unitDetail);
            this.grandTotal=this.grandTotal+unitDetail.price;
            console.log('!!!'+JSON.stringify(this.unitDetailSub));
        }
        
    editMode(){
        console.log('!@#$%111');
            fireEvent(this.pageRef,"editMode",this.unitDetailSub);
        }

    disconnectedCallback(){
        unregisterAllListeners(this);
        
    }
}