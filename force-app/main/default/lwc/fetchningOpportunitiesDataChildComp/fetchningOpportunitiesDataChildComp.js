import { LightningElement, api, track, wire } from 'lwc';
import getOpportunityRelatedToAccount from '@salesforce/apex/AccountDataHandler.getOpportunityRelatedToAccount';

export default class FetchningOpportunitiesDataChildComp extends LightningElement {
    @api oppresultId = '';
    @api expectedRev = 0;
    oppoList;
    error;
    @track myVar = 0;

    @wire(getOpportunityRelatedToAccount, { accId: '$oppresultId' })
    WireOpportunityRecords({ data, error }) {
        if (data) {
            this.oppoList = data
            this.oppoList.forEach(element => {
                this.expectedRev += (element.ExpectedRevenue);
            });
            this.handleExpectedValue();
            console.log('___________element____________', JSON.stringify(this.expectedRev));
            console.log('_________Childdata___________', this.oppoList);
        }
        else if (error) {
            this.error = error;
            console.log('___________Childerror__________', this.error);
        }
    }
    handleExpectedValue(event) {
        console.log('____________childMethod____________', this.expectedRev);
        const custEvent = new CustomEvent('totalvalues', {
            detail: { expectedRev: this.expectedRev }
        })
        this.dispatchEvent(custEvent);
    }
    changingtoggle(event) {
        console.log('id =============> ' , event.target.dataset.revenue);
        if (event.target.checked === true) {
            this.expectedRev += parseInt(event.target.dataset.revenue); 
        } else {
            this.expectedRev -= parseInt(event.target.dataset.revenue); 
        }
        this.handleExpectedValue();
        console.log('______________after Change___________', this.expectedRev);
    }
}