public with sharing class CarDescriptionController {
    private CurrencyService currencyService = new CurrencyService();

    public List<CarData> cars { get; set; }
    public CarData selectedCar { get; set; }

    public CarDescriptionController() {
        List<CarData> cars = new List<CarData>();

        String currentCurrency = ApexPages.currentPage().getParameters().get('currency');
        String sku = ApexPages.currentPage().getParameters().get('sku');

        Product2 selectedCar = CarDescriptionManager.getCarBySku(sku);
        this.selectedCar = new CarData(selectedCar);

        String typeSku = ApexPages.currentPage().getParameters().get('sku').substringBefore('-');
        List<Product2> variations = CarDescriptionManager.getAllCarsByType(typeSku);

        for (Product2 variation : variations) {
            if(!variation.pricebookEntries.isEmpty()){
                PricebookEntry pbEntry = variation.PricebookEntries[0];
                CarData carData = new CarData(variation);
                Decimal price = currencyService.convert(pbEntry.UnitPrice, pbEntry.CurrencyIsoCode, currentCurrency);
                carData.price = String.ValueOf(price);
                carData.currencyCode = currentCurrency;
                carData.advancedMultSystem = variation.Advanced_Multimedia_System__c;
                cars.add(carData);
            }
        }
        this.cars = cars;
    }

    public class CarData {
        public String Id { get; set; }
        public String name { get; set; }
        public String description { get; set; }
        public String price { get; set; }
        public String currencyCode { get; set; }
        public Boolean advancedMultSystem { get; set; }

        public CarData (Product2 car){
            this.Id = car.Id;
            this.name = car.Name;
            this.description = car.Description;
            this.advancedMultSystem = car.Advanced_Multimedia_System__c;
        }
    }
}