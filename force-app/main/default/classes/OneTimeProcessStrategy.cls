public class OneTimeProcessStrategy implements ProcessingStrategy{
	Private Map<String,List<Contact>> contactsToProcess;
    
    public OneTimeProcessStrategy (Map<String,List<Contact>> contactsToProcess){
        this.contactsToProcess = contactsToProcess;
    }
    
    public void process(){
        System.debug('One Time processing of contacts');
        System.debug(this.contactsToProcess);
    }
}