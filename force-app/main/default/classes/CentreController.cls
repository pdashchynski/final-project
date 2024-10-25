public with sharing class CentreController {
    @AuraEnabled(cacheable=true)
    public static Centre__c[] getAllCentres(){
        return [SELECT Id, Name, Location__Latitude__s, Location__Longitude__s
                FROM Centre__c
                WITH SECURITY_ENFORCED
                ORDER BY Name
                LIMIT 50];
    }
}