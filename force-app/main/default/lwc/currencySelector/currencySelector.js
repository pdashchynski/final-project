import { LightningElement, wire } from 'lwc';
import getActiveCurrencies from '@salesforce/apex/CurrencyManager.getActiveCurrencies';
import CURRENCY from "@salesforce/i18n/currency";

export default class CurrencySelector extends LightningElement {
    selectedCurrency = CURRENCY;
    currencyOptions = [];

    @wire(getActiveCurrencies)
    wiredCurrencies({ error, data }) {
        if(data) {
            this.currencyOptions = data.map(currency => {
                return { label: currency.IsoCode, value: currency.IsoCode};
            });
        } else if(error) {
            console.error('Error fetching currencies:', error);
        }
    }

    handleCurrencyChange(event) {
        this.selectedCurrency = event.detail.value;
        this.dispatchEvent(new CustomEvent('currencychange', {
            detail: { currency: this.selectedCurrency }
        }));
    }
}