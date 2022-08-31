public class AccountServices {
    public static void processChildContacsOfAccountWithVendorYesOrNo(Map<String, List<Id>> AccountsToProcessTheirContacts) {
        Set<Id> yesAccountsIds;
		Set<Id> noAccountsIds;
        Integer totalContactQuantity = 0;
        
        List<Contact> yesContacts;
        List<Contact> noContacts;
        
        // Yes
        if(AccountsToProcessTheirContacts.get('Yes')?.size() > 0){
            yesAccountsIds = new Set<Id>();
            yesAccountsIds.addall(AccountsToProcessTheirContacts.get('Yes'));
            System.debug('Yes added');
            System.debug(yesAccountsIds);
        }
        
        // No
        if(AccountsToProcessTheirContacts.get('No')?.size() > 0){
            noAccountsIds = new Set<Id>();
            noAccountsIds.addall(AccountsToProcessTheirContacts.get('No'));
            System.debug('No added');
            System.debug(noAccountsIds);
        }
        
        if(yesAccountsIds?.size() > 0){
            yesContacts = new List<Contact>();
            
            for (Contact contactYes : [SELECT ID, NAME, Account.id FROM Contact WHERE Account.id IN :yesAccountsIds]){
                contactYes.Push_Date__c = Date.today();
                yesContacts.add(contactYes);
                System.debug('Yes??');
                System.debug(contactYes);
            }
            totalContactQuantity += yesContacts.size();
        }
        
        if(noAccountsIds?.size() > 0){
            noContacts= new List<Contact>();
            
            for (Contact contactNo : [SELECT ID, NAME, Account.id FROM Contact WHERE Account.id IN :noAccountsIds]) {
                contactNo.Push_Date__c = null;
                noContacts.add(contactNo);
                System.debug('No??');
                System.debug(contactNo);
            }
            totalContactQuantity += noContacts.size();
            
        }
        System.debug('Total contacts');
        System.debug(totalContactQuantity);
        System.debug('Contacts to be passed to the strategy');
        List<Contact> contactsToSeeAllTogether = New List<Contact>();
		contactsToSeeAllTogether.addAll(yesContacts);
        contactsToSeeAllTogether.addAll(noContacts);
        System.debug('Size when all merged into a list');
        System.debug(contactsToSeeAllTogether.size());

		// Pass yes and no contact with the quantity to the correct strategy depending on contact quantity 
		//

        if(totalContactQuantity < 200){
            System.debug('Synchronous Strategy');
            // Process normally
        }
        
        if(totalContactQuantity >= 200 && totalContactQuantity <= 1000){
            System.debug('One time process Strategy');
            // Process in a async one time process
        }	
        
        if(totalContactQuantity > 1000){
             System.debug('Batcheable Strategy');
            // Process in batchs of 150 records
           
            
        }	
        
    }
    
}