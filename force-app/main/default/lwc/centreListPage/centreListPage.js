import { LightningElement, wire } from 'lwc';
import getAllCentres from '@salesforce/apex/CentreController.getAllCentres';

export default class CentreListPage extends LightningElement {
    centres;
    error;

    @wire(getAllCentres)
    wiredCentres({ error, data }) {
        if (data) {
            this.centres = data;
            this.error = null;
        } else if (error) {
            this.error = error.body.message;
            this.centres = null;
        }
    }
}