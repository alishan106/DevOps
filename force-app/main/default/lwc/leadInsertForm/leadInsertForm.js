import { LightningElement, track, wire } from 'lwc';
import LEAD_NAME from '@salesforce/schema/Lead.LastName';
import LEAD_COMPANY from '@salesforce/schema/Lead.Company';
import LEAD_STATUS from '@salesforce/schema/Lead.Status';
import LEAD_EMAIL from '@salesforce/schema/Lead.Email';
import saveLead from '@salesforce/apex/leadAssigments.saveLead'
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubSub';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LeadInsertForm extends LightningElement {

    myFields = [LEAD_NAME, LEAD_STATUS, LEAD_COMPANY, LEAD_EMAIL];

    get statusOptions() {
        return [
            { label: 'Open - Not Contacted', value: 'Open - Not Contacted' },
            { label: 'Working - Contacted', value: 'Working - Contacted' },
            { label: 'Closed - Converted', value: 'Closed - Converted' },
            { label: 'Closed - Not Converted', value: 'Closed - Not Converted' }
        ];
    }
    //newForm = true;
    @wire(CurrentPageReference) pageRef;

    handleSubmit() {
        const arr = this.template.querySelectorAll('.inpFrm');
        console.log(arr);
        let leadObj = {
            LastName: arr[0].value,
            Status: arr[1].value,
            Company: arr[2].value,
            Email: arr[3].value,
        }
        if (arr[0].value && arr[1].value && arr[2].value) {
            saveLead({ lead: leadObj }).then(result => {
                console.log('Success');
                fireEvent(this.pageRef, 'inputChangeEvent', 'publish');
            }).catch(error => {
                this.showNotificaion('error', 'Something Went Wrong', 'Record Insertion Failed');
            })
            this.showNotificaion('success', 'Lead Inserted Successfully', 'Record Inserted');
            this.handleCancel();
        }
        else {
            this.showNotificaion('warning', 'Required Field Missing', 'Required !!');
        }
        //this.newForm = !this.newForm;
    }

    handleCancel() {

        this.template.querySelectorAll('.inpFrm').forEach(element => {
            element.value = '';
        });

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