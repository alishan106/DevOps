import { LightningElement, track, wire } from 'lwc';
import displayAccountRecord from '@salesforce/apex/AccountListControllerLWC.displayAccountRecord';
import updateAccount from '@salesforce/apex/AccountListControllerLWC.updateAccount';
import cloneAccount from '@salesforce/apex/AccountListControllerLWC.cloneAccount';
import {deleteRecord} from 'lightning/uiRecordApi';
import {refreshApex} from '@salesforce/apex';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class RecordsUsingSQL extends LightningElement {
    @wire(displayAccountRecord) getAccount;
    @track recordId;
    editData;
    viewData;
    @track mode = {
        list: true,
        edit: false,
        view: false,
        clone: false
    }
    handleAccountDelete(event) {
        this.mode.list = true;
        this.mode.edit = false;
        this.mode.view = false;
        this.mode.clone = false;
        this.recordId = event.target.value.Id;
        deleteRecord(this.recordId)
            .then(() => {
                const toastEvent = new ShowToastEvent({
                    title: 'Record Deleted',
                    message: 'Record deleted successfully',
                    variant: 'success',
                })
                this.dispatchEvent(toastEvent);

                return refreshApex(this.getAccount);

            })
            .catch(error => {
                window.console.log('Unable to delete record due to ' + error.body.message);
            });
    }

    handleAccountEdit(event) {
        this.editData = event.target.value;
        console.log('Edit', this.editData);
        this.mode.list = false;
        this.mode.edit = true;
        this.mode.view = false;
        this.mode.clone = false;
    }

    handleAccountView(event) {
        console.log('View', JSON.stringify(event.target.value));
        this.viewData = event.target.value;
        this.mode.list = false;
        this.mode.edit = false;
        this.mode.view = true;
        this.mode.clone = false;
    }

    handleAccountClone(event) {
        console.log('Clone', JSON.stringify(event.target.value));
        this.editData = event.target.value;
        this.mode.list = false;
        this.mode.edit = true;
        this.mode.view = false;
        this.mode.clone = true;
    }

    handleSave() {
        console.log('Save');
        let inputdetails = this.template.querySelectorAll(".inputData");

        let customerObject = {
            "Id": this.editData.Id,
            "Name": inputdetails[0].value,
            "Email_Gmail__c": inputdetails[1].value,
            "Phone": inputdetails[2].value
        }
        if (this.mode.clone) {
            console.log('This is clone');
            cloneAccount({
                    accObj: customerObject
                })
                .then(() => {
                    const toastEvent = new ShowToastEvent({
                        title: 'Clone Record',
                        message: 'Record Clone successfully',
                        variant: 'success',
                    })
                    this.dispatchEvent(toastEvent);
                    this.handleCancel();
                    return refreshApex(this.getAccount);

                })
                .catch(error => {
                    window.console.log('Unable to delete record due to ' + error.body.message);
                });
        } else {
            updateAccount({
                    accObj: customerObject
                })
                .then(() => {
                    const toastEvent = new ShowToastEvent({
                        title: 'Update Record',
                        message: 'Record Update successfully',
                        variant: 'success',
                    })
                    this.dispatchEvent(toastEvent);
                    this.handleCancel();
                    return refreshApex(this.getAccount);
                })
                .catch(error => {
                    window.console.log('Unable to delete record due to ' + error.body.message);
                });
        }

    }
    handleCancel() {
        this.mode.list = true;
        this.mode.edit = false;
        this.mode.view = false;
        this.mode.clone = false;
    }

}