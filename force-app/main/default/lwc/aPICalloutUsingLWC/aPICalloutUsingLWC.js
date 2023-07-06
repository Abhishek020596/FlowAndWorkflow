import { LightningElement, wire } from 'lwc';
import fetchingProducts from '@salesforce/apex/ProductsApiHandler.fetchingProducts';

export default class APICalloutUsingLWC extends LightningElement {

    //listValues=[];
    error;
    fieldValue;
    isShowModal = false;
    isCartModal = false;
    recordDetails;
    productRecords;
    imagesList;

    @wire(fetchingProducts)
    fetchingCalloutData({ error, data }) {
        if (data) {
            this.productRecords = data.map(res => {
                return { id: res.id, title: res.title, rating:res.rating, stock:res.stock, images: res.images[0], price:res.price, imageset:res.images};
            });
            console.log('______________ListValues______________', JSON.stringify(this.productRecords));
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.productRecords = undefined;
        }
    }
    handleDetails(event){
        for (let i = 0; i < this.productRecords.length; i++) {
            if(this.productRecords[i].id == event.currentTarget.dataset.id){
                this.recordDetails = this.productRecords[i];
                let count = 1;
                this.imagesList = this.recordDetails.imageset.map(res => {
                    return {id: count++, img: res };
                });
                console.log("elements_____________________", JSON.stringify(this.imagesList));
                break;
            }
        }
        this.isShowModal = true;
    }
    hideModalBox(){
        this.isShowModal = false;
        this.isCartModal = false;
    }
}