import { LightningElement } from 'lwc';
import jsonData from '@salesforce/resourceUrl/EmployeeData';

export default class Parentjsoncontentfile extends LightningElement {
    jsonValue;

    connectedCallback(){
        console.log('connectedCallback======');
        this.getLabel();
        console.log(' this.jsonValue', this.jsonValue);
    }

    getLabel(){
        var request = new XMLHttpRequest();
        request.open("GET", jsonData, false);
        request.send();
        this.jsonValue = JSON.parse(request.responseText,this.jsonValue);

    }

    handleOptionChange(event){
        this.value = event.target.value;
        console.log("jsonvalue========================== ",this.jsonValue.ConcessionAuthory);
        console.log("pickilist Value ========================= ", this.value);

    }
}