import { LightningElement, wire, track } from 'lwc';
import getAccount from '@salesforce/apex/AssismentTaskController.fetchAccount';
import getContact from '@salesforce/apex/AssismentTaskController.getContacts';
import getTask from '@salesforce/apex/AssismentTaskController.fetchTask';
const columns = [
    { label: 'Subject', fieldName: 'Subject' },
    { label: 'CreatedBy', fieldName: 'CreatedBy.Name' },
    { label: 'Due Date', fieldName: 'ActivityDate' },
    { label: 'Status', fieldName: 'Status' }
];
export default class AssismentTask extends LightningElement {
    @track optionSetAccount;
    @track optionSetContact;
    @track tasks;
    @wire(getAccount)
    accountList({ error, data }) {
        if (data) {
            this.optionSetAccount = data.map(plValue => {
                return {
                    label: plValue.Name,
                    value: plValue.Id
                }
            });
        } else if (error) {
            this.error = error;
            this.account = undefined;
        }
    }
    handleChangeAccount(event) {
        console.log(event.target.value);
        getContact({ accountId: event.target.value })
            .then(result => {
                console.log(JSON.stringify(this.contacts));
                if (result) {
                    this.optionSetContact = result.map(plValue => {
                        return {
                            label: plValue.LastName,
                            value: plValue.Id
                        }

                    });
                }
            })
            .catch(error => {
                this.error = error;
            });
    }

    handleChangeContact(event) {
        this.contactId = event.target.value;
    }

    handleClick() {
        if (this.contactId) {
            getTask({ contactId: this.contactId })
                .then(result => {
                    if (result) {
                        this.tasks = result.map(plValue => {
                            return {
                                "Subject": plValue.Subject,
                                "CreayedBy": plValue.CreatedBy.Name,
                                "ActivityDate": plValue.ActivityDate,
                                "Status": plValue.Status,
                            }

                        });
                    }
                })
                .catch(error => {
                    this.error = error;
                });
        }
    }
}