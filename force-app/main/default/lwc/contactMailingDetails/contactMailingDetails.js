import { LightningElement, track, wire } from 'lwc';
import gettingContactList from '@salesforce/apex/ContactMailingDetailsHandler.gettingContactList'; 

export default class ContactMailingDetails extends LightningElement {

    @track contactList;
    @track error;
    @track conVal;
    @track isShowModal = false;
    @track contactData = [];


    @wire(gettingContactList)
    listOfContacts({data, error}){
        if(data){
            this.contactList = data;
            console.log('__________mailcontactList___________', JSON.stringify(this.contactList));
            this.error = undefined;
        }else if(error){
            this.error = error;
            console.log('_____________mailerror___________________',this.error);
            this.contactList = undefined;
        }
    }
    handleContactRecords(event){
        this.conVal = event.target.dataset.id;
        this.isShowModal = true;

        console.log('___________event________________' , this.conVal);
       
        for(let i=0; i<this.contactList.length; i++){
            if(this.contactList[i].Id===event.target.dataset.id){
                this.contactData = this.contactList[i];
                console.log("contactListDetail==========", JSON.stringify(this.contactData));
                break;
            }
        }
        console.log("contactListDetail==========", JSON.stringify(this.contactData));

    }
    hideModalBox(){
        this.isShowModal = false;
    }
}