import { LightningElement,track,api } from 'lwc';
export default class BenCal_TotalAddBacks extends LightningElement {
    percentage1
    @api objectName;
    //@api recordId;
    @track fieldSet=[];
    totalAddBacks = 0.00;
    totalAddBacks2 = 0.00;
    connectedCallback() {
        getForm({ recordId: this.recordId, objectName: 'BenCalc_Entity__c', fieldSetName: 'Add_Backs' })
            .then(result => {
                console.log('Data:' + JSON.stringify(result));
                if (result) {
                    result.Fields.forEach(element => {
                        this.fieldSet[element.APIName] = element.APIName;
                          });
                          this.error = undefined;
                }
            }).catch(error => {
                console.log(error);
                this.error = error;
            });
    }

    handleChange(event) {
        var inp = this.template.querySelectorAll(".input");
        let actualAmount = 0;
        inp.forEach(function (element){
            console.log("Element value", parseFloat(element.value));
            if (parseInt(element.value >= 0)) {
                actualAmount = actualAmount + parseInt(element.value)
            }
        });
        this.totalAddBacks = parseFloat(actualAmount);
    }

    handleChange2(event) {
        let inp = this.template.querySelectorAll(".input2");
        let actualAmount2 = 0.00;
        inp.forEach(function (element) {
            console.log("Element value", parseFloat(element.value));
            if (parseFloat(element.value) > 0) {
                actualAmount2 = actualAmount2 + parseFloat(element.value)
            }
        });
        this.totalAddBacks2 = parseFloat(actualAmount2);
    }
}