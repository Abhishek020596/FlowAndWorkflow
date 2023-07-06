import { LightningElement } from 'lwc';
import jsonData from '@salesforce/resourceUrl/EmployeeData';

export default class parentComponentFieldUsingJSON extends LightningElement {

    jsonToShow;
    Name;
    CardType;
    Value;
    arrayForDisplayValue;
    isTrueValue = true;
    indexVal = '';

    get options() {
        return this.arrayForDisplayValue;
    }

    connectedCallback() {
        let request = new XMLHttpRequest();
        request.open("GET", jsonData, false);
        request.send(null);
        this.jsonToShow = JSON.parse(request.responseText);
        console.log('staticResourcesData ', this.jsonToShow);


        console.log('JSONValues------->>>>>', this.jsonToShow.fields.columns[0].Name);
        // let jsonColumnsArray = new Array();
        // jsonColumnsArray = this.jsonToShow['fields']['columns'];
        // console.log("jsonColumnsArray========================= ", jsonColumnsArray);

        // let arr = [];
        // for (var i = 0; i < jsonColumnsArray.length; i++) {
        //     console.log('element.Name>>', jsonColumnsArray[i].Name);
        //     arr.push({ label: jsonColumnsArray[i].Name, value: jsonColumnsArray[i].Name })
        // }
        // console.log('arrr>>', arr);
        // this.arrayForDisplsyValue = arr;
        // console.log('this.arrayForDisplsyValue ', this.arrayForDisplsyValue);
    }
}