public with sharing class CarController {

    private static CurrencyService currencyService = new CurrencyService();

    @AuraEnabled(cacheable=true)
    public static List<CarData> getProducts(String selectedCurrency) {
        try {
            selectedCurrency = String.isBlank(selectedCurrency) ?  UserInfo.getDefaultCurrency() : selectedCurrency;
            List<Product2> carList = CarManager.getAllCars();
            Map<String, PricebookEntry> productIdToPricebookEntryMap = getPricebookEntryMap();

            List<CarData> carDataList = new List<CarData>();
            for (Product2 car : carList) {
                if(productIdToPricebookEntryMap.containsKey(car.Id)) {
                    CarData carDataItem = new CarData();
                    carDataItem.Id = car.Id;
                    carDataItem.name = car.Name;
                    carDataItem.description = car.Description;
                    carDataItem.sku = car.StockKeepingUnit;
                    PricebookEntry pricebookEntry = productIdToPricebookEntryMap.get(car.Id);
                    Decimal price = currencyService.convert(pricebookEntry.UnitPrice, pricebookEntry.CurrencyIsoCode, selectedCurrency);
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
        List<PricebookEntry> pricebookEntries = CarManager.getPricebookEntries();
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
        @AuraEnabled public String sku;
    }
}