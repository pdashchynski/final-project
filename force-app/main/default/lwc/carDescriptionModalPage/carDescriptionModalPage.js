import { api } from "lwc";
import LightningModal from "lightning/modal";
import CloseLabel from '@salesforce/label/c.Close';

export default class CarDescriptionModalPage extends LightningModal {
  @api product;
  @api isOpen;

  label = {
    CloseLabel
  };

  closeModal() {
      this.isOpen = false;
      this.dispatchEvent(new CustomEvent('close'));
  }

  handleDownload() {
    window.open('/apex/carDescriptionVFPage', '_blank');
  }    
}