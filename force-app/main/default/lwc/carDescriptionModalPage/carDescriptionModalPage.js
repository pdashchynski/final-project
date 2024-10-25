import { api } from "lwc";
import LightningModal from "lightning/modal";
import CloseLabel from '@salesforce/label/c.Close';

export default class CarDescriptionModalPage extends LightningModal {
  @api product; // Product data passed from parent
  @api isOpen = false; // Control modal visibility

  label = {
    CloseLabel
  };

  closeModal() {
      this.isOpen = false;
      const closeEvent = new CustomEvent('close');
      this.dispatchEvent(closeEvent);
  }
}