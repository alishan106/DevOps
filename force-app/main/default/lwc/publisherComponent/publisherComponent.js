import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { fireEvent,registerListener,unregisterAllListeners } from 'c/pubSub';
import { CurrentPageReference } from 'lightning/navigation';
export default class PublisherComponent extends LightningElement {

    @wire (CurrentPageReference) pageRef;
    unitDetail;
    @track editedObj;
    name;
    qty;
    price;
    @track pubCall=true;
    
        productOptions = [
            
            { label: 'Mouse', value: 'Mouse' },
            { label: 'Keyboard', value: 'Keyboard' },
            { label: 'Monitor', value: 'Monitor' },
            { label: 'Speaker', value: 'Speaker' },
            { label: 'Pendrive', value: 'Pendrive' }
        ];

        productQty = [
            
            { label: '1', value: '1' },
            { label: '2', value: '2' },
            { label: '3', value: '3' },
            { label: '4', value: '4' },
            { label: '5', value: '5' }
        ];

        nameMethod(event) {
            this.name = event.target.value;
        }
    
        qtyMethod(event) {
            this.qty = event.target.value;
          }
        
        priceMethod(event){
            this.price = event.target.value;
        }

    sendDetailsclick(){ 
        console.log("$$$"+JSON.stringify(this.price));
        if(this.qty!=='' && this.name!=='' && this.price !=="" ){
            if(this.price !==0){
        this.unitDetail['name'] = this.name;
        this.unitDetail['qty'] = this.qty;
        this.unitDetail['price'] = this.price * this.qty;
        fireEvent(this.pageRef,"qtyMethod",this.unitDetail);
        this.name='';
        this.qty='';
        this.price='';
        const evt = new ShowToastEvent({
            title: 'Add Suceessfully',
            message: 'You Have Successfully Add Your Product In The Cart',
            variant: 'success',
        });
        this.dispatchEvent(evt);
        }else{
            this.unitDetail={};
            const toastEvent = new ShowToastEvent({
                title: 'All Fields Are Required',
                message: 'Record Not Inserted',
                variant: 'warning',
            })
            this.dispatchEvent(toastEvent);
        }   
    
    }
    else{
        this.unitDetail={};
        const toastEvent = new ShowToastEvent({
            title: 'All Fields Are Required',
            message: 'Record Not Inserted',
            variant: 'warning',
        })
        this.dispatchEvent(toastEvent);
    }
    }

    connectedCallback(){
        registerListener("editMode",this.editProducts,this);
    }
        

    editProducts(editObj){
        this.editedObj=editObj;
        this.pubCall=false;
        alert(this.editedObj);
        console.log('{{}}'+JSON.stringify(this.editedObj));
    }
    
    disconnectedCallback(){
        unregisterAllListeners(this);
    }
}