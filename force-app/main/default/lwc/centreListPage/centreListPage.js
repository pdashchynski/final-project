import { LightningElement, wire } from 'lwc';
import getAllCentres from '@salesforce/apex/CentreController.getAllCentres';

export default class CentreListPage extends LightningElement {
    centres;
    error;

    connectedCallback() {
        getAllCentres()
         .then(data=>{
             this.centres = data;
         })
         .catch(error=>{
             this.error = error.body.message;
         });
    }

    @wire(getAllCentres)
    wiredCentres({ error, data }) {
        if (data) {
            this.centres = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.centres = undefined;
        }
    }
}