import { LightningElement, track, wire} from 'lwc';
import insertContacts from '@salesforce/apex/CommunityContactsClass.insertContacts';
import findAccountId from '@salesforce/apex/CommunityContactsClass.findAccountId';
import OBJECT_NAME from '@salesforce/schema/Contact';
import USER_ID from '@salesforce/user/Id';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import COUNTRY_NAME from '@salesforce/schema/Contact.MailingCountryCode';
import STATE_NAME from '@salesforce/schema/Contact.MailingStateCode';

export default class CommunityContacts extends LightningElement {

  userid = USER_ID;
  @track accId;
  @track stateOptions;
  @track countryOption;
  @track contact = { FirstName : '', LastName : '', Email : '', Phone : '', MailingPostalCode : '',
                   MailingStreet : '', MailingCity : '', MailingCountryCode : '', MailingStateCode : ''};


  @wire(getObjectInfo, { objectApiName: OBJECT_NAME })
  accountInfo;  

  @wire(getPicklistValues, { recordTypeId: '$accountInfo.data.defaultRecordTypeId', fieldApiName: STATE_NAME })
  stateFieldInfo({ data, error }) {
      if (data) this.countryFieldData = data;
  }

  @wire(getPicklistValues, { recordTypeId: '$accountInfo.data.defaultRecordTypeId', fieldApiName: COUNTRY_NAME })
  countryFieldInfo({ data, error }) {
      if (data) this.countryOption = data.values;
  }
  // handleCountryChange(event) {
    
  //   this.MailingCountryCode = event.target.value;
  //   let key = this.countryFieldData.controllerValues[event.target.value];
  //   this.stateOptions = this.countryFieldData.values.filter(opt => opt.validFor.includes(key));
  //   console.log('@@',this.MailingCountryCode);
    
  // }
  handleInputChange(event){
  const name = event.target.name;
        if (name === 'fName') {
          this.contact.FirstName = event.target.value;
        }else if(name === 'lName'){
          this.contact.LastName = event.target.value;
        }else if(name === 'Email'){
          this.contact.Email = event.target.value;
        }else if(name === 'Phone'){
          this.contact.Phone = event.target.value;
        }else if(name === 'mStreet'){
          this.contact.MailingStreet = event.target.value;
        }else if(name === 'mCity'){
          this.contact.MailingCity = event.target.value;
        }else if(name === 'mCountry'){
          let key = this.countryFieldData.controllerValues[event.target.value];
          this.stateOptions = this.countryFieldData.values.filter(opt => opt.validFor.includes(key));
          this.contact.MailingCountryCode = event.target.value;
          console.log('@@@@@',this.stateOptions);
        }else if(name === 'mState'){          
          this.contact.MailingStateCode = event.target.value;
        }else if(name === 'mCode'){
          this.contact.MailingPostalCode = event.target.value;
        }
      }

  // handleStateChange(event){
  //   this.MailingStateCode = event.target.value;
  //   console.log('!!',this.MailingStateCode);
  // }
  
  // connectedCallback(){
  //   findAccountId({userIdVar : this.userid})
  //   .then(Result => {
  //     this.accId = Result;
  //   });
  //   console.log(this.accId);

  // }

  // handleFirstName(event) {
  //     this.FirstName = event.target.value;
  // }

  // handleLastName(event) {
  //     this.LastName = event.target.value;
  // }

  // handleEmail(event) {
  //     this.Email = event.target.value;
  // }
  // handlePhone(event) {
  //     this.Phone = event.target.value;
  // }

  // handlEMailingStreet(event) {
  //     this.MailingStreet = event.target.value;
  // }

  // handlEMailingCity(event) {
  //     this.MailingCity = event.target.value;
  // }
  // handlEMailingPostalCode(event) {
  //     this.MailingPostalCode = event.target.value;
  // }

  handleCreateContact() {

    console.log(JSON.stringify(this.contact));
    
    console.log('AccountId ::',this.accId);
      this.template.querySelectorAll('lightning-input','lightning-combobox').forEach(element => {
          element.reportValidity();          
      });
      this.template.querySelectorAll('lightning-combobox').forEach(element => {
        element.reportValidity();
      });
      if(this.Contact.FirstName === '' || this.contact.LastName === '' || this.contact.Email === '' ||
      this.contact.Phone == '' || this.contact.MailingStreet == '' || this.contact.MailingCity == ''
      || this.contact.MailingPostalCode == '' || this.contact.MailingCountryCode == '' ){
        const evt = new ShowToastEvent({
            title: 'Missing Field',
            message: 'Please Fill All The Data',
            variant: 'error',
        });
        this.dispatchEvent(evt);
    }
    else{

    findAccountId({userIdVar : this.userid})
    .then(Result => {
      this.accId = Result;
    });
    console.log(this.accId);      

      let fields = {
          'FirstName': this.contact.FirstName,
          'LastName': this.contact.LastName,
          //'AccountId': this.accId,
          'Email': this.contact.Email,
          'Phone': this.contact.Phone,
          //'OwnerId' : this.userid,
          'MailingCity': this.contact.MailingCity,
          'MailingStreet': this.contact.MailingStreet,
          'MailingPostalCode': this.contact.MailingPostalCode,
          'MailingCountryCode': this.contact.MailingCountryCode,
          'MailingStateCode': this.contact.MailingStateCode
      }

      insertContacts({
              contactObject: fields
          })
          .then(() => {
              const toastEvent = new ShowToastEvent({
                  title: 'Record Insered',
                  message: 'Record Insered Successfully',
                  variant: 'success',
              })
              this.dispatchEvent(toastEvent);
              this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element => {
                  element.value = null;
              });
              this.template.querySelectorAll('lightning-combobox[data-id="reset"]').forEach(element => {
                element.value = null;
            });
          })
          .catch(error => {
              const toastEventError = new ShowToastEvent({
                  title: 'Record Not Insered',
                  message: 'Something Went Wrong !!',
                  variant: 'error',
              })
              this.dispatchEvent(toastEventError);
          });
        }
        console.log('AccountId',this.accId);
  }

}