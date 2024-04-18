trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update, after delete, after undelete) {

    if(Trigger.isBefore && Trigger.isUpdate) {
        OpportunityTriggerHandler.validateOppAmount(Trigger.new);
    }

    if(Trigger.isAfter && Trigger.isDelete) {
        OpportunityTriggerHandler.deleteCloseWonOpp(Trigger.old);
    }

    if(Trigger.isBefore && Trigger.isUpdate) {
        OpportunityTriggerHandler.setPrimaryContact(Trigger.new);
    }

}