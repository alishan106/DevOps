import { LightningElement, track } from 'lwc';
//import insertOpportunity from '@salesforce/apex/thirdClassController.insertOpportunity';
export default class ThirdAssignmennt extends LightningElement {
    @track num = [];
    keyIndex = 0;
    @track oppList = [];
    
    handleNum(event) {
        this.num = [];
        let index = 0;
        //console.log('num',this.num);
        for (index = 0; index < event.target.value; index++) {
            var oppObject = [{
                Id: index,
                Name: '',
                CloseDate: '',
                StageName: ''
            }];
            this.num = this.num.concat(oppObject);            
        }
        this.keyIndex = index;
        console.log('this.num => ', (this.num));
    }
    addRow() {
        ++this.keyIndex;
        var oppObject = [{ Id: this.keyIndex, Name: '', CloseDate: '', StageName: ''}];
        this.num.push(oppObject);

        // let oppObject = {
        //     Id: this.num.length,
        //     Name: '',
        //     CloseDate: '',
        //     StageName: ''
        // };
        //this.num.push(oppObject);
        console.log('Add Row => ', (this.num));

    }
    removeRow(event) {

        console.log(parseInt(event.currentTarget.dataset.id));

            this.num = this.num.filter(function (element) {
                return parseInt(element.Id) !== parseInt(event.currentTarget.dataset.id);
            });
        

        // let key = event.currentTarget.dataset.id;
        // let numTemp = this.num;
        // console.log('keytype', typeof (key));
        // //console.log('key1',this.num.findIndex(ele => ele.Id === parseInt(key)));
        // let idx = numTemp.findIndex(ele => ele.Id === parseInt(key));
        // console.log('num', this.num);
        // numTemp.splice(idx, 1);
        // console.log('numTemp', numTemp);
        // this.num = [];
        // this.num = [...numTemp];
        // console.log('numafter', this.num);

    }
    handleSave() {
        // console.log('handleSave called  :-  ', this.template.querySelectorAll('.opp'))

        // console.log('this.isInputValid()  :-  ', this.isInputValid());
        // if (this.isInputValid()) {
        //     console.log('valid');
        // }
        console.log('*****this.num => ', JSON.stringify(this.num));
        // for (let i = 0; i < this.num.length; i++) {
        //     delete this.num[i].Id;

        // };
        // let flag = true;
        // this.num.forEach(element => {
        //     console.log('element',element.Name);
        //     if(!element.Name || !element.CloseDate  || !element.StageName){
        //         flag =false;
        //     }

        //      });
        // if(flag){
        //     console.log('Flag***',flag);
        //     insertOpportunity({ listOpportunity: this.num })
        //     .then(result => {
        //         this.resultsum = result;
        //         console.log('hi::' + this.resultsum);

        //     })
        //     .catch(error => {
        //         this.resultsum = undefined;
        //         console.log('error : ', JSON.stringify(error));
        //     }); 
        // }
        // else{
        //     console.log('Flag***',flag);
        //      alert("Please fill all the fields");
        // }

        // console.log('this.top => ', JSON.stringify(this.num));

    }

    isInputValid() {
        try {
            let isValid = true;
            let inputFields = this.template.querySelectorAll('.opp');
            inputFields.forEach(inputField => {
                if (!inputField.checkValidity()) {
                    inputField.reportValidity();
                    isValid = false;
                }
                // this.contact[inputField.name] = inputField.value;
            });
            return isValid;
        } catch (error) {
            console.log('error  :-  ', error);
        }

    }
    
    handlNameChange(event) {
        console.log('Name', event.currentTarget.dataset.id);
        let i = parseInt(event.currentTarget.dataset.id);
        this.num[i].Name = event.target.value;
        console.log(this.num);

    }
    handleCloseDateChange(event) {
        console.log('CloseDate', event.currentTarget.dataset.id);
        let i = parseInt(event.currentTarget.dataset.id);
        this.num[i].CloseDate = event.target.value;
    }
    handleSatgeName(event) {
        console.log('StageName', event.currentTarget.dataset.id);
        let i = parseInt(event.currentTarget.dataset.id);
        this.num[i].StageName = event.target.value;
    }
    get options() {
        return [
            { label: 'Not Started', value: 'Not Started' },
            { label: 'In Progress', value: 'In Progresss' },
            { label: 'Completed', value: 'Completed' },
            { label: 'Waiting on someone else', value: 'Waiting on someone else' },
            { label: 'Deferred', value: 'Deferred' }
        ];
    }

}