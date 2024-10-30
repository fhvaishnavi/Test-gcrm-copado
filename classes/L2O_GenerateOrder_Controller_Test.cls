@isTest
public class L2O_GenerateOrder_Controller_Test {
    
    public static Id pricebookId = Test.getStandardPricebookId();
    @isTest
    Private static void testGenerateOrder(){
        List<Account> accountList= APTS_TestDataUtility_Test.createAccount(true,1);
        Product2 parentProduct=new Product2();
        Id quoteId;
        Id oppId;
        List<Product2> childproducts=new List<Product2>();
        List<Opportunity> oppList = APTS_TestDataUtility_Test.createOpportunity(true,accountList);
        List<Contact> conList =  APTS_TestDataUtility_Test.createContact(true,accountList); 
        APTS_TestDataUtility_Test.createContactRoles(true,oppList,conList[0].id);
        List<Product2> testproducts=APTS_TestDataUtility_Test.createtestproducts();
        List<SBQQ__Quote__c> quotelist=APTS_TestDataUtility_Test.createQuote(true,oppList);
        for(SBQQ__Quote__c quoterec:quotelist)
        {
            quoteId=quoterec.Id; 
        }
        for(Product2 parprod:testproducts)
        {
            if(parprod.Name=='Mental Health Care (US)')
            {
                parentProduct=parprod;   
            }
            else
            {
                childproducts.add(parprod);   
            }
        }
        for(Opportunity opprec:oppList)
        {
            oppId=opprec.Id;  
        }
        List<SBQQ__ProductOption__c> testproductoptions=APTS_TestDataUtility_Test.createproductoptions(parentProduct,childproducts);
        List<SBQQ__QuoteLine__c> testQuoteLines=APTS_TestDataUtility_Test.createquotelines(quoteId,parentProduct.Id,testproductoptions);
        List<SBQQ__Quote__c> quotesToupdate = New List<SBQQ__Quote__c>();
        for(SBQQ__Quote__c quoteRecord:quotelist)
        {
            quoteRecord.SBQQ__Status__c = 'Accepted';
            quotesToupdate.add(quoteRecord);
        }
        update quotesToupdate;
        List<PricebookEntry> pricebookEntryList = new List<PricebookEntry>();
        for(Product2 objProd : testproducts)
        {
            PricebookEntry pbe1 = new PricebookEntry(
                Pricebook2Id = pricebookId,
                Product2Id = objProd.Id,
                UnitPrice = 1020,
                IsActive = true
            );
            pricebookEntryList.add(pbe1);
        }
        insert pricebookEntryList;
    
        Map<Id, Id> mapProdPbe = new Map<Id, Id>();
        for(PricebookEntry objPBE : pricebookEntryList)
        {
            mapProdPbe.put(objPBE.Product2Id, objPBE.Id);
        }

        for(Opportunity objOpp : oppList)
        {
            List<OpportunityLineItem> oppLineitems = New List<OpportunityLineItem>();
            for(SBQQ__QuoteLine__c quoteLine:testQuoteLines){
                OpportunityLineItem oppItem = New OpportunityLineItem();
                oppItem.SBQQ__QuoteLine__c =  quoteLine.Id;
                oppItem.OpportunityId = objOpp.Id;
                oppItem.L2O_Unit_Sell_Price__c = 20;
                oppItem.Quantity = 2;
                oppItem.TotalPrice = 40;
                oppItem.Product2Id = quoteLine.SBQQ__Product__c;
                oppItem.PricebookEntryId = mapProdPbe.get(quoteLine.SBQQ__Product__c);
                oppLineitems.add(oppItem);
            }
            insert oppLineitems;
        }

        oppList[0].StageName = 'Closed Won';
        oppList[0].L2O_Sub_Type_Detail__c = 'Reporting Purposes Only';
        update oppList;
        Contract contractList = L2O_DataFactoryTest.createContract(oppList,quotesToupdate,accountList[0].Id);
        
        Test.startTest();
        L2O_GenerateOrder_Controller.getContracts(oppList[0].Id);
        Test.stopTest(); 
        System.assertNotEquals(null, testQuoteLines, 'Records found successfully');
    }    
    
}