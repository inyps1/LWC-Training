import { LightningElement, api } from 'lwc';

export default class ContactTable extends LightningElement {
    @api conList;
    previousTrRef;// default value is undefined
    selectedContactId;

    @api setTableValue(conId) {
        this.selectedContactId = conId;
         if(this.previousTrRef) {
            this.previousTrRef.classList.remove('slds-is-selected');
        }
        const allTrRefs = this.template.querySelectorAll('tr');
        for(let i = 0; i <  allTrRefs.length; i++) {
            const trRef = allTrRefs[i];
            if(trRef.getAttribute('data-sid') === conId) {
                trRef.classList.add('slds-is-selected');
                this.previousTrRef = trRef;
                break;
            }
        }
    }

    handleClick = (event) => {
        const trRef = event.currentTarget;
        if(this.previousTrRef) {
            this.previousTrRef.classList.remove('slds-is-selected');
        }
        //apply slds-is-selected  on tr
        trRef.classList.add('slds-is-selected');
        this.previousTrRef = trRef;
        const conId = trRef.getAttribute('data-sid');
         const payload =  conId;
        //Custom Event -> child component commnicate with parent
        const eventRef = new CustomEvent('contactclick', {detail: {conId: payload}})//eventname should be all lowercase
        //bubbles: true allows to receive event within compound ,  composed:false wont allow to go beyond compound// compose true allow grandparent component to receive the event
        this.dispatchEvent(eventRef);
    };
}