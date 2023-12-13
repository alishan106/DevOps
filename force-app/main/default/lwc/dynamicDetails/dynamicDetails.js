import { LightningElement,  api, wire, track } from 'lwc';
import { getListUi } from 'lightning/uiListApi'; 



export default class DynamicDetails extends LightningElement {
    
    @api objectApiName;
    @track listId = ' ';
    objectListData;

    @wire(getListUi, { objectApiName: '$objectApiName' })
    ObjectInfo({error,data}){
        if(data){ 
            console.log('@@@@rohansss'+JSON.stringify(data.lists[0].id));
            this.listId = data.lists[0].id;
        }else{
            console.log('####'+error)
        }
    };


    @wire(getListUi, { listViewId: '$listId' })
    ObjectInfolist({error,data}){
        if(data){ 
            this.objectListData = data.records.records;
            console.log('@@@@rohansrajssharma'+JSON.stringify(data.records.records));
           // this.track = data.lists[0].id;
           
        }else{
            console.log('####'+error)
        }
    };
}