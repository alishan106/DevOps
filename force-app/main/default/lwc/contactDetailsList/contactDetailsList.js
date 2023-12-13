import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getContactList from '@salesforce/apex/ContactController.contactList';
export default class ContactDetailsList extends LightningElement {

    @track listOfContacts = [];

    @wire(getContactList) conList({ error, data }) {
        if (data) {
            this.listOfContacts = JSON.parse(JSON.stringify(data));
        }
        else {
            this.showNotificaion('error', '' + error, 'Data Not Fetched');
        }
    }

    showNotificaion(variant, message, title) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }
}