import { LightningElement, wire } from 'lwc';
import getActiveCurrencies from '@salesforce/apex/CurrencyService.getActiveCurrencies';
import getUserCurrency from '@salesforce/apex/CurrencyService.getUserCurrency';

export default class CurrencySelector extends LightningElement {
    selectedCurrency;
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
        const currencyChangeEvent = new CustomEvent('currencychange', {
            detail: { currency: this.selectedCurrency }
        });
        this.dispatchEvent(currencyChangeEvent);
    }

    @wire(getUserCurrency)
    wiredUserCurrency({ error, data }) {
      if (data) {
        this.selectedCurrency = data;
      } else if (error) {
        console.error('Error fetching user currency:', error);
      }
    }
}