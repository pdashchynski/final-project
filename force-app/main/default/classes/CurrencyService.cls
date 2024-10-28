public with sharing class CurrencyService {

    public Decimal convert(Decimal value, String fromIso, String toIso) {
        if (String.isEmpty(fromIso) || String.isEmpty(toIso)) {
            return value;
        }

        Map<String,CurrencyType> conversions = new Map<String,CurrencyType>();
        String corporateIso = '';

        for (CurrencyType cur : [
            SELECT Id, IsCorporate, IsoCode, ConversionRate, DecimalPlaces 
            FROM CurrencyType 
            WHERE IsActive = true
        ]){
            conversions.put(cur.IsoCode, cur);
            if (cur.IsCorporate) {corporateIso = cur.IsoCode;}
        }

        if (fromIso.equalsIgnoreCase(toIso)) {
            return value.setScale(
                conversions.get(fromIso.toUpperCase()).DecimalPlaces, 
                System.RoundingMode.HALF_UP
            );
        }

        CurrencyType fromCur = conversions.get(fromIso.toUpperCase());
        Decimal fromRate = fromCur.ConversionRate;
        CurrencyType toCur = conversions.get(toIso.toUpperCase());
        Decimal toRate = toCur.ConversionRate;
        Decimal rate = toRate/fromRate;

       
        Decimal result = value * rate;
        Decimal resultRounded = result.setScale(toCur.DecimalPlaces, System.RoundingMode.HALF_UP);

        return resultRounded;
    }
}