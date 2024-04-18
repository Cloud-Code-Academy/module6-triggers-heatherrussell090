public with sharing class OpportunityTriggerHandler {
    public OpportunityTriggerHandler() {

    }
    //Method for validating opp amount 
    public static void validateOppAmount(List<Opportunity> opportunities) {
        for(Opportunity opp : opportunities) {
            if(opp.Amount <= 5000) {
                opp.addError('Opportunity amount must be greater than 5000');
            } 
        }
    }

    //Method for prevention of deletion of Close Won opp
    public static void deleteCloseWonOpp(List<Opportunity> opportunities) {
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : opportunities) {
            accountIds.add(opp.AccountId);
        }
    
        Map<Id, Account> accountsMap = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN :accountIds]);
    
        for(Opportunity opp : opportunities) {
            if(opp.StageName == 'Closed Won' && accountsMap.get(opp.AccountId).Industry == 'Banking') {
                opp.addError('Cannot delete closed opportunity for a banking account that is won');
            }
        }
    }

    //Method to set the primary contact
    public static void setPrimaryContact(List<Opportunity> opportunities) {
        Set<Id> accountIds = new Set<Id>();

        for(Opportunity opp : opportunities) {
            accountIds.add(opp.AccountId);
        }

        Map<Id, Contact> ceoContactsByAccount = new Map<Id, Contact>(); 
            for(Contact con : [SELECT Id, AccountId FROM Contact WHERE AccountId In :accountIds AND Title = 'CEO']) {
                ceoContactsByAccount.put(con.AccountId, con);
            }
        

        for(Opportunity opp : opportunities) {
            if(ceoContactsByAccount.containsKey(opp.AccountId)) {
                opp.Primary_Contact__c = ceoContactsByAccount.get(opp.AccountId).Id;
            }
        }
    }
}