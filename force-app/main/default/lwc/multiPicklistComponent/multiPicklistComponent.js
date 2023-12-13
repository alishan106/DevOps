import { LightningElement, api, track } from 'lwc';

export default class MultiPicklistComponent extends LightningElement {
    @api label = ''; //Name of the dropDown
    @api maxselected = 2; //Max selected item display
    @api options; // List of items to display
    @api showfilterinput = false; //show filterbutton
    @api showrefreshbutton = false; //show the refresh button
    @api showclearbutton = false; //show the clear button
    @api comboplaceholder = 'Select a value';
    @api componentindex; //component index number

    @track _initializationCompleted = false;
    @track _selectedItems = 'Select a value';
    @track _filterValue;
    @track _mOptions;
    @track checkId;
    @api fromAgent;
    handleBlurInput() {
        console.log('multiSelect blue of ');
        // this.closeAllDropDown();
        let element = this.template.querySelector(".slds-is-open");
        if(element && element.classList){
            element.classList.remove('slds-is-open');
        }        
    }

    handleInputClick() {
        console.log('multiSelect click of ');
        this.template.querySelector('[data-id="parentDiv"]').focus();
    }

    constructor() {
        super();
        this._filterValue = '';
        //this.showfilterinput = true;
        //this.showrefreshbutton = true;
        //this.showclearbutton = true;
    }
    renderedCallback() {
        console.log('rendered call back');
        let self = this;
        console.log('rendered call back1');
        if (!this._initializationCompleted) {
            console.log('inside rendered call back');
            this.template.querySelector('.ms-input').addEventListener('click', function (event) {
                console.log('multipicklist clicked');
                self.onDropDownClick(event.target);
                event.stopPropagation();
            });
            console.log('inside rendered call back2');
            this.template.addEventListener('click', function (event) {
                console.log('multipicklist-1 clicked');
                event.stopPropagation();
            });
            console.log('inside rendered call back3');
            document.addEventListener('click', function (event) {
                console.log('document clicked');
                self.closeAllDropDown();
            });
            console.log('inside rendered call back4');
            this._initializationCompleted = true;
            this.setPickListName();
            this.onItemSelected()
            console.log('inside rendered call back5');
        }
    }
    handleItemSelected(event) {
        let self = this;
        this._mOptions.forEach(function (eachItem) {
            console.log('---eachItem : ', event.detail.selected);
            if (eachItem.value == event.detail.item.value) {
                eachItem.selected = event.detail.selected;
                return;
            }
        });
        this.setPickListName();
        this.onItemSelected();
    }
    filterDropDownValues(event) {
        console.log('filterDropDownValues');
        this._filterValue = event.target.value;
        this.updateListItems(this._filterValue);
    }
    closeAllDropDown() {
        Array.from(this.template.querySelectorAll('.ms-picklist-dropdown')).forEach(function (node) {
            node.classList.remove('slds-is-open');
        });
    }

    onDropDownClick(dropDownDiv) {
        let classList = Array.from(this.template.querySelectorAll('.ms-picklist-dropdown'));
        if (!classList.includes("slds-is-open")) {
            this.closeAllDropDown();
            Array.from(this.template.querySelectorAll('.ms-picklist-dropdown')).forEach(function (node) {
                node.classList.add('slds-is-open');
            });
        } else {
            this.closeAllDropDown();
        }
    }
    onRefreshClick(event) {
        this._filterValue = '';
        this.initArray(this);
        this.updateListItems('');
        this.onItemSelected();
    }
    onClearClick(event) {
        this._filterValue = '';
        this.updateListItems('');
    }
    connectedCallback() {
        // registerListener('closeMultiList', this.closeDropDownFromEvent, this);
        this.initArray(this);

        console.log('CALL---connectedCallback : ', this);
    }

    @api
    reRenderMultipicklist(){
        console.log("Call Rerender ", this)
        //this.initArray(this);
        this.initArray(this);
        this.setPickListName();
    }

    // disconnectedCallback(){
    //     unregisterAllListeners(this);
    // }

    closeDropDownFromEvent() {
        console.log('close dropdown');
        Array.from(this.template.querySelectorAll('.ms-picklist-dropdown')).forEach(function (node) {
            node.classList.remove('slds-is-open');
        });
    }

    @api
    initArray(context) {
        context._mOptions = new Array();
        console.log('options' , context.options)
        if(context.options != undefined && context.options != ""){
            let op = JSON.parse(JSON.stringify(context.options));
            console.log('this.fromAgent' , this.fromAgent)
            if(this.fromAgent){
                op.data.forEach(function (eachItem) {
                    context._mOptions.push(JSON.parse(JSON.stringify(eachItem)));
                });
            }else{
                op.forEach(function (eachItem) {
                    context._mOptions.push(JSON.parse(JSON.stringify(eachItem)));
                });
            }
            
        }
    }
    updateListItems(inputText) {
        Array.from(this.template.querySelectorAll('c-pick-list-item')).forEach(function (node) {
            if (!inputText) {
                node.style.display = "block";
            } else if (node.item.value.toString().toLowerCase().indexOf(inputText.toString().trim().toLowerCase()) != -1) {
                node.style.display = "block";
            } else {
                node.style.display = "none";
            }
        });
        this.setPickListName();
    }
    setPickListName() {
        console.log('set picklist')
        let selecedItems = this.getSelectedItems();
        let selections = '';
        if (selecedItems.length < 1) {
            selections = this.comboplaceholder;
        } else if (selecedItems.length > this.maxselected) {
            selections = selecedItems.length + ' Options Selected';
        } else {
            selecedItems.forEach(option => {
                selections += option.value + ',';
            });
        }
        this._selectedItems = selections;
    }
    @api
    getSelectedItems() {
        console.log('getselected item')
        let resArray = new Array();
        this._mOptions.forEach(function (eachItem) {
            if (eachItem.selected) {
                console.log("Selected Item ",eachItem);
                resArray.push(eachItem);
            }
        });
        return resArray;
    }

    onItemSelected() {
        let data = {
            index: this.componentindex,
            items: this.getSelectedItems()
        }
        const evt = new CustomEvent('itemselected', { detail: JSON.parse(JSON.stringify(data)) });
        this.dispatchEvent(evt);
    }

    @api getSelectedValueFromParent(selectedValue){
        selectedValue = selectedValue.substring(0, selectedValue.length - 1);
        this._selectedItems = selectedValue;
        
        let arr = selectedValue.split(',');
        console.log('Array = ', arr);
        this._mOptions.forEach(item => {
            if(arr.includes("'" + item.value + "'")){
                console.log('Inside if of moptions = ', item.value);
                item.selected = true;
            }
        })
        //this.setPickListName();
        this.onItemSelected();
    }
}