public class ProcessSynchronousStrategy implements ProcessingStrategy{
    
    Private Map<String,List<Contact>> contactsToProcess;
    
    public ProcessSynchronousStrategy (Map<String,List<Contact>> contactsToProcess){
        this.contactsToProcess = contactsToProcess;
    }
    
    public void process(){
        System.debug('Synchronous processing of contacts');
        System.debug(this.contactsToProcess);
    }
}