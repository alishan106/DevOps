import { LightningElement,wire,track } from 'lwc';
import getContact from '@salesforce/apex/getSetController.getContact';
export default class LightningTabPractice extends LightningElement {
  @track conRecords


  @wire(getContact) contactsRec ({ error, data }) {
       if (data) {
           this.conRecords = data;
       } else if (error) {
           this.error = error;
       }
   }


   // Js Properties start
   //@wire(getAccount) accounts;
    // activeTab = '1';
    // test = ["Test1","Test2"]


    // get bDisableBackBtn(){
    //     return Number(this.activeTab) == 1 ? true : false;
    // }

    // get bDisableNextBtn(){
    //     return Number(this.activeTab) == 4 ? true : false;
    // }

    // // JS functions start 
    // handleActive(event) {
    //  this.activeTab = event.target.value;
    // }
    
    // goBack(){
    //     let activeTabValue = Number(this.activeTab) - 1;
    //     this.activeTab = activeTabValue.toString();
    //   }

    // goNext(){
    //   let activeTabValue = Number(this.activeTab) + 1;
    //   this.activeTab = activeTabValue.toString();
    // }
    // JS functions end    
}