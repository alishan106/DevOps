import { LightningElement, wire, track } from 'lwc';
import getContact from '@salesforce/apex/getSetController.getContact';
import getAccount from '@salesforce/apex/getSetController.getAccount';
import getOpportunity from '@salesforce/apex/getSetController.getOpportunity';
export default class LightningTabTwo extends LightningElement {
    @track conRecords
    @track accRecords
    @track oppRecords

    @wire(getContact) contactsRec({ error, data }) {
        if (data) {
            console.log('data',data)
            this.conRecords = data;
        } else if (error) {
            console.log('error',error)
            this.error = error;
        }
    }

    @wire(getAccount) accountRec({ error, data }) {
        if (data) {
            console.log('data',data)
            this.accRecords = data;
        } else if (error) {
            console.log('error',error)
            this.error = error;
        }
    }

    @wire(getOpportunity) opportunityRec({ error, data }) {
        if (data) {
            console.log('data',data)
            this.oppRecords = data;
        } else if (error) {
            console.log('error',error)
            this.error = error;
        }
    }


    activeTab = '1';
    test = ["Test1","Test2"]


    get bDisableBackBtn(){
        return Number(this.activeTab) == 1 ? true : false;
    }

    get bDisableNextBtn(){
        return Number(this.activeTab) == 4 ? true : false;
    }

    // JS functions start 
    handleActive(event) {
     this.activeTab = event.target.value;
    }
    
    goBack(){
        let activeTabValue = Number(this.activeTab) - 1;
        this.activeTab = activeTabValue.toString();
      }

    goNext(){
      let activeTabValue = Number(this.activeTab) + 1;
      this.activeTab = activeTabValue.toString();
    }

}