trigger AccountTrigger on Account (before insert, before update, after insert, after update, after delete, after undelete) {

    if(Trigger.isBefore && Trigger.isInsert) {
        AccountTriggerHandler.updateAccountType(Trigger.new);
        AccountTriggerHandler.copyShippingAddressToBillingAddress(Trigger.new);
        AccountTriggerHandler.setAccountRating(Trigger.new);
    }

    if(Trigger.isAfter && Trigger.IsInsert) {
        AccountTriggerHandler.createContactRelatedToAccount(Trigger.New);
    }

    
}