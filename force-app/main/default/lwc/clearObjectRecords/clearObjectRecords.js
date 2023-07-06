import { LightningElement, api, track, wire } from 'lwc';
import retrieveAllObject from '@salesforce/apex/ClearObjectRecordsHandler.retrieveAllObject';
import retrieveObjectRecords from '@salesforce/apex/ClearObjectRecordsHandler.retrieveObjectRecords';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { subscribe, unsubscribe } from 'lightning/empApi';

export default class ClearObjectRecords extends LightningElement {
    ApexApiName;
    ApexStatus;
    ApexJobId;
    ApexTotalJobItems;
    ApexJobItemsProcessed;
    @track batchRecord;
    @track searchKey;
    error;
    objectValue;
    selectedItems;
    selectedRecord = [];
    showRecord = 20;
    allRecord = [];
    pillValues = [];
    isShowModal = false;
    IsAsyncRecordShow = false;
    subscription = {};
    @api channelName = '/event/Batch_Event__e';

    connectedCallback() {
        this.handleSubscribe();
    }

    handleClick() {
        this.isShowModal = true;
    }
    closeModal() {
        this.isShowModal = false;
        this.selectedItems = null;
    }

    @wire(retrieveAllObject)
    wiredFetchObject({ data, error }) {
        if (data) {
            console.log("__________data___________ ", data);
            this.allRecord = data;
            console.log("_________allrecord__________ ", this.allRecord);
        }
        else if (error) {
            console.log("__________error__________ ", error);
            this.error = error;
        }
    }

    handleKeyChange(event) {
        this.searchKey = event.target.value;
        // console.log('_____________this.searchKey______________', this.searchKey);   
        this.selectedItems = [];
        this.allRecord.forEach(element => {
            if (element.includes(this.searchKey)) {
                this.selectedItems.push(element);
                // console.log('____________AfterPush_selectedItems_______________', JSON.stringify(this.selectedItems));
            }
        });
        this.selectedRecord = this.selectedItems.slice(0, this.showRecord);
        // console.log('_____________this.selectedItems_____________', JSON.stringify(this.selectedItems));
    }

    handleSelectedObject(event) {
        this.objectValue = event.target.value
        console.log("_______________objectValue____________ ", this.objectValue);
        if (!this.pillValues.includes(this.objectValue)) {
            this.pillValues.push(this.objectValue);
        }
        console.log("__________objectId__________ ", JSON.stringify(this.pillValues));
    }

    removePillItem(event) {
        const pillIndex = event.detail.index ? event.detail.index : event.detail.name;
        const itempill = this.pillValues; 
        itempill.splice(pillIndex, 1);       
        this.pillValues = [...itempill];
        console.log(pillIndex, this.pillValues);
    }

    handleClearStorage(){
        this.isShowModal = false;
        this.IsAsyncRecordShow = true;
        retrieveObjectRecords({objName : this.pillValues})
        .then(result=>{
            console.log("__________result__________ ", result);
            const evt = new ShowToastEvent({
                title: 'Started',
                message: 'Job Started Successfully',
                variant: 'Success',
                mode: 'dismissible'
            });
            this.dispatchEvent(evt);
            this.pillValues = [];
        })
        .catch(error=>{
            console.log("__________error__________ ", error);
        })
    }

    handleSubscribe() {
        const self = this;
        // Callback invoked whenever a new event message is received
        // Invoke subscribe method of empApi. Pass reference to messageCallback
        const messageCallback = function (response) {
            // console.log('New message received 1: ', JSON.stringify(response));
            console.log('New message received 2: ', response);
            var obj = JSON.parse(JSON.stringify(response));
            // console.log("+++obj+++", obj.data.payload);
    
            this.batchRecord = obj.data.payload;
            console.log("++++completebatchrecord++++ ", this.batchRecord);
    
        };
        subscribe(this.channelName, -1, messageCallback).then(response => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
            console.log("+++++++subs++++++++ ",JSON.stringify(this.subscription));
        });
    }

    
}