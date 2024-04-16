trigger AccountTrigger on Account (before insert, before update, after insert, after update, after delete, after undelete) {

    if(Trigger.isBefore && Trigger.isInsert) {
        AccountTriggerHandler.updateAccountType(Trigger.new);
    }

    if(Trigger.isBefore && Trigger.isInsert) {
        AccountTriggerHandler.copyShippingAddressToBillingAddress(Trigger.new);
    }
}