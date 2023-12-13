import { api, LightningElement, track } from 'lwc';

export default class ListDemo extends LightningElement {
    @api priv='Lightning Web Component';
    @track
    id1;
    id2;
    id3;
    text='Zeeshan Ali';
    mail='aizeeshan106@gmail.com';
    phone='9876543210';
    
    method(event){
        alert('How are you '+this.id1);
        alert('Your Selected Date '+this.id2);
        alert('Your Input Email '+this.id3);
    }
    inpHandle(event){
        const name = event.target.name;
        if (name === 'inp1') {
        this.id1 = event.target.value;
        }else if(name === 'inp2'){
        this.id2 = event.target.value;
        }else if(name === 'inp3'){
        this.id3 = event.target.value;
        }
    }
        jsCall(){
            /* eslint-disable no console*/
            console.log('this message from JS');
            this.taxt='Kamal Khan';
            this.phone='1234567890';
        }
}