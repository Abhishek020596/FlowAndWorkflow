import { LightningElement } from 'lwc';
import fetchingPincodeValue from '@salesforce/apex/PostalPincodeHandler.fetchingPincodeValue';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'District', fieldName: 'District' },
    { label: 'State', fieldName: 'State' },
    { label: 'Country', fieldName: 'Country' },
    { label: 'Pincode', fieldName: 'Pincode' },
];
export default class FetchingPostalPinCodeData extends LightningElement {
    pincode;
    data = [];
    columns = columns;
    pincodeData = [];
    
    handleInputChange(event){
        this.pincode = event.target.value;
        console.log('______________________',this.pincode);
    }
    handleSearch(){
        // console.log('-----------------', Number.IsNumeric(this.pincode) );
        // if(par this.pincode){
        //     this.pincode = 'pincode/' + this.pincode;
        //     console.log('If_________________' ,this.pincode);
        // }else{
        //     //this.pincode = 'PostOffice/' + this.pincode;
        //     this.pincode = 'pincode/' + this.pincode;
        //     console.log('else_________________' ,this.pincode);
        // }
        fetchingPincodeValue({pincode :this.pincode})
        .then((result) =>{
            this.data = result;
            this.data.forEach(element =>{
                this.pincodeData = element.PostOffice;
                console.log('pincodeData______________________' ,this.pincodeData);
            })
        }).catch((error) =>{
            console.log('___________error_______________',error);
        })
    }
}