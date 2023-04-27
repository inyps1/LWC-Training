import { LightningElement, wire } from 'lwc';
import getAllOpportunites from '@salesforce/apex/OpportunityController.getAllOpportunites';

export default class OppCompWF extends LightningElement {

    oppList;// Define a property to store the deals along with tax

    @wire(getAllOpportunites)
    wiredGetAllOpportunities({data, error}) { // order does not matter but name matters // 2 times invoked
        //1st invocation - data and error undefined
        //2nd invocation - data or error will have value
        //so, use if case for both data and error.or else if() for second one. not use if else for data and error
        if(data) {
            this.oppList = [];//best practice
            data.forEach((opp) => {
                const obj = {
                    Name: opp.Name,
                    StageName: opp.StageName,
                    CloseDate: opp.CloseDate,
                    Amount: opp.Amount,
                    Id: opp.Id,
                    CovidTax: opp.Amount * 0.10
                };
                this.oppList.push(obj);
            })
        } else if(error) {
            alert('error')
        }
    }
}