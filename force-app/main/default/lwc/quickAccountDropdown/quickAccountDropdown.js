import { LightningElement, api} from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
export default class QuickAccountDropdown extends LightningElement {
    
    @api recordId;
    @api objectApiName;

    value = '';
    dropdown = true;
    editAccount = false;
    crateAccount = false;
    get options() {
        return [
            { label: 'Create Account', value: 'create' },
            { label: 'Edit Account', value: 'edit' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
        this.dropdown = false;
        if (event.detail.value === 'edit') {
            this.editAccount = true;
        }
        if (event.detail.value === 'create') {
            this.crateAccount = true;
        }
    }
    
    callFromChild(){
        console.log('close');
        this.dispatchEvent(new CloseActionScreenEvent());
    }

}