import { LightningElement } from 'lwc';
import createCase from '@salesforce/apex/CaseController.createCase';

export default class CaseCreator extends LightningElement {
    caseSubject ;
    caseDescription;
    casePriority;
    caseEmail;
    caseUserName;
    successMessage;
    errorMessage;

    priorityOptions = [
        { label: 'Low', value: 'Low' },
        { label: 'Medium', value: 'Medium' },
        { label: 'High', value: 'High' }
    ];

    handleSubjectChange(event) {
        this.caseSubject = event.target.value;
    }

    handleDescriptionChange(event) {
        this.caseDescription = event.target.value;
    }

    handlePriorityChange(event) {
        this.casePriority = event.target.value;
    }

    handleEmailChange(event) {
        this.caseEmail = event.target.value;
    }

    handleUserNameChange(event) {
        this.caseUserName = event.target.value;
    }

    handleSubmit() {
        createCase({ subject: this.caseSubject, description: this.caseDescription, priority: this.casePriority, email: this.caseEmail, userName: this.caseUserName })
            .then(() => {
                this.successMessage = 'Our team will contact you soon!';
                this.errorMessage = '';
                this.caseSubject = '';
                this.caseDescription = '';
                this.casePriority = '';
                this.caseEmail = '';
                this.caseUserName = '';
            })
            .catch(error => {
                this.errorMessage = 'Error creating case: ' + error.body.message;
                this.successMessage = '';
            });
    }
}