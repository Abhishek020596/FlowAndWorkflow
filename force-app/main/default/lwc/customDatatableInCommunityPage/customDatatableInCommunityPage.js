import { LightningElement, wire } from 'lwc';
import retrieveContacts from '@salesforce/apex/AllContactsInCommunityPage.retrieveContacts';
 
const columns = [
    { label: 'FirstName', fieldName: 'FirstName'},
    { label: 'LastName', fieldName: 'LastName'},
    { label: 'Phone', fieldName: 'Phone'},
    { label: 'Email', fieldName: 'Email'},
];

export default class CustomDatatableInCommunityPage extends LightningElement {
    data = [];
    columns = columns;

    @wire(retrieveContacts) 
    wiredContacts({ error, data }) {
        if (data) {
            this.data = data;
            console.log('____________if_this.data______________', this.data);
            this.error = undefined;
        } else if (error) {
            this.data = error;
            console.log('____________error_this.data______________', this.data);
            this.record = undefined;
        }
    }
}