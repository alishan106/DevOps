import { LightningElement } from 'lwc';
import searchContacts from '@salesforce/apex/LightningSearchContactController.searchContacts';

export default class SearchContacts extends LightningElement {   
    
    recordSize = 5;
    searchInput = '';
    totalRecords = 0; 
    selectedContactList = [];
    pageNumber = 1;    
    offsetValue = 0;
    isLoaded = false;

    get selectPageSize(){
        return [
            { label : 'All', value : this.totalRecords},
            { label : '5', value : 5 },
            { label : '10', value : 10 },
            { label : '15', value : 15 },
            { label : '20', value : 20 }
        ];
    }

    //call handleSearch when page is refresh
    connectedCallback() {
        this.handleSearch();
    }

    //search contacts basic on searchInput
    handleSearch(){
        this.isLoaded = !this.isLoaded;
        searchContacts({
            searchInput : this.searchInput
        }).then(result => {
            this.selectedContactList = result;
            this.totalRecords = this.selectedContactList.length;
            this.pageNumber = 1;
            this.offsetValue = 0;
            this.recordSize = 5;              
            this.isLoaded = false;        
        });
    }

    //get contactList from controller
    get contactList() {        
        let contactPageList = [];
        let tempVar = this.offsetValue + this.recordSize;
        let maxSize = (tempVar) < this.totalRecords ? (tempVar) : this.totalRecords;

        for (let index = this.offsetValue; index < maxSize; index++) {
            contactPageList.push(this.selectedContactList[index]);
        }
        return contactPageList;
    }

    //call when searchInput is change
    handleSearchInputChange(event) {
        this.searchInput = event.target.value;
    }

    //call for change recordSize
    handlePageSizeChange(event) {
        this.recordSize = parseInt(event.target.value);
        this.offsetValue = 0;
        this.pageNumber = 1;
    }

    //call when click on first button
    handleFirstClick() {
        this.offsetValue = 0;
        this.pageNumber = 1;
        
    }
    
    //call when click on previous button
    handlePreviousClick() {
        this.offsetValue = this.offsetValue - this.recordSize;
        this.pageNumber--;
    }

    //call when click on next button
    handleNextClick() {
        this.offsetValue += this.recordSize;
        this.pageNumber++;
        console.log(this.offsetValue);
    }

    //call when click on last button
    handleLastClick() {
        this.pageNumber = Math.ceil(parseFloat(this.totalRecords) / parseFloat(this.recordSize));
        this.offsetValue = this.recordSize * (this.pageNumber - 1);
    }

    //disable first and previous button
    get disableFirstPrevious() {
        return (this.pageNumber === 1 || this.recordSize === this.totalRecords) ? true : false;        
    }

    //disable next and last button
    get disableNextLast() {
        return ((this.recordSize * this.pageNumber) < this.totalRecords) ? false : true;
    }
}