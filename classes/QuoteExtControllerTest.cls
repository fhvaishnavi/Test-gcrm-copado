/**************************************************************************************************
* author        : Utkarsh Chaurasia
* date          : 10/03/2022
* Name          : QuoteExtControllerTest
* @description  : Test Class for QuoteExtController for enabling Quote Object Advanced Approval Process
* History       :
**************************************************************************************************/
@isTest
private class QuoteExtControllerTest {
    
    /**
     * @name  testSubmit()
     * @description To create test scenario on Submit action
     * @params  none
     */
    static testMethod void testSubmit() {
        List<Account> accountList= L2O_DataFactoryTest.createAccount(true,2);
        List<Contact> conList =  L2O_DataFactoryTest.createContact(true,accountList); 
        List<Opportunity> oppList =  L2O_DataFactoryTest.createOpportunity(true,accountList); 
        L2O_DataFactoryTest.createContactRoles(true,oppList,conList[0].id);    
        List<SBQQ__Quote__c> quoteList =  L2O_DataFactoryTest.createQuote(true,oppList);
        
        //SBQQ__Quote__c quote = new SBQQ__Quote__c();
        //insert quote;
        
        Test.startTest();
        QuoteExtController con = new QuoteExtController(new ApexPages.StandardController(quoteList[0]));
        con.onSubmit();
        SBQQ__Quote__c quote = [SELECT ApprovalStatus__c FROM SBQQ__Quote__c WHERE Id = :quoteList[0].Id LIMIT 1];
        Test.stopTest();
        
        System.assertEquals('Approved', quote.ApprovalStatus__c,'Quote is not Approved.');
    }
    
    /**
     * @name testRecall()
     * @description To create test scenario in Recall action
     * @params  none
     */
    static testMethod void testRecall() {
        List<Account> accountList= L2O_DataFactoryTest.createAccount(true,2);
        List<Contact> conList =  L2O_DataFactoryTest.createContact(true,accountList); 
        List<Opportunity> oppList =  L2O_DataFactoryTest.createOpportunity(true,accountList); 
        L2O_DataFactoryTest.createContactRoles(true,oppList,conList[0].id);    
        List<SBQQ__Quote__c> quoteList =  L2O_DataFactoryTest.createQuote(true,oppList);
        
        //SBQQ__Quote__c quote = new SBQQ__Quote__c();
        //insert quote;
        
        Test.startTest();
        QuoteExtController con = new QuoteExtController(new ApexPages.StandardController(quoteList[0]));
        con.onRecall();
        SBQQ__Quote__c quote = [SELECT ApprovalStatus__c FROM SBQQ__Quote__c WHERE Id = :quoteList[0].Id LIMIT 1];
        Test.stopTest();
        
        System.assertEquals('Recalled', quote.ApprovalStatus__c,'Quote is not successfully Recalled.');
    }
}