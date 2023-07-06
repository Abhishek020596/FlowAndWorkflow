import { LightningElement, wire } from 'lwc';
import retrieveMetaValue from '@salesforce/apex/SearchObjectUsingCustomMetaDataHandler.retrieveMetaValue';
import getAllRecords from '@salesforce/apex/SearchObjectUsingCustomMetaDataHandler.getAllRecords';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class SearchingObjectUsingCustomMetaData extends LightningElement {
    objName;
    fieldsValue;
    data;
    mainresult;
    searchKey;
    columns = [];
    saveDraftValues = [];
    error;

    connectedCallback() {
        retrieveMetaValue({})
            .then(result => {
                //console.log('____________result_______________', result);
                result.forEach(element => {
                    this.objName = element.ObjectName__c;
                    //console.log('__________ element.objName____________', this.objName);
                    this.fieldsValue = element.Fields__c;
                    //console.log('__________ element.fieldsValue____________', this.fieldsValue);
                    var fileVal;
                    fileVal = this.fieldsValue.split(',');
                    //console.log('______________fileVal________________', JSON.stringify(fileVal));
                    fileVal.forEach(element => {
                        if (element == 'Name') {
                            console.log('_________________________');
                            var eleVal2 = { label: element, fieldName: 'recordNameUrl', type: 'url', typeAttributes: { label: { fieldName: 'Name' }, target: '_self' } };
                            this.columns = [...this.columns, eleVal2];
                        } else {
                            var eleVal = { label: element, fieldName: element, editable: true };
                            this.columns = [...this.columns, eleVal];
                        }
                    });
                    console.log('____________this.columns_______________', JSON.stringify(this.columns));
                });
            })
            .catch(error => {
                this.error = error;
                //console.log('____________this.error______________', this.error);
            });
    }

    handleSearch(event) {
        this.searchKey = event.target.value;
        //console.log('__________this.searchKey_____________', this.searchKey);
        //console.log('__________this.objName_________________', this.objName);
        //console.log('__________this.fieldsValue_____________', this.fieldsValue);
    }

    @wire(getAllRecords, { searchKey: '$searchKey', objectName: '$objName', fields: '$fieldsValue' })
    contacts(result) {
        this.mainresult = result;
        //console.log('___________getAllRecordssssssssssssss____________',result.data);
        if (result.data) {
            let orignalData = [];
            result.data.forEach((ele) => {
                // console.log('name>>>', ele.Name);
                let tempData = Object.assign({}, ele);
                tempData.recordNameUrl = '/' + tempData.Id;
                orignalData.push(tempData);
            })
            this.data = orignalData;
        } else if (result.error) {
            this.error = result.error;
        }
    }

    handleSave(event) {
        this.saveDraftValues = event.detail.draftValues;
        //console.log('________saveDraftValues__________', JSON.stringify(this.saveDraftValues));
        const inputsItems = this.saveDraftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            //console.log('__________fields____________', JSON.stringify(fields));
            return { fields };
        });

        const promises = inputsItems.map(recordInput => updateRecord(recordInput));
        //console.log('________________promises____________________', JSON.stringify(promises));
        Promise.all(promises).then(res => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Records Updated Successfully!!',
                    variant: 'success'
                })
            );
            return refreshApex(this.mainresult);
        }).catch(error => {
            //console.log('______error________',JSON.stringify(error));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An Error Occured!!',
                    variant: 'error'
                })
            );
        }).finally(() => {
            this.saveDraftValues = [];
        });
    }
}