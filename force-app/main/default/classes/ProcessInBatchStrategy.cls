public class ProcessInBatchStrategy implements ProcessingStrategy{

    Private Map<String,Set<Id>> contactsToProcess;
    
    public ProcessInBatchStrategy (Map<String,Set<Id>> contactsToProcess){
        this.contactsToProcess = contactsToProcess;
    }
    
    public void process(){
        System.debug('Batch processing of contacts');
        System.debug(this.contactsToProcess);
        Set<Id> contactsYesIds = new Set<Id>();
        Set<Id> contactsNoIds = new Set<Id>();
        
        contactsYesIds.addAll(contactsToProcess.get('Yes'));
        contactsNoIds.addAll(contactsToProcess.get('No'));
        
        if(contactsYesIds.size() > 0){
            System.debug('contacts in set with yes');
              // Yes ones
        	// String q1 = 'SELECT Id, Push_Date__c FROM Contact WHERE Id IN :contactsYesIds';
            String q1 = 'SELECT Id, Push_Date__c FROM Contact WHERE Id IN :XXXX';
            q1.replace('XXXX',contactsYesIds);
			String e2 = 'Account';
			String f3 = 'Push_Date__c';
			Date v4 = Date.today();
            // TODO: Change names
			Id batchInstanceId1 = Database.executeBatch(new ContactDateUpdateBatch(q1,e2,f3,v4), 150);
        }
        
        if(contactsNoIds.size() > 0){
              System.debug('contacts in set with No');
            // No ones
        	// String q = 'SELECT Id, Push_Date__c FROM Contact WHERE Id IN :contactsNoIds';
            String q = 'SELECT Id, Push_Date__c FROM Contact WHERE Id IN :XXXX';
            q.replace('XXXX',contactsNoIds);
			String e = 'Account';
			String f = 'Push_Date__c';
			Date v;
             Id batchInstanceId2 = Database.executeBatch(new ContactDateUpdateBatch(q,e,f,v), 150);
        }
    }
}