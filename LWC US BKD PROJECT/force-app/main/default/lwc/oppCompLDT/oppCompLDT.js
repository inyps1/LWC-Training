import { LightningElement, wire } from 'lwc';
import getAllOpportunites from '@salesforce/apex/OpportunityController.getAllOpportunites';
import deleteOpportunity from '@salesforce/apex/OpportunityController.deleteOpportunity';

import { deleteRecord } from 'lightning/uiRecordApi';// this is build on top of lds

import {refreshApex} from '@salesforce/apex';
import { _showToast } from 'c/util';//c/util

const COLS = [
    {label: 'Name', fieldName: 'Name', type: 'text'},
    {label: 'Stage Name', fieldName: 'StageName', type: 'text'},
    {label: 'Close Date', fieldName: 'CloseDate', type: 'date'},
    {label: 'Amount', fieldName: 'Amount', type: 'currency'},
];
export default class OppCompLDT extends LightningElement {
    @wire(getAllOpportunites) oppList; //data, error
    oppCols = COLS;
    selectedOpportunityId;
    handleRowSelection = (event) => {
        const rows = event.detail.selectedRows;
        if(rows.length > 0){
            this.selectedOpportunityId = rows[0].Id; 
        }
        console.log('selected '+this.selectedOpportunityId);
    }

    handleClick = () => {
        // // call deleteOpportunity imperetively
        // deleteOpportunity({sid:this.selectedOpportunityId}).then(() => {
        //     //fetch the reference of lightning-datatable and empty selectedRows
        //     const ldtRef = this.template.querySelector('lightning-datatable');
        //     ldtRef.selectedRows = [];
        //     _showToast(this,'COMPLETED', 'Deal has been deleted successfully', 'success');
        //     // const eventRef = new ShowToastEvent({title: 'COMPLETED', message: 'Deal has been deleted successfully', variant:'success'});
        //     // this.dispatchEvent(eventRef);
        //     refreshApex(this.oppList);
        // }).catch(() => {
        //      _showToast(this, 'INCOMPLETED', 'Won Deals can not be deleted', 'error');
        //     //  const eventRef = new ShowToastEvent({title: 'INCOMPLETED', message: 'Won Deals can not be deleted', variant:'error'});
        //     // this.dispatchEvent(eventRef);
        // })


        deleteRecord(this.selectedOpportunityId).then(() => {
            //fetch the reference of lightning-datatable and empty selectedRows
            const ldtRef = this.template.querySelector('lightning-datatable');
            ldtRef.selectedRows = [];
            _showToast(this,'COMPLETED', 'Deal has been deleted successfully', 'success');
            // const eventRef = new ShowToastEvent({title: 'COMPLETED', message: 'Deal has been deleted successfully', variant:'success'});
            // this.dispatchEvent(eventRef);
            refreshApex(this.oppList);
        }).catch(() => {
             _showToast(this, 'INCOMPLETED', 'Won Deals can not be deleted', 'error');
            //  const eventRef = new ShowToastEvent({title: 'INCOMPLETED', message: 'Won Deals can not be deleted', variant:'error'});
            // this.dispatchEvent(eventRef);
        })

    }
}