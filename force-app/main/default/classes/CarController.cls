public with sharing class CarController {

    private static CurrencyManager currencyManager = new CurrencyManager();

    @AuraEnabled(cacheable=true)
    public static List<CarData> getProducts(String selectedCurrency) {
        try {
            selectedCurrency = String.isBlank(selectedCurrency) ?  UserInfo.getDefaultCurrency() : selectedCurrency;
            List<Product2> carProduct = [SELECT Id, Name, Description FROM Product2 WHERE IsActive = TRUE WITH SECURITY_ENFORCED];
            Map<String, PricebookEntry> productIdToPricebookEntryMap = getPricebookEntryMap();

            List<CarData> carDataList = new List<CarData>();
            for (Product2 car : carProduct) {
                if(productIdToPricebookEntryMap.containsKey(car.Id)) {
                    CarData carDataItem = new CarData();
                    carDataItem.Id = car.Id;
                    carDataItem.name = car.Name;
                    carDataItem.description = car.Description;
                    PricebookEntry pricebookEntry = productIdToPricebookEntryMap.get(car.Id);
                    Decimal price = currencyManager.convert(pricebookEntry.UnitPrice, pricebookEntry.CurrencyIsoCode, selectedCurrency);
                    carDataItem.price = String.ValueOf(price);
                    carDataItem.currencyCode = selectedCurrency;
                    carDataList.add(carDataItem);
                }
            }

            return carDataList;
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching products: ' + e.getMessage() + e.getStackTraceString());
        }
    }

    private static Map<String, PricebookEntry> getPricebookEntryMap() {
        List<PricebookEntry> pricebookEntries = [
            SELECT Id, Product2Id, UnitPrice, CurrencyIsoCode
            FROM PricebookEntry
            WHERE IsActive = TRUE AND Pricebook2.IsStandard = TRUE
        ];
        Map<String, PricebookEntry> productIdToPricebookEntryMap = new Map<String, PricebookEntry>();
        for (PricebookEntry pricebookEntry : pricebookEntries) {
            productIdToPricebookEntryMap.put(pricebookEntry.Product2Id, pricebookEntry);
        }

        return productIdToPricebookEntryMap;
    }

    public class CarData {
        @AuraEnabled public String name;
        @AuraEnabled public String Id;
        @AuraEnabled public String description;
        @AuraEnabled public String price;
        @AuraEnabled public String currencyCode;
    }
}