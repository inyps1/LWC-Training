import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';

//1. import -> LMS
import { publish, MessageContext } from 'lightning/messageService';
import CC from '@salesforce/messageChannel/ContactChannel__c';
// messageChannel is singular name in salesforce server even though in vs code , name is plural 

export default class ContactBrowser extends LightningElement {
    contactList;

    //2.LMS -> wire MessageContext
    @wire(MessageContext) msgContext;

    @wire(getContacts)

    //define a property to store contact id
    //selectedContactId;
    wiredGetContacts({data}) { // when we know there is never error, {data} as arg
        if (data) {
            this.contactList = [];
            data.forEach((con) => {
                const obj = {
                    Id:con.Id,
                    Name: con.FirstName + ' ' + con.LastName,
                    Email: con.Email,
                    Phone: con.Phone,
                    PhotoUrl: '/services/images/photo/00380FakePictId'
                };
                this.contactList.push(obj);
            });
        }
    }

    handleContactClick = (event) => {
        console.log('from brower', event.detail.conId);
        //this.selectedContactId = event.detail.conId;
        const galleryRef = this.template.querySelector('c-contact-tiles');
        const gridRef = this.template.querySelector('c-contact-table');
        if(galleryRef) {
            galleryRef.setTilesValue(event.detail.conId);
        }
        if(gridRef) {
            gridRef.setTableValue(event.detail.conId);
        }
        //3.LMS
        publish(this.msgContext, CC, {payload: event.detail.conId});
    }
}