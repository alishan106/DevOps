import { LightningElement,track, api , wire} from 'lwc';
import getListOfObjDetails from '@salesforce/apex/InsertRecordsController.getListOfObjDetails';
export default class ObjectFields extends LightningElement {


// @api object;
//     @api changeMessage(details){
//             this.object = details;
//             console.log(this.object);
            
            
//             getFields({ selectedObject: this.object })
// 		.then(result => {
//             console.log(JSON.stringify(result));
            
//             for(var i=0; i<result.length; i++) {  
//                 console.log('r222'+result[i]); 
//                 this.objectFields.push({label : result[i].toUpperCase() , value : result[i]});             
//             }
// 			console.log('@@@@@'+JSON.stringify(this.objectFields));
// 			this.objError = undefined;
// 		})
// 		.catch(error => {
// 			this.objError = error;
// 			this.objectFields = undefined;
// 		})
//         }


// @track objItems = [];
    
//     @track objError;

//     @wire
//     (getListOfObjDetails) listOfObjectDetails({ error, data }) {
//         if (data) {
//             for(var i=0; i<data.length; i++) {
//                 this.objItems = [...this.objItems ,{value: data[i].objAPI , label: data[i].objLabel}];                
//             }
//         } else if (error) {
//             this.objError = error;
//             this.objects = undefined;
//         }
//     }
//     get objectOptions() {
//         return this.objItems;    
//     }








    openDropDownFired = false;
    selectedMetadataLabel = '';
    results = '';
    isSelectAgentQueue = false;

    @wire(getListOfObjDetails, {})
    AgentQueues;
    
    showSearchResults(event){ // Method to handle input and filter dropdown
        this.isSelectAgentQueue = false;
        let searchValue = event.target.value;
        this.selectedMetadataLabel = searchValue;
        if(this.AgentQueues.data.length > 0){
            this.results = this.AgentQueues.data.filter(item=> {
                let itemLabel = item.objLabel.toLowerCase();
                if(itemLabel.includes(searchValue.toLowerCase())){
                    return item;
                }
            });
            this.openDropDown();
            this.notifyParent();
        }
    }

    openDropDown() {
       
        if(this.results.length < 1){
            this.closeDropDown();
            this.results = this.AgentQueues;
            return;
        }       
        //console.log('openDropDownFired',this.openDropDownFired);     
        if(!this.openDropDownFired){
            let node = this.template.querySelector('.slds-dropdown-trigger');
            if (node && node.className.indexOf('slds-is-open') === -1) {
                node.classList.add('slds-is-open');
            }    
            //console.log('select list item');
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
        this.isSelectAgentQueue = true;
        this.selectedMetadataLabel =  event.currentTarget.dataset.label;
        console.log('In select Item function')
        this.closeDropDown();
        console.log('Selected Agent Queue = ', this.selectedMetadataLabel);
        this.applyHasSelected(event.currentTarget);
        this.scrollToSelectedNode(event.currentTarget);
        this.notifyParent();
    }

    notifyParent(){
        if(this.isSelectAgentQueue){
            this.dispatchEvent(new CustomEvent("selectedqueue", {detail : this.selectedMetadataLabel}));
        }else{
            this.dispatchEvent(new CustomEvent("selectedqueue", {detail : ''}));
        }
    }

    scrollToSelectedNode(selectedNode, asyncScroll){
        let lstBox = this.template.querySelector('.slds-dropdown');
        if(lstBox && selectedNode){
            lstBox.scrollTop = selectedNode.offsetTop;
            if(asyncScroll)
                setTimeout(function() {
                    lstBox.scrollTop = selectedNode.offsetTop;
                }, 10);            
        }
    }

    removeHasSelected(node){
        node.childNodes.forEach(function(nodeChild){
            if(nodeChild.className.indexOf('hasSelected') != -1){
                nodeChild.classList.remove('hasSelected');
            }
        })
    }

    applyHasSelected(node){
        this.removeHasSelected(node.parentNode);  
        if(node.className.indexOf('hasSelected') == -1){
            node.classList.add('hasSelected');
        }
    }

    handleFocusLostInputBox(event){ // method to close dropdown
        this.closeDropDown();
        /*if(this.template.querySelector('.hasSelected') && !this.selectedMetadataLabel){
            let valueToSet = this.template.querySelector('.hasSelected').dataset.label;
            console.log('Value to Set = ' + valueToSet);
            
            if(valueToSet == this.selectedMetadataLabel){
                this.setInputBoxValue(event, valueToSet);
                
            }
            else    
                this.template.querySelector('.hasSelected').classList.remove('hasSelected');
                
        }else if(this.selectedMetadataLabel){
            let inputBoxValue = this.selectedMetadataLabel;
            event.currentTarget.value = inputBoxValue;
            this.results = this.AgentQueues;
            setTimeout(function(self){
                self.selectListItemForValue(self.selectedMetadataLabel);
            }, 100, this)
        }else{
            this.setInputBoxValue(event, '');
            this.results = this.AgentQueues;
        }*/       
    }

    setInputBoxValue(event, value){
        event.currentTarget.value = value;
        this.selectedMetadataLabel = event.currentTarget.label;
    }

    preventFocus(event){
        event.preventDefault();
    }
        


}