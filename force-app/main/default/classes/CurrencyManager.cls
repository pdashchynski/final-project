public with sharing class CurrencyManager {

    @AuraEnabled(cacheable=true)
    public static List<CurrencyType> getActiveCurrencies() {
        return [SELECT Id, IsoCode, ConversionRate, IsActive FROM CurrencyType WHERE IsActive = true];
    }
}