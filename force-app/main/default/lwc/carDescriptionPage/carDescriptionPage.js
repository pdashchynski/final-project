import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getProducts from '@salesforce/apex/CarController.getProducts';
import PriceLabel from '@salesforce/label/c.Price';
import CAR_COUPE_IMAGE from '@salesforce/resourceUrl/Car_Coupe';
import CAR_WAGON_IMAGE from '@salesforce/resourceUrl/Car_Wagon';
import CURRENCY from "@salesforce/i18n/currency";

export default class CarDescriptionPage extends LightningElement {
    label = {
        PriceLabel
    };
    products;
    error;
    isModalOpen;
    selectedProduct;
    selectedCurrency = CURRENCY;
    carCoupeImage = CAR_COUPE_IMAGE;
    carWagonImage = CAR_WAGON_IMAGE;

    @wire(getProducts, {selectedCurrency: '$selectedCurrency'})
    wiredProducts({ error, data }) {
        if (data) {
            this.products = data;
            this.error = null;
        } else if (error) {
            this.error = error.body.message;
            this.products = null;
        }
    }

    handleProductSelect(event) {
        const productId = event.currentTarget.dataset.id;
        this.selectedProduct = this.products.find(product => product.Id === productId);
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
        this.selectedProduct = null;
    }
        
    handleCurrencyChange(event) {
        this.selectedCurrency = event.detail.currency;
        refreshApex(this.products);
    }
}