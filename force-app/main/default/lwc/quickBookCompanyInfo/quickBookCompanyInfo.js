import { LightningElement, wire} from 'lwc';
import getCompanyInfo from '@salesforce/apex/QBCallout.getCompanyInfo';
export default class QuickBookCompanyInfo extends LightningElement {

   companyDetails;
   companyError;

    @wire(getCompanyInfo)
    info({data, error}){
        if(data){
            console.log('Data=======================',JSON.stringify(data));
            this.companyDetails = data;
            this.companyError = undefined
            console.log('cusDetails==================',this.cusDetails);
        }else{
            this.companyError = error;
            this.companyDetails = undefined
        }
    }     
}