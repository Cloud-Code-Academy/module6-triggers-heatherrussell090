public with sharing class AccountTriggerHandler {
    public AccountTriggerHandler() {

    }

    public static void updateAccountType(List<Account> accounts) {
        for(Account acc : accounts) {
            if(acc.Type == null) {
                acc.Type = 'Prospect';
            }
        }      
    }

    public static void copyShippingAddressToBillingAddress(List<Account> accounts) {    //update to check if null
        for(Account acc : accounts) {     
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }
    }
}