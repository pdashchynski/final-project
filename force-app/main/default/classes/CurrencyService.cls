public with sharing class CurrencyService {

    @AuraEnabled(cacheable=true)
    public static List<CurrencyType> getActiveCurrencies() {
        return [SELECT Id, IsoCode, ConversionRate, IsActive FROM CurrencyType WHERE IsActive = true];
    }

    @AuraEnabled(cacheable=true)
    public static String getUserCurrency() {
        return UserInfo.getDefaultCurrency();
    }
}