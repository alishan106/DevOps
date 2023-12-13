import { LightningElement, api, wire, track } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class GetRecordWithoutApex extends LightningElement {
@api recordId;
@track field= [ACCOUNT_NAME_FIELD, ACCOUNT_PHONE_FIELD];
    @wire(getRecord, { recordId: '$recordId', fields: field})
    account;

    get name() {
        return this.account.data.fields.Name.value;
    }
    get phone() {
        return this.account.data.fields.phone.value;
    }
}