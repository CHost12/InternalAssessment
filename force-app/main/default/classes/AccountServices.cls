public class AccountServices {
    public static void processChildContacsOfAccountWithVendorYesOrNo(Map<String, List<Id>> AccountsToProcessTheirContacts) {
        Set<Id> yesAccountsIds;
		Set<Id> noAccountsIds;
        Integer totalContactQuantity = 0;
        
        List<Contact> yesContacts;
        List<Contact> noContacts;
        
        Set<Id> yesContactIds;
        Set<Id> noContactIds;
        
        // Yes
        if(AccountsToProcessTheirContacts.get('Yes')?.size() > 0){
            yesAccountsIds = new Set<Id>();
            yesAccountsIds.addall(AccountsToProcessTheirContacts.get('Yes'));
        }
        
        // No
        if(AccountsToProcessTheirContacts.get('No')?.size() > 0){
            noAccountsIds = new Set<Id>();
            noAccountsIds.addall(AccountsToProcessTheirContacts.get('No'));
        }
        
        if(yesAccountsIds?.size() > 0){
            yesContacts = new List<Contact>();
            yesContactIds= new Set<Id>();
            
            for (Contact contactYes : [SELECT ID FROM Contact WHERE Account.id IN :yesAccountsIds]){
                yesContacts.add(contactYes);
                yesContactIds.add(contactYes.id);
            }
            totalContactQuantity += yesContacts.size();
        }
        
        if(noAccountsIds?.size() > 0){
            noContacts= new List<Contact>();
            noContactIds= new Set<Id>();
            
            for (Contact contactNo : [SELECT ID FROM Contact WHERE Account.id IN :noAccountsIds]) {
                noContacts.add(contactNo);
 				noContactIds.add(contactNo.id);                
            }
            totalContactQuantity += noContacts.size();
            
        }
        
        List<Contact> contactsToSeeAllTogether = New List<Contact>();
		contactsToSeeAllTogether.addAll(yesContacts);
        contactsToSeeAllTogether.addAll(noContacts);
        
		// Pass yes and no contact with the quantity to the correct strategy depending on contact quantity 
		//
		
        // A factory could be implemented to dynamically get strategies
        // TODO : Only pass a list of contacts Ids
        // 
        if(totalContactQuantity < 200){
            System.debug('Synchronous Strategy');
            Map<String, List<Contact>> contactMap = new Map<String, List<Contact>>();
            contactMap.put('Yes', yesContacts);
            contactMap.put('No', noContacts);
                
            ProcessingStrategy strategy = new ProcessSynchronousStrategy(contactMap);
            strategy.process();
            // Process Synchronous
            // pass a Map with this structure
            // {
            // 'Yes' : List<Contacts>,
            // 'No' : List<Contacts>
            // }
            
        }
        
        if(totalContactQuantity >= 200 && totalContactQuantity < 1000){
            System.debug('One time process Strategy');
            Map<String, List<Contact>> contactMap = new Map<String, List<Contact>>();
            contactMap.put('Yes', yesContacts);
            contactMap.put('No', noContacts);
                
            ProcessingStrategy strategy = new OneTimeProcessStrategy(contactMap);
            // Process in a asynchronous in a one time process
            // pass a Map with this structure
            // {
            // 'Yes' : List<Contacts>,
            // 'No' : List<Contacts>
            // }
        }	
        
        if(totalContactQuantity >= 1000){
            System.debug('Batcheable Strategy');
            Map<String, Set<Id>> contactMap = new Map<String, Set<Id>>();
            contactMap.put('Yes', yesContactIds);
            contactMap.put('No', noContactIds);
            
            ProcessingStrategy strategy = new ProcessInBatchStrategy(contactMap);
            // Process in batchs of 150 records
            // pass a Map with this structure
            // {
            // 'Yes' : List<Contacts>,
            // 'No' : List<Contacts>
            // }
            
        }	
        
    }
    
}