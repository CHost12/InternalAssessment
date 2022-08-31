public class AccountTriggerHandler extends TriggerHandler {
  
  	private Map<Id, Account> newAccounMap;
  	private List<Account> newAccountList;
    private Map<Id, Account> oldAccountMap;

  public AccountTriggerHandler() {
    this.newAccounMap = (Map<Id, Account>)Trigger.newMap;
    this.newAccountList = (List<Account>)Trigger.new;
    this.oldAccountMap = (Map<Id, Account>)Trigger.oldMap;
  }
  
  public override void afterUpdate() {
    Map<String,List<id>> yesAndNoAccounts = new Map<String,List<id>>();
      
    for (Account account: newAccountList) {
			if(account.PushToVendor__c != null) {
            	System.debug(account.PushToVendor__c);
				System.debug('DEBUG PushToVendor__c');
                
                if(account.PushToVendor__c == 'Yes'){
                    if(yesAndNoAccounts.get('Yes')?.size() > 0){
                         yesAndNoAccounts.get('Yes').add(account.id);
                        
                    }else {
                        yesAndNoAccounts.put('Yes',new List<Id>());
                        yesAndNoAccounts.get('Yes').add(account.id);
                    }
                }
                
                if(account.PushToVendor__c == 'No'){
                    if(yesAndNoAccounts.get('No')?.size() > 0){
                         yesAndNoAccounts.get('No').add(account.id);
                        
                    }else {
                        yesAndNoAccounts.put('No',new List<Id>());
                        yesAndNoAccounts.get('No').add(account.id);
                    }
                }
            }
    }
      
      AccountServices.processChildContacsOfAccountWithVendorYesOrNo(yesAndNoAccounts);

  }
        
}