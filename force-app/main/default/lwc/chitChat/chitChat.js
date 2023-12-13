import { LightningElement, track,wire} from 'lwc';
import insertChatHistory from '@salesforce/apex/ChitChatClass.insertChatHistory';
import findChatHistory from '@salesforce/apex/ChitChatClass.findChatHistory';
import {getRecord} from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/User.Name';
import USER_ID from '@salesforce/user/Id';
import chatDate from '@salesforce/schema/Chit_Chat__c.Chat_Date__c';
import chatMessage from '@salesforce/schema/Chit_Chat__c.Messages__c';
import chatAdmin from '@salesforce/schema/Chit_Chat__c.User_Name__c';

export default class ChitChat extends LightningElement {
    totalChatList = [];
    requiredInp = true;
    userName;
    @track chatId;
    @track getChatRecord = {
        Chat_Date__c: chatDate,
        Messages__c: chatMessage,
        User_Name__c: chatAdmin

    };

    @wire(getRecord, {
        recordId: USER_ID,
        fields: [NAME_FIELD]
    }) userDetails({
        data
    }) {
        if (data) {
            this.userName = data.fields.Name.value;
        }
    }
    habdleInput(event) {
        this.getChatRecord.Messages__c = event.target.value;
        this.getChatRecord.User_Name__c = this.userName;
        if (event.target.value !== "") {
            this.requiredInp = false;
        } else {
            this.requiredInp = true;
        }
    }

    get chatList() {
        findChatHistory().then(result => {
            this.totalChatList = result;
        });
        return this.totalChatList;
    }

    habdleClick() {
        var today = new Date();
        var date = today.getDate() + '-' + (today.getMonth() + 1) + '-' + today.getFullYear();
        var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
        var currentTime = time + ' [' + date + ']';
        this.getChatRecord.Chat_Date__c = currentTime;

        this.template.querySelectorAll('lightning-input[data-id="reset"]').forEach(element => {
            element.value = null;
        });
        insertChatHistory({
                chatObject: this.getChatRecord
            }).then(result => {
                
                this.getChatRecord = {};

            }).catch(error => {
                this.error = error.message;
                console.log(this.error);
            });

        findChatHistory().then(result => {
            this.totalChatList = result;
        });
        this.requiredInp = true;

    }


}