import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CASE_OBJECT  from '@salesforce/schema/Case';
import STATUS_FIELD from '@salesforce/schema/Case.Status';
import ORIGIN_FIELD from '@salesforce/schema/Case.Origin';
import CONTACT_NAME from '@salesforce/schema/Case.ContactId';

export default class CaseCreator extends LightningElement {
    objectApiName = CASE_OBJECT;
    fields = [STATUS_FIELD, ORIGIN_FIELD, CONTACT_NAME];
    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: "Case created",
            message: "We will contact you soon!",
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }
}