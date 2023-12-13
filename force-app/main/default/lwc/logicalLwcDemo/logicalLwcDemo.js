import { LightningElement, track } from 'lwc';

export default class LogicalLwcDemo extends LightningElement {

    @track greeting="Hello User";
    @track message;
    @track contacts = [
        {
            Id : '12345',
            Name : 'Abcde'
        },
        {
            Id : '56789',
            Name : 'Fghij'
        },
        {
            Id : '101112',
            Name : 'Klmno'
        }

    ];

}