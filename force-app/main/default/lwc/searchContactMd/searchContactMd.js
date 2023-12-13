import { LightningElement } from 'lwc';
import SearchingContact from '@salesforce/apex/Searching.SearchingContact';

export default class SearchContactMd extends LightningElement {
searchInput = '';
selectedPageSize = 5;
selectedContacts = [] ;
totalRecord = 0;
offSetValue = 0;
pageNumber =1;

get recordSize(){
    return  [
               {label : "5", value : 5},
               {label : "10", value : 10},
               {label : "15", value : 15},
               {label : "20", value : 20},
               {label : "100", value : 100}
            ];
    }
   
connectedCallback() {
   this.handleSearch();
}

handleSearch() {
    SearchingContact({ input : this.searchInput }).then(result => {
    
            this.selectedContacts = result;  
            this.totalRecord =  this.selectedContacts.length;
            this.offSetValue = 0;
            this.pageNumber = 1;
            } ).catch(error => {
                console.log(error);
            }); 
}  
handleInput(event){
    this.searchInput = event.target.value;  
}

changePageSize(s){
            this.selectedPageSize = parseInt(s.target.value); 
            this.offsetValue = 0;
            this.pageNumber = 1; 
        }
    

get contactList() { 
    console.log("Again")
    console.log(this.offsetValue);
        let  newContactList = [];
        let  length  = (this.offSetValue + this.selectedPageSize);
        let max = this.totalRecord;
    if( length < this.totalRecord){
           max = length;
    }

    for(let index = this.offSetValue; index < max; index++ ) {
        newContactList.push(this.selectedContacts[index]);  
         
    }  
    console.log(newContactList);   
    return newContactList;  
}

handleFirstButton() {
    this.offsetValue = 0;
    this.pageNumber = 1;
}

handlePreviousButton() {
    this.offsetValue = this.offsetValue - this.selectedPageSize;
    this.pageNumber--;
}

handleNextButton() {
    console.log('next')
    this.offsetValue = this.offsetValue + this.selectedPageSize;
    console.log(this.selectedPageSize);
    this.pageNumber++;
    console.log(this.offsetValue);
}

handleLastButton() {
    this.pageNumber = Math.ceil(parseFloat(this.totalRecords) / parseFloat(this.selectedPageSize));
    this.offsetValue = this.selectedPageSize * (this.pageNumber - 1);
}


}