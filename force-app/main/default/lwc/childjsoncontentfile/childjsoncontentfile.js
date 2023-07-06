import { api, LightningElement} from 'lwc';

export default class Childjsoncontentfile extends LightningElement {
    
    @api fieldName;
    @api fieldType ;
    @api jsonValue ;
    value;
    options;

    connectedCallback(){
        this.options = this.jsonValue.ConcessionAuthory;
        console.log("option====================== ", JSON.stringify(this.options));
    }

    handleOptionValue(event){  
        this.value = event.target.value;
        const selectedEvent = new CustomEvent("jsonoptionvalue", {
            detail: this.value
          });
       
          // Dispatches the event.
          this.dispatchEvent(selectedEvent);
    }

  
    get isString(){
        return this.fieldType==='text' ? true:false;
    }
    get isPickList(){
        return this.fieldType=== 'picklist'?true:false;
      
    }
    
}