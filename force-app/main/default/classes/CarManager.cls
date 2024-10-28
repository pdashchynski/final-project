public with sharing class CarManager {
    
    public static List<Product2> getAllCars() {
        List<Product2> carList = [SELECT Id, Name, Description, StockKeepingUnit FROM Product2 WHERE IsActive = TRUE WITH SECURITY_ENFORCED];

        return carList;
    }

    public static List<PricebookEntry> getPricebookEntries() {
        List<PricebookEntry> pricebookEntries = [
            SELECT Id, Product2Id, UnitPrice, CurrencyIsoCode
            FROM PricebookEntry
            WHERE IsActive = TRUE AND Pricebook2.IsStandard = TRUE
        ];

        return pricebookEntries;
    }
}