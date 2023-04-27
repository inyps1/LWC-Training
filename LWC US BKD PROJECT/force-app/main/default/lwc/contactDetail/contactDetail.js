import { LightningElement, wire } from 'lwc';

//1. import -> LMS
import { subscribe, MessageContext } from 'lightning/messageService';
import CC from '@salesforce/messageChannel/ContactChannel__c';

export default class ContactDetail extends LightningElement {
    //define a property to store contactID
    selectedContactID
    //2.LMS
    @wire(MessageContext) msgContext;

    //3.
    connectedCallback(){
        subscribe(this.msgContext, CC, (message) => {
            this.handleMessage(message);
        });
    }

    handleMessage = (message) => {
        this.selectedContactID = message.payload;
    }
}