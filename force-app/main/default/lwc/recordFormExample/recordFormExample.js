import { LightningElement, api, track } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.LastName';
export default class RecordFormExample extends LightningElement {
    // Expose a field to make it available in the template
    nameField = NAME_FIELD;
    //@api recordId;
    @api objectApiName;
    @track tbl = [{
    "DateRange":"Date 1",
    "Depreciation":"Depreciation1",
    "Amortisation":"Amortisation1",
    "Donations":"Donations1",
    "RelatedPartyIncomeSplitSalary":"RelatedPartyIncomeSplitSalary1",
    "RelatedPartyIncomeSplitSuper":"RelatedPartyIncomeSplitSuper1",
    "LossonSaleofanAsset":"LossonSaleofanAsset1",
    "MotorVehicle":"MotorVehicle1",
    "UtilitiesTelecomms":"UtilitiesTelecomms1",
    "UtilitiesRent":"UtilitiesRent1",
    "UtilitiesMortgage":"UtilitiesMortgage1",
    "UtilitiesElectricity":"UtilitiesElectricity1",
    "FinesandPenalties":"FinesandPenalties1",
    "AdditionalExpensesAddBacks":"AdditionalExpensesAddBacks1",
    "TotalAddBacks":"TotalAddBacks1"    
},
{
    "DateRange":"Date 2",
    "Depreciation":"Depreciation2",
    "Amortisation":"Amortisation2",
    "Donations":"Donations2",
    "RelatedPartyIncomeSplitSalary":"RelatedPartyIncomeSplitSalary2",
    "RelatedPartyIncomeSplitSuper":"RelatedPartyIncomeSplitSuper2",
    "LossonSaleofanAsset":"LossonSaleofanAsset2",
    "MotorVehicle":"MotorVehicle2",
    "UtilitiesTelecomms":"UtilitiesTelecomms2",
    "UtilitiesRent":"UtilitiesRent2",
    "UtilitiesMortgage":"UtilitiesMortgage2",
    "UtilitiesElectricity":"UtilitiesElectricity2",
    "FinesandPenalties":"FinesandPenalties2",
    "AdditionalExpensesAddBacks":"AdditionalExpensesAddBacks2",
    "TotalAddBacks":"TotalAddBacks2"
},
{
    "DateRange":"Date 3",
    "Depreciation":"Depreciation3",
    "Amortisation":"Amortisation3",
    "Donations":"Donations3",
    "RelatedPartyIncomeSplitSalary":"RelatedPartyIncomeSplitSalary3",
    "RelatedPartyIncomeSplitSuper":"RelatedPartyIncomeSplitSuper3",
    "LossonSaleofanAsset":"LossonSaleofanAsset3",
    "MotorVehicle":"MotorVehicle3",
    "UtilitiesTelecomms":"UtilitiesTelecomms3",
    "UtilitiesRent":"UtilitiesRent3",
    "UtilitiesMortgage":"UtilitiesMortgage3",
    "UtilitiesElectricity":"UtilitiesElectricity3",
    "FinesandPenalties":"FinesandPenalties3",
    "AdditionalExpensesAddBacks":"AdditionalExpensesAddBacks3",
    "TotalAddBacks":"TotalAddBacks3"
}];

    motorLabel = 'Motor Vehicle\nAdjusted Add Back amount';
    utilitiesTeleLabel = 'Utilities - Telecomms\nAdjusted Add Back Amount';
    utilitiesRentLabel = 'Utilities - Rent\nAdjusted Add Back Amount';
    utilitiesMortgageLabel = 'Utilities - Mortgage\nAdjusted Add Back Amount';
    utilitiesElectricityLabel = 'Utilities - Electricity\nAdjusted Add Back Amount';
    percentageLabel = '% for\npersonal use';

    handleChange(event) {
        console.log('!@#$%^&*', event.target.id);
        console.log('TTTTTTTTT', JSON.stringify(event.target.value));
        if(JSON.stringify(event.target.value).includes("-")) {
            console.log('{}{}{}{}{}{}{}{}');
            let inpName = this.template.querySelector('.oppAmt'); 
        if(!inpName.value){ 
            inpName.setErrors('Complete this field.') 
            } 
        }
    }
}