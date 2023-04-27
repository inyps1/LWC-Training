import { LightningElement, api } from 'lwc';

export default class CustomRecordDetail extends LightningElement {
    @api recordId;
    @api objectApiName;
}