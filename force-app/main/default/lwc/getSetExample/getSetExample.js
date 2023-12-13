import { LightningElement, wire, track } from 'lwc';
import getAccount from '@salesforce/apex/getSetController.getAccount';
import getContact from '@salesforce/apex/getSetController.getContact';
export default class GetSetExample extends LightningElement {

    @wire(getAccount) accounts;
    @wire(getContact) contacts;
    @track ObjAcccount = [];
    @track accountArr;
    @track contactArr;


    get accountGet() {
        return accounts.data;
    }
    set accountGet(value) {
        this.accountArr = value;
    }

    get contactGet() {
        return contacts.data;
    }
    set contactGet(value) {
        this.contactArr = value;
    }

    handleGetAccount() {
        this.accounts.data.forEach(element =>
            this.ObjAcccount.push({ Id: element.Id, Name: element.Name, Type:element.Type, Rating:element.Rating, Phone:element.Phone, Website:element.Website})
        );
        console.log('this.ObjAcccount' + JSON.stringify(this.ObjAcccount[0].Name))
    }
}