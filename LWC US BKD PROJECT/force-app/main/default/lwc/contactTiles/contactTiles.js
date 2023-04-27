import { LightningElement, api } from 'lwc';

export default class ContactTiles extends LightningElement {
    //define a public property to store contactList
    @api conList; //public isExposed = false and @api, //global -> esExposed = true along with @api // isExposed from meta xml
    selectedContactId;
    handleContactClick = (event) => {
        console.log(event.detail.conId)
        this.selectedContactId = event.detail.conId;
    };

    @api setTilesValue(conId) {
        this.selectedContactId = conId;
    } 
}