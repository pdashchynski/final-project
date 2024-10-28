import { api } from "lwc";
import LightningModal from "lightning/modal";
import CloseLabel from '@salesforce/label/c.Close';
import PriceLabel from '@salesforce/label/c.Price';

export default class CarDescriptionModalPage extends LightningModal {
  @api product;
  @api isOpen;
  @api selectedCurrency;

  label = {
    CloseLabel,
    PriceLabel
  };

  closeModal() {
    this.isOpen = false;
    this.dispatchEvent(new CustomEvent('close'));
  }
}