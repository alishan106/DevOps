import { LightningElement } from 'lwc';
import saveContact from '@salesforce/apex/ContactController.saveContacts';
export default class LSDCreateRecord extends LightningElement {
lname;
   
   
   
   
    handleFilesChange(event) {
        console.log(event.target.value);
        this.lname = event.traget.value;
    }

    handleSave() {
        let obj = [];
        for (let i = 0; i > 2; i++) {
            const fields = {};
            fields[Contact.LastNAme.fieldApiName] = this.lname;
            obj.push(fields);
        }
        saveContacts({conList:obj})
    }

}