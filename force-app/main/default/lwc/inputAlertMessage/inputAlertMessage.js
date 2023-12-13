import { LightningElement } from 'lwc';

export default class InputAlertMessage extends LightningElement {

    handleChange() {
        var inputCmp = this.template.querySelector(".inp");
        inputCmp.setCustomValidity("");
        inputCmp.reportValidity();
    }

    handleSubmit() {
        var inputCmp = this.template.querySelector(".inp");

        var value = inputCmp.value;
        if (value === "") {
            inputCmp.setCustomValidity(" ");
        } else {
            inputCmp.setCustomValidity("");
            alert(value);
        }
        inputCmp.reportValidity();
    }
}