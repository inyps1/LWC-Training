import { LightningElement, wire } from 'lwc';
import getAllOpportunites from '@salesforce/apex/OpportunityController.getAllOpportunites';

export default class OppCompWP extends LightningElement {
    @wire(getAllOpportunites) oppList;//oppList will have data,err //injected by framework
}