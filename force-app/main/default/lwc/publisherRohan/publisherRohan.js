import { LightningElement, track, wire } from 'lwc';
import {fireEvent, registerListener, unregisterAllListeners} from 'c/pubSub'
import {CurrentPageReference} from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class PublisherRohan extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    product;
    quantity;
    amount;
    serialNumber = 0;
    
    @track dataList=[];
    @track showListValue=false;
    @track inputValue=true;
    @wire(CurrentPageReference) pageRef;
    connectedCallback(){
        registerListener("showList",this.showDataList,this);
    }

    get products(){
        return [
            {label:'Keyboard',value:'Keyboard'},
            {label:'Laptop',value:'Laptop'},
            {label:'Desktop',value:'Desktop'},
            {label:'Mouse',value:'Mouse'},
        ];
    }

    get quantities(){
        return[
            {label:'1',value:'1'},
            {label:'2',value:'2'},
            {label:'3',value:'3'},
            {label:'4',value:'4'},
            {label:'5',value:'5'},
        ];
    }

    handleProductChange(event){
        this.product = event.target.value;
    }
    handleQuantityChange(event){
        if(event.target.name === 'Quantity'){
            this.quantity = event.target.value;
        }
        if(event.target.name === 'changeQuantity'){
            var sNumber = event.target.dataset.id;
            this.dataList[sNumber-1].quantity = event.target.value;
        }
    }
    handleAmountChange(event){
        if(event.target.name==="number"){
            this.amount = event.target.value;
        }
        if(event.target.name === "changeNumber"){
            var sNumber = event.target.dataset.id;
            this.dataList[sNumber-1].amount = event.target.value;
        }
        
    }

    handleImage(event){
        var sNumber = event.target.dataset.id;
        this.dataList.splice(sNumber-1,1);
        this.reindex(sNumber-1);
        this.serialNumber -= 1;
    }

    reindex(index){
        for(let i=index;i<this.dataList.length;i++){
            this.dataList[i].serialNumber -= 1;
        }
    }

    handleClick(){
        if(this.product === undefined || this.quantity === undefined || this.amount === undefined ||
            this.product == '' || this.quantity == '' || this.amount == ''){
            const evt = new ShowToastEvent({
                title: 'Missing Field',
                message: 'Please Fill All The Data',
                variant: 'error',
            });
            this.dispatchEvent(evt);
        }
        else{
            this.serialNumber += 1;
            var decription = {
               serialNumber : this.serialNumber,
                product : this.product,
                quantity : this.quantity,
                amount : this.amount
            }
            fireEvent(this.pageRef,"showMessage",decription);
            this.product='';
            this.quantity='';
            this.amount='';
            const evt = new ShowToastEvent({
                title: 'Add Suceessfully',
                message: 'You Have Successfully Add Your Product In The Cart',
                variant: 'success',
            });
            this.dispatchEvent(evt);
        }
    }

    handleSaveUpdatedList(){
        this.inputValue=true;
        const dataL = this.dataList;
        fireEvent(this.pageRef,"showUpdatedList",dataL);
        this.showListValue=false;
        const evt = new ShowToastEvent({
            title: 'Update Suceessfully',
            message: 'You Have Successfully Updated Your Product In The Card',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }

    

    showDataList(listValue){
        this.dataList = [];
        this.showListValue = false;
        this.dataList = JSON.parse(JSON.stringify(listValue));
        if(this.dataList.length>0){
            this.showListValue=true;
            this.inputValue = false;
        }
    }
    disconnectedCallback(){
        unregisterAllListeners(this);
    }
}