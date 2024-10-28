import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class CarPdfNavigation extends NavigationMixin(LightningElement) {
    @api selectedCurrency;
    @api sku;

    handleNavigation() {
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://wise-badger-42grcg-dev-ed--c.trailblaze.vf.force.com/apex/carDescriptionVFPage' + '?currency=' + this.selectedCurrency + '&sku=' + this.sku
            }
        }).then((url) => {
            window.open(url, '_blank');
        });
    }
}