import { api, LightningElement, track, wire } from 'lwc';
import jsonData from '@salesforce/resourceUrl/EmployeeData';

export default class CreatingFieldUsingJSON extends LightningElement {

    // jsonToShow;
    // Name;
    // CardType;
    // Value;
    @api arrayPicklistValue = [];
    // value = '';
    // pickNumber = 1;
    // isTrueValue = true;
    // indexVal = '';


    

    // get options() {
    //     return this.arrayForDisplsyValue;
    // }

    // connectedCallback() {
    //     let request = new XMLHttpRequest();
    //     request.open("GET", jsonData, false);
    //     request.send(null);
    //     this.jsonToShow = JSON.parse(request.responseText);
    //     console.log('staticResourcesData ', this.jsonToShow);

    //     let jsonColumnsArray = new Array();
    //     jsonColumnsArray = this.jsonToShow['fields']['columns'];
    //     console.log("jsonColumnsArray========================= ", jsonColumnsArray);

    //     let arr = [];
    //     for (var i = 0; i < jsonColumnsArray.length; i++) {
    //         console.log('element.Name>>', jsonColumnsArray[i].Name);
    //         arr.push({ label: jsonColumnsArray[i].Name, value: jsonColumnsArray[i].Name })
    //     }
    //     console.log('arrr>>', arr);
    //     this.arrayForDisplsyValue = arr;
    //     console.log('this.arrayForDisplsyValue ', this.arrayForDisplsyValue);
    // }
    selectedCardName(event) {

        if(event.target.value !=null ){
            console.log('Value Name>>>11', event.target.value);
            this.isTrueValue=true;
            this.indexVal++;
        }
        console.log('Value Name>>>', event.target.value);
    }
    onChangeEmail(event) {
        console.log('Text Value--->>>', event.target.value);
    }
}