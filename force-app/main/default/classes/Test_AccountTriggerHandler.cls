@isTest
public class Test_AccountTriggerHandler {

	@testSetup 
    static void setup() {
		List<Account> accountList = new List<Account>();
        accountList.add(new Account(Name='accountName1'));
        accountList.add(new Account(Name='accountName2'));
         accountList.add(new Account(Name='accountName3'));
        accountList.add(new Account(Name='accountName4'));
    
		insert accountList;
                
        List<Contact> contactList = new List<Contact>();
        for(Integer i= 0; i < 1000; i++){
            contactList.add(new Contact(Firstname= 'Test1' + i, LastName= 'Test1'+i, accountId= accountList[0].id));
        }
		contactList.add(new Contact(Firstname= 'Test1', LastName= 'Test1', accountId= accountList[0].id));
        contactList.add(new Contact(Firstname= 'Test2', LastName= 'Test2', accountId= accountList[0].id));
        contactList.add(new Contact(Firstname= 'Test3', LastName= 'Test3', accountId= accountList[1].id));
        contactList.add(new Contact(Firstname= 'Test4', LastName= 'Test4', accountId= accountList[1].id));
        contactList.add(new Contact(Firstname= 'Test5', LastName= 'Test5', accountId= accountList[2].id));
        contactList.add(new Contact(Firstname= 'Test6', LastName= 'Test6', accountId= accountList[2].id));
        contactList.add(new Contact(Firstname= 'Test7', LastName= 'Test7', accountId= accountList[3].id));
        contactList.add(new Contact(Firstname= 'Test8', LastName= 'Test8', accountId= accountList[3].id));
		insert contactList;
	}
    
    @isTest
    private static void testAfterUpdate(){
        List<Account> accountsAfterModifications = [SELECT Id, Name, PushToVendor__c FROM Account WHERE Name LIKE '%accountName%'];
        List<contact> contactsAfterUpdateOfParentAccount;
        Test.startTest();
        	accountsAfterModifications[0].PushToVendor__c = 'Yes';
        	accountsAfterModifications[1].PushToVendor__c = 'No';
        	accountsAfterModifications[2].PushToVendor__c = 'Yes';
        	accountsAfterModifications[3].PushToVendor__c = 'No';
        	update accountsAfterModifications;
        Test.stopTest();
        
        contactsAfterUpdateOfParentAccount = [SELECT id, Name, Push_Date__c FROM Contact];
        
        System.debug(contactsAfterUpdateOfParentAccount);
        
        System.assertEquals(False, True, 'Testing, assertion not yet implemented');
    }
}