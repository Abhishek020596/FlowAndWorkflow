import { LightningElement, wire } from 'lwc';
import findAccounts from '@salesforce/apex/AccountDataHandler.findAccounts';

export default class FetchningAccountData extends LightningElement {
    searchKey;
    accounts;
    error;
    selectedAccountId = '';
    playerName = 0;

    @wire(findAccounts, { searchKey: '$searchKey' })
    searchAccounts({ data, error }) {
        if (data) {
            this.accounts = data;
            console.log('_________Parentdata_________', this.accounts);
            this.error = undefined;
        } else {
            this.accounts = undefined;
            console.log('_________Parenterror_________', this.error);
            this.error = error;
        }
    };
    updateUsername(event) {
        this.searchKey = event.target.value;
    }
    handleValue(event){
        this.selectedAccountId = event.target.dataset.id;
        console.log('_________this.recordId', this.selectedAccountId );
    }
    handleTotalRevenue(event){
        console.log('===parent====');
        this.playerName = event.detail.expectedRev;
        console.log('____________playerName____________', this.playerName);
    }
}