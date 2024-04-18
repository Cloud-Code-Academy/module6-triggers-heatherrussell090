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

    public static void copyShippingAddressToBillingAddress(List<Account> accounts) {    
        for(Account acc : accounts) {     
                acc.BillingStreet = acc.ShippingStreet;
                acc.BillingCity = acc.ShippingCity;
                acc.BillingState = acc.ShippingState;
                acc.BillingPostalCode = acc.ShippingPostalCode;
                acc.BillingCountry = acc.ShippingCountry;
            }
    }

    public static void setAccountRating(List<Account> accounts) {
        for(Account newAccount : accounts) {
            if(String.isNotBlank(newAccount.Phone) && String.isNotBlank(newAccount.Website) && String.isNotBlank(newAccount.Fax))
                newAccount.Rating = 'Hot';
            } 
    }

    public static void createContactRelatedToAccount(List<Account> accounts) {
        List<Contact> contactsToInsert = new List<Contact>();
        for(Account newAccount : accounts) {
            Contact newContact = new Contact();
            newContact.LastName = 'DefaultContact';
            newContact.Email = 'default@email.com';
            newContact.AccountId = newAccount.Id;
            contactsToInsert.add(newContact);
        }

        Database.DMLOptions dmlOptions = new DataBase.DMLOptions();
        dmlOptions.DuplicateRuleHeader.AllowSave = true;
        dmlOptions.DuplicateRuleHeader.RunAsCurrentUser = false;

        Database.insert(contactsToInsert, dmlOptions);
    }
}