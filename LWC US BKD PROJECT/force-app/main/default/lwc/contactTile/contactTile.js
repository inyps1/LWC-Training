import { LightningElement, api } from 'lwc';

export default class ContactTile extends LightningElement {
    @api contact;
    @api selectedContactId;

    handleClick = () => {
        const payload =  this.contact.Id;
        //Custom Event -> child component commnicate with parent
        const eventRef = new CustomEvent('contactclick', {bubbles: true, composed:true ,detail: {conId: payload}})//eventname should be all lowercase
        //bubbles: true allows to receive event within compound ,  composed:false wont allow to go beyond compound// compose true allow grandparent component to receive the event
        this.dispatchEvent(eventRef);
    }

    get applyCss(){
        return this.selectedContactId === this.contact.Id ? 'tile selected' : 'tile';
    }
}