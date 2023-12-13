import { LightningElement } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';

export default class CreateQuickAccount extends LightningElement {

    accountObject = ACCOUNT_OBJECT;
    myFields = [NAME_FIELD, WEBSITE_FIELD];

    handleAccountCreated() {
        let ev = new CustomEvent('callfromchildcreate');
        this.dispatchEvent(ev);
    }

}