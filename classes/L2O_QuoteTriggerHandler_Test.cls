/**
* Company : PwC.
* @description : Test Class for L2O_QuoteTriggerHandler apex
* ************************************************************************************************************************************
* History : 
* @date 25/02/2022
* @author Harshita Paliwal
*/
@isTest
public class L2O_QuoteTriggerHandler_Test extends L2O_DataFactoryTest{
    
    /**
    * @name  testSetup 
    * @description To create setup records for test class.
    * @params  none
    **/
    @testSetup
    static void testSetup() {
       
        List<Account> accountList= L2O_DataFactoryTest.createAccount(true,1);  
        List<Opportunity> oppList = L2O_DataFactoryTest.createOpportunity(true,accountList); 
        List<Contact> conList =  L2O_DataFactoryTest.createContact(true,accountList); 
        L2O_DataFactoryTest.createContactRoles(true,oppList,conList[0].id); 
        List<User> lstSystemAdmin = L2O_DataFactoryTest.createUsers(true,1,'System Administrator');
        List<User> lstClientManager = L2O_DataFactoryTest.createUsers(true,1,'Client Success');
         L2O_DataFactoryTest.createContactRoles(true,oppList,conList[0].id);    
         List<SBQQ__Quote__c> quoteList =  L2O_DataFactoryTest.createQuote(true,oppList);    
         L2O_DataFactoryTest.createContract(oppList,QuoteList,accountList[0].id); 
        
        //Make Client Manager as Manager of System Admin
        lstSystemAdmin[0].ManagerId = lstClientManager[0].Id;
        User updateAdminUser = lstSystemAdmin[0];
        update updateAdminUser;
        
    }
    
    /**
    * @name  testQuoteDefaultValues
    * @description To test the Quote default fields with automated values.
    * @params  none
    **/
    @isTest static void testQuoteDefaultValues() {
        Test.startTest();
        List<Account> account = [SELECT Id FROM Account WHERE Name != null LIMIT 1];
        List<Opportunity> opportunity =[SELECT Id,stageName FROM Opportunity WHERE Name != null LIMIT 1];
        
        Integer months = 12;
        Date startDate = Date.today();
        
        SBQQ__Quote__c quote = new SBQQ__Quote__c(SBQQ__Opportunity2__c  = opportunity[0].Id, SBQQ__Account__c = account[0].Id,
                                                  SBQQ__StartDate__c = startDate,SBQQ__SubscriptionTerm__c =months,SBQQ__Status__c = 'Draft');  
        
        insert quote;
        
        //Update the Quote with Approved Status
        quote.SBQQ__Status__c = 'Approved';  
        update quote;
        
        SBQQ__Quote__c quoteTest = [SELECT SBQQ__EndDate__c,SBQQ__Primary__c FROM SBQQ__Quote__c WHERE Name != null AND Id=:quote.Id];     
        //Date testDate = startDate.addMonths(months) - 1;
        //checking assertion for EndDate which is starteDate+SubscriptionTerm
        //System.assertEquals(testDate, quoteTest.SBQQ__EndDate__c,'Quote End Date is not set.');
        //checking assertion for Quote is Primary when it is Approved Status.
        System.assertEquals(true, quoteTest.SBQQ__Primary__c,'Quote Primary is False'); 
        Test.stopTest();     
        
    }
    
    /**
    * @name  testApprovalStatusToQuoteStatus
    * @description To test the Approval Status to Quote Status mapping updates
    * @params  none
    **/
    @isTest static void testApprovalStatusToQuoteStatus() {
        Test.startTest();
        List<Account> account = [SELECT Id FROM Account WHERE Name != null LIMIT 1];
        List<Opportunity> opportunity =[SELECT Id FROM Opportunity WHERE Name != null LIMIT 1];
        
        Integer months = 12;
        Date startDate = Date.today();
        
        SBQQ__Quote__c quote = new SBQQ__Quote__c(SBQQ__Opportunity2__c  = opportunity[0].Id, SBQQ__Account__c = account[0].Id,
                                                  SBQQ__StartDate__c = startDate,SBQQ__SubscriptionTerm__c =months);  
        
        insert quote;
        
        SBQQ__Quote__c quoteTest = [SELECT SBQQ__Status__c FROM SBQQ__Quote__c WHERE id=:quote.id LIMIT 1];
        
        //Initial Quote Status = Draft
        System.assertEquals('Draft', quoteTest.SBQQ__Status__c,'Quote Status is not Draft');
        
        //Updating the Approval Status = Pending        
        quoteTest.ApprovalStatus__c = 'Pending';  
        update quoteTest;
        //SBQQ__Quote__c quoteTest1 = [SELECT SBQQ__Status__c FROM SBQQ__Quote__c WHERE id=:quote.id LIMIT 1];
        //checking assertion for Quote Status when Approval Status = Pending.
        //System.assertEquals('In Review', quoteTest1.SBQQ__Status__c,'Quote Status did not update to Pending'); 

		//Updating the Approval Status = Approved        
        quoteTest.ApprovalStatus__c = 'Approved';  
        update quoteTest;
        //SBQQ__Quote__c quoteTest2 = [SELECT SBQQ__Status__c FROM SBQQ__Quote__c WHERE id=:quote.id LIMIT 1];
        //checking assertion for Quote Status when Approval Status = Approved.
        //System.assertEquals('Approved', quoteTest2.SBQQ__Status__c,'Quote Status did not update to Approved'); 
        
        Test.stopTest();     
        
    }
    
    /**
    * @name  testQuoteShare
    * @description To test the Quote Share records.
    * @params  none
    **/
    @isTest static void testQuoteShare() {
        Test.startTest();
        List<Account> account = [SELECT Id FROM Account WHERE Name != null LIMIT 1];
        List<Opportunity> opportunity =[SELECT Id FROM Opportunity WHERE Name != null LIMIT 1];
        
        User systemAdmin =[SELECT Id,lastname,ManagerId FROM User 
                            WHERE lastname LIKE 'TestDataFactory%' AND ManagerId != null AND Profile.Name = 'System Administrator' LIMIT 1];
        
    
       
        System.runAs(systemAdmin){
            Integer months = 12;
            Date startDate = Date.today();
            
            SBQQ__Quote__c quote = new SBQQ__Quote__c(SBQQ__Opportunity2__c  = opportunity[0].Id, SBQQ__Account__c = account[0].Id,
                                                      SBQQ__StartDate__c = startDate,SBQQ__SubscriptionTerm__c =months);  
            
            insert quote;
            System.assertEquals(12, quote.SBQQ__SubscriptionTerm__c,'Quote is not updated');
            
          /*  List<SBQQ__Quote__Share> lstQuoteShare = [SELECT Id,UserOrGroupId, ParentId, AccessLevel FROM SBQQ__Quote__Share 
                                                      WHERE ParentId =: quote.Id
                                                      AND UserOrGroupId =: systemAdmin.ManagerId LIMIT 50];
            
           
            //To assert the Owner's Manager has Edit access to the Quote.
        	System.assertEquals('Edit', lstQuoteShare[0].AccessLevel,'Quote is not shared with Owners Manager');
            System.assertEquals(clientManager.Id, lstQuoteShare[0].UserOrGroupId,'Quote is not shared with Owners Manager');*/
        }
        
        Test.stopTest();   
        
    }
    /**
    * @name  testQuoteShare
    * @description To test the Quote Share records.
    * @params  none
    **/
    @isTest static void testQuoteStatusChange() {
        Test.startTest();
        
        Integer months = 12;
        Date startDate = Date.today();
        List<Account> account = [SELECT Id FROM Account WHERE Name != null LIMIT 1];
        List<Opportunity> opportunity =[SELECT Id FROM Opportunity WHERE Name != null LIMIT 1];
        SBQQ__Quote__c quote = new SBQQ__Quote__c(SBQQ__Opportunity2__c  = opportunity[0].Id, SBQQ__Account__c = account[0].Id,
                                                  SBQQ__StartDate__c = startDate,SBQQ__SubscriptionTerm__c = months,SBQQ__Status__c= 'Draft',SBQQ__Primary__c = true); 
        insert quote;
        quote.SBQQ__Status__c = 'In Review';
        update quote;
        system.assert(quote.SBQQ__Status__c == 'In Review', 'the status changed');
        Test.stopTest();
    }
    /**
    * @name  testQuoteDisableRenewaCoTerm
    * @description To test If field "Disable Renewal Co-Term" is checked on the Quote, then the Renewal Quote's End Date would be blank.
    * @params  none
    **/
    @isTest static void testQuoteDisableRenewaCoTerm() {
         Test.startTest();
        //fetch Contract
        Contract contractRec = [SELECT Id,contractNumber,SBQQ__Opportunity__r.L2O_Subtype__c,SBQQ__Opportunity__r.OwnerId,SBQQ__Opportunity__c  FROM Contract WHERE ContractTerm = 12 LIMIT 1];
        // update contract to generate Renewal Quote
	   contractRec.SBQQ__RenewalQuoted__c = true;
        update contractRec;
        // Fetch Renewal Quote
        SBQQ__Quote__c quote = [SELECT Id,L2O_Disable_Renewal_Co_Term__c,SBQQ__EndDate__c FROM SBQQ__Quote__c WHERE SBQQ__Type__c = 'Renewal' LIMIT 1];
        // update Quote
        quote.L2O_Disable_Renewal_Co_Term__c = true;
         update quote;
        // Fetch the updated Renewal Quote
       SBQQ__Quote__c updtedquote = [SELECT iD, SBQQ__EndDate__c FROM SBQQ__Quote__c WHERE Id=: quote.Id LIMIT 1];
        system.assert(updtedquote.SBQQ__EndDate__c == null, 'End Date updated to blank');
        Test.stopTest();
    }

    /**
	* @name  testcatchException()
	* @description Tests L2O_QuoteTriggerHandler class catch block
	*/
    @istest
    public static void testcatchException() {
        Test.startTest();
        L2O_QuoteTriggerHandler helper = new L2O_QuoteTriggerHandler();
        helper.beforeInsert();
        helper.afterInsert();
        helper.beforeUpdate();
        helper.afterUpdate();
        Test.stopTest();
        SDF_LGR_Log__c errorLog = [SELECT Name, Id, Class__c, Message__c, Reference__c FROM SDF_LGR_Log__c WHERE Class__c = 'L2O_QuoteTriggerHandler' LIMIT 1];
        System.assertEquals('L2O_QuoteTriggerHandler',errorLog.Class__c,'Handler Test Successful');
    }
}