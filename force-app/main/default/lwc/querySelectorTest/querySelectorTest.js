import { LightningElement } from 'lwc';

export default class QuerySelectorTest extends LightningElement {

    connectedCallback(){
        console.log('connecte call back call');
    }
    onClickHandle(){
        var query = this.template.querySelectorAll('.inp');
        console.log('json',query);
        query.forEach(element => {
            if(element.id == 'ID'){
            console.log('ele',element.value);
            }
        });
    }
}