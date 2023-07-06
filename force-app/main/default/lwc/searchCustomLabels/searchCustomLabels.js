import { LightningElement, wire } from 'lwc';
import retrieveCustomValue from '@salesforce/apex/CustomLabelHandler.retrieveCustomValue';

export default class SearchCustomLabels extends LightningElement {

    searchKey;
    customLabelValue;
    error;

    handleSearch(event){
        this.searchKey = event.target.value;
        console.log('____________searchKey_____________',this.searchKey);
        retrieveCustomValue({searchkey : this.searchKey})
        .then(result=>{
            this.customLabelValue = result;
            console.log('____________IF__customLabelValue______________', this.customLabelValue);
        })
        .catch(error=>{
            this.customLabelValue = undefined;
            console.log('____________Else__customLabelValue______________', this.customLabelValue);
        })
    }

    // @wire(retrieveCustomValue, {searchKey : '$searchKey'})
    // retrieveData({data,error}){
    //     if(data){
    //         this.customLabelValue = data;
    //         console.log('____________IF__customLabelValue______________', this.customLabelValue);
    //         this.error = undefined;
    //     }else{
    //         this.customLabelValue = undefined;
    //         console.log('____________Else__customLabelValue______________', this.customLabelValue);
    //         this.error = error;
    //     }
    // }
    // searchName(event) {
    // }
}