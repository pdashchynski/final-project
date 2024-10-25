import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getProducts from '@salesforce/apex/CarController.getProducts';
import CloseLabel from '@salesforce/label/c.Close';

export default class CarDescriptionPage extends LightningElement {
    label = {
        CloseLabel
    };
    products;
    error;
    isModalOpen = false;
    selectedProduct;
    selectedCurrency;

    connectedCallback() {
          getProducts({selectedCurrency: ''})
         .then(data=>{
             this.products = data;
         })
         .catch(error=>{
             this.error = error.body.message;
         });
    }

    @wire(getProducts, {selectedCurrency: '$selectedCurrency'})
    wiredProducts({ error, data }) {
        if (data) {
            this.products = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.products = undefined;
        }
    }

    handleProductSelect(event) {
        const productId = event.currentTarget.dataset.id;
        console.log(event.currentTarget.dataset.id);
        this.selectedProduct = this.products.find(product => product.Id === productId);
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
        this.selectedProduct = {};
    }
        
    handleCurrencyChange(event) {
        this.selectedCurrency = event.detail.currency;
        refreshApex(this.products);
    }
}