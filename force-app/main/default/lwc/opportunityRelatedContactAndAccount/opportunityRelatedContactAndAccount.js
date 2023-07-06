import { LightningElement, wire } from 'lwc';
import retrieveOpporunityData from '@salesforce/apex/OpportunityRelatedContactAndAccount.retrieveOpporunityData';
export default class OpportunityRelatedContactAndAccount extends LightningElement {

    data;
    error;
    record;
    oppNumber;
    password;
    pwd;
    verifyValue = false;
    message;

    oppoNum(event) {
        this.oppNumber = event.target.value
        // console.log('____________oppNumber______________', this.oppNumber);
    }
    passwords(event) {
        this.password = event.target.value;
        // console.log('____________password________________', this.password);
    }
    verifyCredential() {
        retrieveOpporunityData({ oppNum: this.oppNumber }).then(result => {
            this.record = result;
            this.pwd = this.record.Password__c;
            // console.log('______________this.pwd________________', this.pwd);
            // console.log('____________this.record________________', this.record);
            if (this.pwd === this.password && this.password !== null) {
                this.verifyValue = true;
                this.message = 'VERIFIED';
                // console.log('___________________MATCHED______________________');
            } else {
                this.verifyValue = true;
                this.message = ' NOT VERIFIED';
                // console.log('__________________NOT MATCHED____________________');
            }
        }).catch(error => {
            this.error = error;
            // console.log('_____________this.error_______________', this.error);
            
            this.record = undefined;
            this.verifyValue = true;
            this.message = ' NOT VERIFIED';
            // console.log('__________________NOT MATCHED____________________');
        });
    }
}