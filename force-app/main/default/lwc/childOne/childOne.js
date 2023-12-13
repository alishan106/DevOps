import { LightningElement } from 'lwc';
export default class ChildOne extends LightningElement {

    handleClick() {
        let ev = new CustomEvent('childmethod',
            { detail: '' }
        );
        this.dispatchEvent(ev);
    }
}