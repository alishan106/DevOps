import { LightningElement,api } from 'lwc';

import { CloseActionScreenEvent } from 'lightning/actions';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';
export default class EditQuickAccount extends LightningElement {

    // Flexipage provides recordId and objectApiName
    @api accRecordId;
    @api accObjectApiName;


    handleAccountUpdated(){
        let ev = new CustomEvent('callfromchildedit');
        this.dispatchEvent(ev);
    }
}