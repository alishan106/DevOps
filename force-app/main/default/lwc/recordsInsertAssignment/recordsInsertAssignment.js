import { LightningElement,track, api , wire} from 'lwc';
import getListOfObjDetails from '@salesforce/apex/InsertRecordsController.getListOfObjDetails';

export default class ObjectFields extends LightningElement {

    openDropDownFired = false;
    selectedMetadataLabel = '';
    @api selectedObject ='';
    fieldsResult = [];
    results = '';
    isObjectSelected = false;
    
    // connectedCallback(){
    //     this.selectedObject = 'Contact';
    //     this.getFieldsHandle();

    // }

    @wire(getListOfObjDetails, {})
    objectList;
    
    showSearchResults(event){ // Method to handle input and filter dropdown
        this.isObjectSelected = false;
        let searchValue = event.target.value;
        this.selectedMetadataLabel = searchValue;
        if(this.objectList.data.length > 0){
            this.results = this.objectList.data.filter(item=> {
                let itemLabel = item.objLabel.toLowerCase();
                if(itemLabel.includes(searchValue.toLowerCase())){
                    return item;
                }
            });
            this.openDropDown();
            //this.notifyParent();
        }
    }

    openDropDown() {
       
        if(this.results.length < 1){
            this.closeDropDown();
            this.results = this.objectList;
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

    selectItem(event){ // Method to handle selected value from multipicklist
        this.isObjectSelected = true;
        this.selectedMetadataLabel =  event.currentTarget.dataset.label;
        this.selectedObject =  event.currentTarget.dataset.id;
        this.closeDropDown();
         console.log('Selected Agent Queue = ', this.selectedObject);
        // this.applyHasSelected(event.currentTarget);
        // this.scrollToSelectedNode(event.currentTarget);
        this.notifyParent();
    }

    notifyParent(){
        console.log('123456790');
        console.log(this.selectedObject);
        if(this.isObjectSelected){
            this.dispatchEvent(new CustomEvent("progressvaluechange", {detail : this.selectedObject}));
            console.log('avvvvvvvv');
        }else{
            this.dispatchEvent(new CustomEvent("progressvaluechange", {detail : ''}));
            console.log('avvvvvvvv2');
        }
    }

    getFieldsHandle(){
        getFieldList({ selectedObject: this.selectedObject })
		.then(result => {
            console.log(JSON.stringify(result));
            
            for(var i=0; i<result.length; i++) {  
                console.log('r222'+result[i]); 

                this.fieldsResult.push({label : result[i].toUpperCase() , value : result[i]});             
            }
			console.log('@@@@@'+JSON.stringify(this.fieldsResult));
			this.objError = undefined;
		})
		.catch(error => {
			this.objError = error;
			this.fieldsResult = undefined;
		})
    }

    // scrollToSelectedNode(selectedNode, asyncScroll){
    //     let lstBox = this.template.querySelector('.slds-dropdown');
    //     if(lstBox && selectedNode){
    //         lstBox.scrollTop = selectedNode.offsetTop;
    //         if(asyncScroll)
    //             setTimeout(function() {
    //                 lstBox.scrollTop = selectedNode.offsetTop;
    //             }, 10);            
    //     }
    // }

    // removeHasSelected(node){
    //     node.childNodes.forEach(function(nodeChild){
    //         if(nodeChild.className.indexOf('hasSelected') != -1){
    //             nodeChild.classList.remove('hasSelected');
    //         }
    //     })
    // }

    // applyHasSelected(node){
    //     this.removeHasSelected(node.parentNode);  
    //     if(node.className.indexOf('hasSelected') == -1){
    //         node.classList.add('hasSelected');
    //     }
    // }

    // handleFocusLostInputBox(event){ // method to close dropdown
    //     openDropDownFired = false;
    //     this.closeDropDown();
        
    // }

    // setInputBoxValue(event, value){
    //     event.currentTarget.value = value;
    //     this.selectedMetadataLabel = event.currentTarget.label;
    // }

    preventFocus(event){
        event.preventDefault();
    }
        


}