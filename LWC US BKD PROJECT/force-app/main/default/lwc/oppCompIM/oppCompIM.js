import { LightningElement } from 'lwc';
import getAllOpportunites from '@salesforce/apex/OpportunityController.getAllOpportunites';

export default class OppCompIM extends LightningElement {
    oppList; //to store the opportunities
    loadAllOpportunities = () => {
        // call apex method explictly - returns js promise
        getAllOpportunites().then( (result) => {
            this.oppList = result;
            //any additional business logic
        }).catch((issue) => {
            console.log(JSON.stringify(issue));
        })
    };
}