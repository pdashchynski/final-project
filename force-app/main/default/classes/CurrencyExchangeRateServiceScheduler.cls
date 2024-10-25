public without sharing class CurrencyExchangeRateServiceScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        CurrencyExchangeRateService.updateExchangeRates();
    }

    public static void schedule() {
        String cronExp = '0 0 0 * * ?';
        CurrencyExchangeRateServiceScheduler scheduler = new CurrencyExchangeRateServiceScheduler();
        System.schedule('Daily Currency Exchange Rate Update', cronExp, scheduler);
    }
}