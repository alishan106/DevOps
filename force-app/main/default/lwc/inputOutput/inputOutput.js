import { LightningElement,track } from 'lwc';

export default class InputOutput extends LightningElement {
    @track name;
    contactList = [{
        userId : '12345',
        userName : 'alishan',
        userMail : 'alishan@gmail.com',

    },
    {
        userId : '23456',
        userName : 'aliZeeshan',
        userMail : 'alizeeshan@gmail.com',
    },
    {
        
        userId : '34567',
        userName : 'aliAnsari',
        userMail : 'alishan106@gmail.com',
        
    }
    ];
 demo(){
     alert(this.name);
 }   
}