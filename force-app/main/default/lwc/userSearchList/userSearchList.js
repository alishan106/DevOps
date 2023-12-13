import { LightningElement, wire } from 'lwc';
import SearchingContact from '@salesforce/apex/UserSearchBoxController.getUsersList';
export default class UserSearchList extends LightningElement {

results = '';
selectedMetadataLabel = '';

@wire(SearchingContact)
getUserLists; 

showSearchResults(event){ 
    let searchValue = event.target.value;
    if(this.getUserLists.data.length > 0){
        this.results = this.getUserLists.data.filter(item=> {
            let itemLabel = item.label.toLowerCase();
            if(itemLabel.includes(searchValue.toLowerCase())){
                return item;
            }
        });
        this.openDropDown();
    }
}


openDropDown() {
       
    if(this.results.length < 1){
        this.closeDropDown();
        this.results = this.getUserLists;
        return;
    }       
        
    if(!this.openDropDownFired){
        let node = this.template.querySelector('.slds-dropdown-trigger');
        if (node && node.className.indexOf('slds-is-open') === -1) {
            node.classList.add('slds-is-open');
        }    
        
    }
    this.openDropDownFired = true;
    setTimeout(function(self) {
       self.openDropDownFired = false;
    }, 100, this);
}

closeDropDown(){
    let node = this.template.querySelector('.slds-dropdown-trigger');
    if (node && node.className.indexOf('slds-is-open') != -1) {
        node.classList.remove('slds-is-open');
    }
}

selectItem(event){ 
    this.selectedMetadataLabel =  event.currentTarget.dataset.label;
    this.closeDropDown();

}
}