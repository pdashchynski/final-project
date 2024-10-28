public with sharing class CarDescriptionManager {

    public static Product2 getCarBySku(String sku) {
        Product2 selectedCar = [
            SELECT Id, Name, Description, StockKeepingUnit, Advanced_Multimedia_System__c,
            (SELECT Id, Pricebook2Id, UnitPrice, IsActive FROM PricebookEntries WHERE Pricebook2.IsStandard = true)
            FROM Product2
            WHERE StockKeepingUnit = :sku
        ];

        return selectedCar;
    }

    public static List<Product2> getAllCarsByType(String typeSku) {
        List<Product2> carsList = [
            SELECT Id, Name, Description, StockKeepingUnit, Advanced_Multimedia_System__c,
            (SELECT Id, Pricebook2Id, UnitPrice, IsActive FROM PricebookEntries WHERE Pricebook2.IsStandard = true)
            FROM Product2
            WHERE StockKeepingUnit LIKE :typeSku + '%'
        ];

        return carsList;
    }
}