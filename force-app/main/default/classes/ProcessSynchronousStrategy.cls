public class ProcessSynchronousStrategy implements ProcessingStrategy{
    
    Private Map<String,List<Contact>> contactsToProcess;
    
    public ProcessSynchronousStrategy (Map<String,List<Contact>> contactsToProcess){
        this.contactsToProcess = contactsToProcess;
    }
    
    public void process(){
        System.debug('Synchronous processing of contacts');
        System.debug(this.contactsToProcess);
        List<Contact> contactsToUpdate = new List<Contact>();
        
        if(contactsToProcess.get('Yes')?.size() > 0){
            System.debug('Yes being processed');
            for(Contact contactYes: contactsToProcess.get('Yes')){
                contactYes.Push_Date__c = Date.today();
                contactsToUpdate.add(contactYes);
            }
        }
        
        if(contactsToProcess.get('No')?.size() > 0){
            System.debug('No being processed');
            for(Contact contactNo: contactsToProcess.get('No')){
                contactNo.Push_Date__c = null;
                contactsToUpdate.add(contactNo);
            }
        }
        
        try {
            update contactsToUpdate;
        } catch(DmlException  e){
            System.debug(e.getMessage());
        }
    }
}