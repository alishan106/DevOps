import { LightningElement, api, track } from 'lwc';

export default class FilterCriteria extends LightningElement {
    @api displayIndex;
    @api showOperators;
    @api fieldsList = [];
    @api selectedField = '';
    @api selectedValue = ''
    hasRendered = true;
    @api fieldSelect;
    @api fields = [];
    fieldData = [];
    @api fieldList = [];
    results;
    @track selectedLabel = '';
    @track selectedValue = [];
    rowId;
    renderedCallback() {
        if (this.hasRendered && this.fieldsList) {
            this.hasRendered = false;

            this.template.querySelectorAll('lightning-combobox').forEach(element => {
                element.classList.remove('slds-form-element_horizontal');
            });
            console.log('fieldList', JSON.parse(JSON.stringify(this.fieldList)))
        }
    }

    handleField(event) {

        console.log('event.target-', this.event.value);
    }

    removeRows(event) {
        let removeSelectedLabel = event.currentTarget.dataset.label;
        let removeSelectedValue = event.currentTarget.dataset.value;
        this.displayIndex = event.currentTarget.dataset.id;
        console.log('rowId-->', this.displayIndex);
        let tempObj = {
            removeSelectedLabel: removeSelectedLabel,
            removeSelectedValue: removeSelectedValue,
        };
        console.log('tempObj', tempObj);
        const passEvent = new CustomEvent('removerow', {
            detail: { recordId: this.displayIndex, removeRow: tempObj }
        });
        this.dispatchEvent(passEvent);

    }
    showSearchResults(event) { // Method to handle input and filter dropdown
        let searchValue = event.target.value;
        this.fieldData = JSON.parse(JSON.stringify(this.fieldList));
        this.results = this.fieldData.filter(item => {
            console.log('Label = ', item.label.includes(searchValue))
            let itemLabel = item.label.toLowerCase();
            if (itemLabel.includes(searchValue.toLowerCase())) {
                return item;
            }
        });
        this.openDropDown();
    }

    handleFocusLostInputBox(event) {
        this.closeDropDown();

    }
    openDropDown() {

        if (this.results.length < 1) {
            this.closeDropDown();
            this.results = this.listName;
            return;
        }

        if (!this.openDropDownFired) {
            let node = this.template.querySelector('.slds-dropdown-trigger');
            if (node && node.className.indexOf('slds-is-open') === -1) {
                node.classList.add('slds-is-open');
            }

        }
        this.openDropDownFired = true;
        setTimeout(function (self) {
            self.openDropDownFired = false;
        }, 100, this);
    }

    closeDropDown() {
        let node = this.template.querySelector('.slds-dropdown-trigger');
        if (node && node.className.indexOf('slds-is-open') != -1) {
            node.classList.remove('slds-is-open');
        }
    }
    scrollToSelectedNode(selectedNode, asyncScroll) {
        let lstBox = this.template.querySelector('.slds-dropdown');
        if (lstBox && selectedNode) {
            lstBox.scrollTop = selectedNode.offsetTop;
            if (asyncScroll)
                setTimeout(function () {
                    lstBox.scrollTop = selectedNode.offsetTop;
                }, 10);
        }
    }

    removeHasSelected(node) {
        node.childNodes.forEach(function (nodeChild) {
            if (nodeChild.className.indexOf('hasSelected') != -1) {
                nodeChild.classList.remove('hasSelected');
            }
        })
    }

    applyHasSelected(node) {
        this.removeHasSelected(node.parentNode);
        if (node.className.indexOf('hasSelected') == -1) {
            node.classList.add('hasSelected');
        }
    }

    selectedItem(event) {
        this.selectedLabel = event.currentTarget.dataset.label;
        this.selectedValue = event.currentTarget.dataset.value;
        this.selectedField = this.selectedLabel;
        //let pickedValue = event.currentTarget.dataset.value;
        //this.fieldList = this.fieldList.filter(value => value !== pickedValue);
        //console.log('selectedlabel' , this.fieldList);
        this.closeDropDown();
        console.log('this.selectedValue', this.selectedValue)
        let tempObj = {
            Id: this.displayIndex,
            selectedField: this.selectedField,
            selectedValue: this.selectedValue,
        };
        console.log('Child Component', tempObj);
        if (!this.showOperators) {
            this.dispatchEvent(new CustomEvent('selectedvalue', { detail: tempObj }));
        }

    }

    setInputBoxValue(event, value) {
        event.currentTarget.value = value;
        this.selectedLabel = event.currentTarget.label;
    }
    preventFocus(event) {
        event.preventDefault();
    }


}