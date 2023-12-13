import { LightningElement, track } from 'lwc';
import getFieldList from '@salesforce/apex/GetRecordsController.getFields';

export default class AddRemoveObjectFields extends LightningElement {

    selectedLabel = '';
    listName = '';
    isshowSpinner = true;
    @track objectLists = [];
    @track index = 1;
    @track fields = [];
    @track isStatus = false;
    results;
    objectFields = [];
    fieldData = [];
    showFilter = false;
    rows = [];
    showRows = false;
    objectFieldsLength;
    isDisabled = false;
    connectedCallback(event) {
        console.log('connected call back');
        getFieldList({ Obj: this.Object })
            .then(result => {

                this.objectFields = result;
                this.objectFieldsLength = result.length;
                console.log('this.objectFields', this.objectFields);
            });

        if (this.objectFields) {
            this.showRows = true;
            this.emptyRows();
        }
        setTimeout(() => {
            this.isshowSpinner = false;
        }, 1000)
        if (this.objectFields) {
            this.showFilter = true;
            // this.emptyRows();
        }

        // this.emptyRow();
    }

    emptyRows() {
        let tempObj = {};
        tempObj.Id = 1;
        tempObj.displayIndex = 1;
        tempObj.selectedField = '';
        tempObj.selectedValue = '';
        this.rows.push(tempObj);
    }

    addRow() {
        console.log('execute-->');    
        this.showRows = false;
        ++this.index;
        let i = this.index;
        let tempObj = {};
        tempObj.Id = i;
        tempObj.displayIndex = i;
        tempObj.selectedField = '';
        tempObj.selectedValue = '';
        this.rows.push(tempObj);
        console.log('Enter ', this.rows);
        this.showRows = true;
        if(this.objectFieldsLength == this.rows.length){
            this.isDisabled = true;
        }
    }

    handleRemoveRow(event) {
        console.log('rowslength', this.rows.length);
        let rowId = event.detail.recordId;
        this.showRows = false;
        let count = 1;
        console.log('recordId-->', rowId);
        let temRows = this.rows.filter(row => {
            if (row.displayIndex != rowId) {
                row.displayIndex = count;
                ++count;
                return row;
            }
        });
        this.showRows = true;
        console.log('chal')
        this.rows = temRows;
        console.log('this.index', this.index);
        if (this.rows.length) {
            this.index = this.index - 1;
        }
        console.log('tempRow', temRows)
        if (event.detail.removeRow.removeSelectedLabel && event.detail.removeRow.removeSelectedValue) {
            console.log('this.objectFields')
            this.objectFields.push({ label: event.detail.removeRow.removeSelectedLabel, value: event.detail.removeRow.removeSelectedValue })
            console.log('this', this.objectFields)
        }
        console.log('this.objectFields', this.objectFields)
        if (!this.rows.length) {
            this.emptyRows();
        }
        if(this.objectFieldsLength !== this.rows.length){
            this.isDisabled = false;
        }
    }

    handleSelectedValue(event) {
        console.log('Dispacte evt', JSON.parse(JSON.stringify(event.detail)));
        this.rows.forEach((ele) => {
            if (ele.Id == event.detail.Id) {
                ele.selectedField = event.detail.selectedField
                ele.selectedValue = event.detail.selectedValue
            }

        })
        let tempArr = this.objectFields.filter((ele) => {

            if (!(ele.value == event.detail.selectedValue)) {
                return ele;
            }
        })
        this.objectFields = tempArr;
    }
}








    // showSearchResults(event) {
    //     let searchValue = event.target.value;
    //     // this.fieldData = JSON.parse(JSON.stringify(this.fields));
    //     this.results = this.fields.filter(item => {
    //         console.log('Label = ', item.label.includes(searchValue))
    //         let itemLabel = item.label.toLowerCase();
    //         console.log(JSON.stringify(this.results));
    //         if (itemLabel.includes(searchValue.toLowerCase())) {
    //             return item;
    //         }
    //     });
    //     this.openDropDown();
    // }

    // handleFocusLostInputBox(event) {
    //     this.closeDropDown();
    //     if (this.template.querySelector('.hasSelected')) {
    //         console.log('this.template.querySelector', this.template.querySelector('.hasSelected'));
    //         this.template.querySelector('.hasSelected').classList.remove('hasSelected');
    //     }

    // }

    // openDropDown() {

    //     if (this.results.length < 1) {
    //         // this.closeDropDown();
    //         this.results = this.listName;
    //         return;
    //     }
    //     //console.log('openDropDownFired',this.openDropDownFired);     
    //     if (!this.openDropDownFired) {
    //         let node = this.template.querySelector('.slds-dropdown-trigger');
    //         if (node && node.className.indexOf('slds-is-open') === -1) {
    //             node.classList.add('slds-is-open');
    //         }
    //     }
    //     this.openDropDownFired = true;
    //     setTimeout(function (self) {
    //         self.openDropDownFired = false;
    //     }, 100, this);
    // }

    // handleObject(event) {
    //     console.log('handleObject')
    //     this.rows = [];
    //     this.isshowSpinner = true;
    //     this.isStatus = false;
    //     this.fields.splice(0, this.fields.length);
    //     this.fieldValues.splice(0, this.fieldValues.length);
    //     this.Object = event.target.value
    // getFields({ Obj: this.Object }) // To get ServiceResource Related User
    //     .then(result => {

    //         this.objectFields = result;
    //         console.log('this.objectFields', this.objectFields);
    //         result.forEach(element => {
    //             this.fields = [...this.fields, { value: element.value + '-' + element.type, label: element.label }]
    //         });
    //     });
    // setTimeout(() => {
    //     this.isshowSpinner = false;
    // }, 1000)
    // if (this.objectFields) {
    //     this.showFilter = true;
    //     this.emptyRows();
    // }

    // setTimeout(() => {
    //     this.template.querySelector('c-filter-criteria').getFields(this.objectFields);
    // }, 2000)

    // }
    // @track isPicList = false;
    // @track isInputfield = false;
    // @track fieldValues = [];
    // @track skillList = [];

    // @wire(skills) skill({ error, data }) { // Method to get all the skills.
    //     if (data) {
    //         for (let index = 0; index < data.length; index++) {
    //             this.skillList = [...this.skillList, { value: data[index].Id, label: data[index].Skill_Name__c }]
    //         }
    //     }
    //     else {
    //         console.log(error);
    //     }
    // }





    // handleField(event) {
    //     console.log('execute');
    //     this.isStatus = true;
    //     if (event.target.value.split("-", 2)[1] === 'PICKLIST') {
    //         getPicklistValue({ obj: this.Object, picVal: event.target.value.split("-", 2)[0] })
    //             .then(results => {
    //                 this.isPicList = true;
    //                 results.forEach(element => {
    //                     this.fieldValues = [...this.fieldValues, { value: element, label: element }]
    //                 });
    //             });
    //     } else {
    //         this.isInputfield = true;
    //     }
    // }

    // handleFieldValues(event) {
    //     console.log('VAlues-- ' + event.target.value);

    // }

    // handleSkill(event) {
    //     console.log('skills-- ' + event.target.value);
    // }


    // Object = '';
    // @track emptyRow = [];
    // @track keyIndex = 0;
    // @track row = false;
    // @track fliterFields = [];
    // @track fields = [];
    // @track field = [];
    // @track objectFields = [];
    // selectedFields = [];
    // rows = [];
    // connectedCallback(event){
    //     getFieldList({ Obj: this.Object })
    //         .then(result => {

    //             this.objectFields = result;
    //             console.log('this.objectFields', this.objectFields);
    //             result.forEach(element => {
    //                 this.fields = [...this.fields, { value: element.value , label: element.label }]
    //             });
    //         });

    //         this.emptyRow();
    // }

    // emptyRow(){
    //     let tempObj = {};
    //     tempObj.displayIndex = 1;
    //     tempObj.rowId = 1;
    //     tempObj.selectedValue = '';
    //     this.rows.push(tempObj);
    // }

    // handleField(event){

    //     console.log(event.target.value);
    //     this.selectedFields.push(event.target.value);
    //     // console.log('this.selectedFields', this.selectedFields)
    //     // this.field.forEach((ele) =>{
    //     //     //console.log(ele.value);
    //     //     if(!this.selectedFields.includes(ele.value)){
    //     //         console.log('inside if')
    //     //         return ele;
    //     //     }
    //     // })
    //     // console.log('tempArr', JSON.parse(JSON.stringify(this.field)));
    //     // let tempfield = {};
    //     // this.fliterFields = [...this.fliterFields, { value: event.target.value , label: event.target.value }]
    //     // console.log(JSON.stringify(fliterFields));

    //     // const targetValue = event.target.value
    //     // filterdata(targetValue);

    // }

    // removeRows(event){

    //     console.log('Remove Row');
    //     if(this.emptyRow.length>=1){
    //         this.emptyRow.splice(event.target.accessKey,1);
    //         this.keyIndex-1;
    //         console.log('Remove Row !!');
    //     }

    // }




    // addRow() {
    //     this.row = true;
    //     this.field = [];
    //     console.log('execute-->');
    //     this.keyIndex+1;
    //     let tempObj = {};
    //     tempObj.displayIndex = this.keyIndex + 1;
    //     tempObj.selectedValue = '';
    //     tempObj.rowId = this.keyIndex + 1;
    //     this.rows.push(tempObj);
    //     // this.emptyRow.push(tempObj);
    //     // this.fields.forEach(element => {
    //     //     if(!this.selectedFields.includes(element.value)){
    //     //         this.field = [...this.field, { value: element.value , label: element.label }]
    //     //     }

    //     // });
    //     // console.log('Enter ', this.field);
    // }

    // filterdata(event){

    //     this.field = this.fields.filter(item => item != event.target.value)
    // }
    // }