import { LightningElement } from 'lwc';

export default class LwcDependentPicklist extends LightningElement {
    value="";
    get Country() {
        return [
            { label: 'India', value: 'india' },
            { label: 'America', value: 'america' },
            { label: 'China', value: 'china' },
        ];
    }
    get State() {
        return [
            { label: 'Rajasthan', value: 'rajasthan' },
            { label: 'Madhya Pradesh', value: 'madhyaPradesh' },
            { label: 'Uttar Pradesh', value: 'uttarPradesh' },
        ];
    }
    get City() {
        return [
            { label: 'Jaipur', value: 'jaipur' },
            { label: 'Bhopal', value: 'bhopal' },
            { label: 'Lucknow', value: 'lucknow' },
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }



}