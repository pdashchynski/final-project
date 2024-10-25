public without sharing class CurrencyExchangeRateService {
    private static final String API_URL = 'https://api.nbrb.by/exrates/rates?periodicity=0';

    @future(callout=true)
    public static void updateExchangeRates() {
        List<CurrencyData> rates = getExchangeRates();
        for (CurrencyData rate : rates) {
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(URL.getOrgDomainUrl().toExternalForm() + '/services/data/v62.0/sobjects/CurrencyType/' + rate.Id + '?_HttpMethod=PATCH');
            req.setBody('{ "ConversionRate" : ' + rate.rate + ' }');
            req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
            req.setHeader('Content-Type', 'application/json');
            req.setMethod('POST');
            //req.setTimeout(30);
            HttpResponse res = http.send(req);
        }
    }
    
    public static List<CurrencyData> getExchangeRates() {
        List<CurrencyData> currencyData = new List<CurrencyData>();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(API_URL);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<CurrencyType> activeCurrencies = CurrencyService.getActiveCurrencies();
            List<Object> exchangeRates = (List<Object>) JSON.deserializeUntyped(response.getBody());

            for (Object rate : exchangeRates) {
                Map<String, Object> rateMap = (Map<String, Object>) rate;
                for (CurrencyType cur : activeCurrencies) {
                    if (cur.IsoCode == rateMap.get('Cur_Abbreviation')) {
                        CurrencyData curD = new CurrencyData();
                        curD.Id = cur.Id;
                        curD.isoCode = cur.IsoCode;
                        if(cur.IsoCode == 'PLN') {
                            curD.rate = String.valueOf(10/ (Decimal) rateMap.get('Cur_OfficialRate'));    
                        } else {
                            curD.rate = String.valueOf(1/ (Decimal) rateMap.get('Cur_OfficialRate'));
                        }
                        currencyData.Add(curD);
                    }            
                }
            }
        } else {
            System.debug('Error: ' + response.getStatus());
        }
        System.debug(currencyData);
        return currencyData;
    }

    public class CurrencyData {
        @AuraEnabled public String Id;
        @AuraEnabled public String isoCode;
        @AuraEnabled public String rate;
    }
}