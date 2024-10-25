import { LightningElement, api } from 'lwc';

import getAllCentres from '@salesforce/apex/CentreController.getAllCentres'
import CENTRE_OBJECT  from '@salesforce/schema/Centre__c';
import NAME_FIELD from '@salesforce/schema/Centre__c.Name';

export default class CentreInfo extends LightningElement {
    objectApiName = CENTRE_OBJECT;
    nameField = NAME_FIELD;
    centres;
    error;

    connectedCallback() {
        this.loadCentres();
    }
    loadCentres() {
        getAllCentres()
            .then(result => {
                 this.centres = result;
             })
             .catch(error => {
                 this.error = error;
             });
    }
}