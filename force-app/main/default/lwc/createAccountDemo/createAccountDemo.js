import { LightningElement, api } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';
import MAILIND_COUNTRY from '@salesforce/schema/Account.BillingAddress';
import MAILIND_CITY from '@salesforce/schema/Account.City__c';

export default class CreateAccountDemo extends LightningElement {

    @api recordId;
        
    accountObject = ACCOUNT_OBJECT;
    myFields = [NAME_FIELD, WEBSITE_FIELD];
    nameField = NAME_FIELD;
    websiteField = WEBSITE_FIELD;
    country = MAILIND_COUNTRY;
    city = MAILIND_CITY;
    accountId;


    handleAccountCreated(event){
        console.log('>>>'+JSON.stringify(event.detail));
        console.log('Account Created'+event.detail.id);
    }
}